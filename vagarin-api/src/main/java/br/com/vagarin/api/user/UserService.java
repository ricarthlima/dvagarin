package br.com.vagarin.api.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.vagarin.api.device.UserDevice;
import br.com.vagarin.api.device.UserDeviceRepository;
import br.com.vagarin.api.exception.PermissionDeniedException;
import br.com.vagarin.api.exception.ResourceNotFoundException;
import br.com.vagarin.api.friendship.Friendship;
import br.com.vagarin.api.friendship.FriendshipRepository;
import br.com.vagarin.api.friendship.FriendshipStatus;
import br.com.vagarin.api.post.Post;
import br.com.vagarin.api.post.PostRepository;
import br.com.vagarin.api.post.PostResponseDTO;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;

import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.PrecisionModel;

import java.util.Optional;
import java.util.UUID;

@Service // 1. Avisa ao Spring que esta classe é um Serviço (lógica de negócios)
public class UserService {

    // 2. Injeção de Dependência: Pede ao Spring para "injetar"
    // uma instância do UserRepository aqui.
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private UserDeviceRepository userDeviceRepository;

    @Autowired
    private FriendshipRepository friendshipRepository;

    private final GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);

    // 3. Nosso primeiro método de lógica!
    public User registerNewUser(UserRegisterRequestDTO requestDTO) {

        // 1. Validação: O firebaseUid já existe?
        Optional<User> existingUid = userRepository.findByFirebaseUid(requestDTO.getFirebaseUid());
        if (existingUid.isPresent()) {
            // Lança um erro que o GlobalExceptionHandler vai pegar como 400
            throw new IllegalArgumentException("Este usuário do Firebase (UID) já está registrado.");
        }

        // 2. Validação: O username já existe?
        Optional<User> existingUsername = userRepository.findByUsername(requestDTO.getUsername());
        if (existingUsername.isPresent()) {
            throw new IllegalArgumentException("Este nome de usuário já está em uso. Por favor, escolha outro.");
        }

        // 3. Converte o DTO (dados da API) para a Entidade (dados do Banco)
        User newUser = new User();
        newUser.setFirebaseUid(requestDTO.getFirebaseUid());
        newUser.setUsername(requestDTO.getUsername());
        newUser.setName(requestDTO.getName());
        newUser.setDateOfBirth(requestDTO.getDateOfBirth());
        newUser.setBio(requestDTO.getBio());
        newUser.setProfilePictureUrl(requestDTO.getProfilePictureUrl());
        newUser.setPhoneNumber(requestDTO.getPhoneNumber());

        // As configs (isPrivate, etc.) já têm valores padrão definidos na Entidade.

        // 4. Salva o novo usuário no banco de dados!
        return userRepository.save(newUser);
    }

    /**
     * Lógica para LISTAR posts de um usuário em um dia específico
     */
    public List<PostResponseDTO> listUserPostsByDate(UUID userId, LocalDate date) {
        // 1. Acha o usuário (autor)
        User author = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado"));

        // 2. Define o início (00:00:00) e o fim (23:59:59) do dia
        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.atTime(LocalTime.MAX);

        // 3. Usa o método mágico do repositório
        List<Post> posts = postRepository.findByAuthorAndCreatedAtBetween(
                author,
                startOfDay,
                endOfDay);

        // 4. Converte para DTO
        return posts.stream()
                .map(PostResponseDTO::new)
                .collect(Collectors.toList());
    }

    /**
     * Lógica para LISTAR TODOS os posts de um usuário
     */
    public List<PostResponseDTO> listAllUserPosts(UUID userId) {
        // 1. Acha o usuário (autor)
        User author = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado"));

        // 2. Usa o método mágico do repositório (ordenado do mais novo pro mais antigo)
        List<Post> posts = postRepository.findByAuthorOrderByCreatedAtDesc(author);

        // 3. Converte para DTO
        return posts.stream()
                .map(PostResponseDTO::new)
                .collect(Collectors.toList());
    }

    /**
     * Lógica para ATUALIZAR o perfil do usuário logado
     */
    public User updateUserProfile(User currentUser, UserUpdateRequestDTO dto) {

        // Validação de Username (essa lógica já estava certa)
        if (dto.getUsername() != null && !dto.getUsername().equals(currentUser.getUsername())) {
            Optional<User> userWithNewUsername = userRepository.findByUsername(dto.getUsername());
            if (userWithNewUsername.isPresent()) {
                throw new IllegalArgumentException("Este nome de usuário já está em uso.");
            }
            currentUser.setUsername(dto.getUsername());
        }

        // --- ATUALIZAÇÕES PARCIAIS ---
        // Só atualiza se o campo veio no JSON (não é nulo)

        if (dto.getName() != null) {
            currentUser.setName(dto.getName());
        }
        if (dto.getDateOfBirth() != null) {
            currentUser.setDateOfBirth(dto.getDateOfBirth());
        }
        if (dto.getBio() != null) {
            currentUser.setBio(dto.getBio());
        }
        if (dto.getProfilePictureUrl() != null) {
            currentUser.setProfilePictureUrl(dto.getProfilePictureUrl());
        }
        if (dto.getPhoneNumber() != null) {
            currentUser.setPhoneNumber(dto.getPhoneNumber());
        }

        if (dto.getLatitude() != null && dto.getLongitude() != null) {
            // PostGIS usa (Longitude, Latitude) - INVERTIDO!
            Point newLocation = geometryFactory.createPoint(
                    new Coordinate(dto.getLongitude(), dto.getLatitude()));
            currentUser.setLocation(newLocation);
        }

        if (dto.getConfigShowProximity() != null) {
            currentUser.setConfigShowProximity(dto.getConfigShowProximity());
        }
        if (dto.getConfigIsPrivate() != null) {
            currentUser.setConfigIsPrivate(dto.getConfigIsPrivate());
        }
        if (dto.getConfigNotifyReactions() != null) {
            currentUser.setConfigNotifyReactions(dto.getConfigNotifyReactions());
        }
        if (dto.getConfigNotifyFriendPosts() != null) {
            currentUser.setConfigNotifyFriendPosts(dto.getConfigNotifyFriendPosts());
        }
        if (dto.getConfigNotifyPostReminder() != null) {
            currentUser.setConfigNotifyPostReminder(dto.getConfigNotifyPostReminder());
        }
        if (dto.getConfigNotifyNewFriendRequests() != null) {
            currentUser.setConfigNotifyNewFriendRequests(dto.getConfigNotifyNewFriendRequests());
        }

        // Salva e retorna o usuário atualizado
        return userRepository.save(currentUser);
    }

    /**
     * Lógica para buscar um perfil público (para visitar o perfil de outro)
     */
    public UserResponseDTO getUserPublicProfile(String username, User currentUser) {
        // 1. Acha o perfil que está sendo visitado
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado"));

        // REGRA 1: O perfil NÃO é privado?
        // Se não for privado, pode retornar direto.
        if (!user.isConfigIsPrivate()) {
            return new UserResponseDTO(user);
        }

        // Se chegou aqui, o PERFIL É PRIVADO.
        // Precisamos checar se o visitante (currentUser) tem permissão.

        // REGRA 2: O visitante está logado?
        // Se não está logado (currentUser == null) e o perfil é privado, barra.
        if (currentUser == null) {
            throw new PermissionDeniedException("Este perfil é privado e você não está logado.");
        }

        // REGRA 3: O visitante é o PRÓPRIO dono do perfil?
        // Se for, pode ver.
        if (currentUser.getId().equals(user.getId())) {
            return new UserResponseDTO(user);
        }

        // REGRA 4: O visitante é AMIGO do dono do perfil?
        // (Lógica que já usamos no CommentService)
        Optional<Friendship> f1 = friendshipRepository.findByRequesterAndReceiver(currentUser, user);
        Optional<Friendship> f2 = friendshipRepository.findByRequesterAndReceiver(user, currentUser);

        boolean areFriends = (f1.isPresent() && f1.get().getStatus() == FriendshipStatus.ACCEPTED) ||
                (f2.isPresent() && f2.get().getStatus() == FriendshipStatus.ACCEPTED);

        if (areFriends) {
            return new UserResponseDTO(user);
        }

        // Se chegou até aqui, o perfil é privado e o visitante não é o dono nem é
        // amigo.
        throw new PermissionDeniedException("Este perfil é privado.");
    }

    public List<UserResponseDTO> findNearbyUsers(User currentUser, double radiusKm) {

        if (currentUser.getLocation() == null) {
            // Se o usuário logado não tem localização, retorna lista vazia
            return List.of();
        }

        // 1. Converte o raio de KM para METROS (PostGIS usa metros)
        double radiusMeters = radiusKm * 1000;

        // 2. Chama o repositório
        List<User> nearbyUsers = userRepository.findNearbyUsers(
                currentUser.getLocation(),
                radiusMeters,
                currentUser.getId());

        // 3. Converte para DTO
        return nearbyUsers.stream()
                .map(UserResponseDTO::new)
                .collect(Collectors.toList());
    }

    /**
     * Lógica para BUSCAR usuários por nome ou username
     */
    public List<UserResponseDTO> searchUsers(String query) {

        // 1. Chama o método do repositório, passando a query para os dois campos
        List<User> users = userRepository
                .findByNameContainingIgnoreCaseOrUsernameContainingIgnoreCaseAndConfigIsPrivateIsFalse(
                        query,
                        query);

        // 2. Converte para DTO
        return users.stream()
                .map(UserResponseDTO::new)
                .collect(Collectors.toList());
    }

    public void registerDevice(User currentUser, String fcmToken) {
        // Procura se esse token JÁ existe
        Optional<UserDevice> existingDevice = userDeviceRepository.findByFcmToken(fcmToken);

        if (existingDevice.isPresent()) {
            // Já existe. Só atualiza o dono e o lastLogin (caso o usuário tenha trocado de
            // conta)
            UserDevice device = existingDevice.get();
            device.setUser(currentUser);
            // lastLogin é atualizado pelo @UpdateTimestamp
            userDeviceRepository.save(device);
        } else {
            // Não existe. Cria um novo.
            UserDevice newDevice = new UserDevice(null, currentUser, fcmToken, null);
            userDeviceRepository.save(newDevice);
        }
    }
}