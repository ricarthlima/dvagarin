package br.com.vagarin.api.friendship;

import br.com.vagarin.api.exception.PermissionDeniedException;
import br.com.vagarin.api.exception.ResourceNotFoundException;
import br.com.vagarin.api.user.User;
import br.com.vagarin.api.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.vagarin.api.user.UserResponseDTO;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class FriendshipService {

    @Autowired
    private FriendshipRepository friendshipRepository;

    @Autowired
    private UserRepository userRepository; // 1. Precisamos dele para achar o "amigo"

    /**
     * Lógica para ENVIAR um pedido de amizade
     * 
     * @param requester  O usuário LOGADO (do token) que está pedindo
     * @param receiverId O ID do usuário que vai RECEBER o pedido
     * @return O objeto Friendship criado
     */
    public Friendship sendFriendRequest(User requester, Long receiverId) {

        // 1. Busca o usuário que vai receber o pedido no banco
        User receiver = userRepository.findById(receiverId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário receptor não encontrado"));

        // 2. Validações
        if (requester.getId().equals(receiverId)) {
            throw new ResourceNotFoundException("Você não pode adicionar a si mesmo!");
        }

        // TODO: Checar se já existe um pedido (findByRequesterAndReceiver)

        // 3. Cria o novo registro de amizade
        Friendship newRequest = new Friendship();
        newRequest.setRequester(requester);
        newRequest.setReceiver(receiver);
        newRequest.setStatus(FriendshipStatus.PENDING);
        // createdAt é automático

        // 4. Salva no banco
        return friendshipRepository.save(newRequest);
    }

    /**
     * Lógica para ACEITAR um pedido de amizade
     * 
     * @param currentUser O usuário LOGADO (do token)
     * @param requestId   O ID do PEDIDO DE AMIZADE (não o ID do usuário)
     * @return O objeto Friendship atualizado
     */
    public Friendship acceptFriendRequest(User currentUser, Long requestId) {

        // 1. Busca o PEDIDO de amizade pelo ID
        Friendship request = friendshipRepository.findById(requestId)
                .orElseThrow(() -> new RuntimeException("Pedido de amizade não encontrado"));

        // 2. Validação: A pessoa que está aceitando é MESMO quem recebeu o pedido?
        if (!request.getReceiver().getId().equals(currentUser.getId())) {
            throw new PermissionDeniedException("Você não tem permissão para aceitar este pedido"); // TODO: Exceção
                                                                                                    // customizada
        }

        // 3. Validação: O pedido ainda está pendente?
        if (request.getStatus() != FriendshipStatus.PENDING) {
            throw new ResourceNotFoundException("Este pedido não está mais pendente");
        }

        // 4. Atualiza o status
        request.setStatus(FriendshipStatus.ACCEPTED);

        // 5. Salva a atualização no banco
        return friendshipRepository.save(request);
    }

    /**
     * Lógica para REJEITAR um pedido de amizade
     */
    public Friendship rejectFriendRequest(User currentUser, Long requestId) {

        // 1. Busca o PEDIDO de amizade pelo ID
        Friendship request = friendshipRepository.findById(requestId)
                .orElseThrow(() -> new ResourceNotFoundException("Pedido de amizade não encontrado"));

        // 2. Validação: A pessoa que está rejeitando é MESMO quem recebeu o pedido?
        if (!request.getReceiver().getId().equals(currentUser.getId())) {
            throw new PermissionDeniedException("Você não tem permissão para rejeitar este pedido");
        }

        // 3. Validação: O pedido ainda está pendente?
        if (request.getStatus() != FriendshipStatus.PENDING) {
            throw new ResourceNotFoundException("Este pedido não está mais pendente");
        }

        // 4. Atualiza o status
        request.setStatus(FriendshipStatus.REJECTED);

        // 5. Salva a atualização no banco
        return friendshipRepository.save(request);
    }

    /**
     * Lógica para LISTAR pedidos PENDENTES (que eu recebi)
     */
    public List<FriendshipResponseDTO> listPendingRequests(User currentUser) {

        // 1. Busca no repositório (método que já criamos!)
        List<Friendship> requests = friendshipRepository.findByReceiverAndStatus(
                currentUser,
                FriendshipStatus.PENDING);

        // 2. Converte a Lista de Entidades para uma Lista de DTOs
        return requests.stream()
                .map(FriendshipResponseDTO::new) // O mesmo que .map(f -> new FriendshipResponseDTO(f))
                .collect(Collectors.toList());
    }

    /**
     * Lógica para LISTAR meus AMIGOS (pedidos ACEITOS)
     */
    public List<UserResponseDTO> listFriends(User currentUser) {

        // 1. Busca no repositório (método que já criamos!)
        // Pega todos os registros ACEITOS onde eu sou ou o requester OU o receiver
        List<Friendship> acceptedFriendships = friendshipRepository.findByRequesterOrReceiverAndStatus(
                currentUser,
                currentUser,
                FriendshipStatus.ACCEPTED);

        // 2. Mapeia a lista de "Amizades" para uma lista de "Usuários"
        // (Extrai o "outro lado" da amizade)
        return acceptedFriendships.stream().map(friendship -> {
            // Se eu sou o requester, meu amigo é o receiver
            if (friendship.getRequester().getId().equals(currentUser.getId())) {
                return new UserResponseDTO(friendship.getReceiver());
            } else {
                // Se eu sou o receiver, meu amigo é o requester
                return new UserResponseDTO(friendship.getRequester());
            }
        }).collect(Collectors.toList());
    }
}