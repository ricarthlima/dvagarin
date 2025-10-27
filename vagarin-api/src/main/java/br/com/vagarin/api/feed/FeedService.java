package br.com.vagarin.api.feed;

import br.com.vagarin.api.friendship.Friendship;
import br.com.vagarin.api.friendship.FriendshipRepository;
import br.com.vagarin.api.friendship.FriendshipStatus;
import br.com.vagarin.api.post.Post;
import br.com.vagarin.api.post.PostRepository;
import br.com.vagarin.api.post.PostResponseDTO;
import br.com.vagarin.api.user.User;
import br.com.vagarin.api.user.UserResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class FeedService {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private FriendshipRepository friendshipRepository;

    // Raio padrão para posts próximos (ex: 5km)
    private static final double NEARBY_RADIUS_METERS = 5000;

    public HomeFeedResponseDTO getHomeFeed(User currentUser, LocalDate date) {

        LocalDateTime startOfDay = date.atStartOfDay();
        LocalDateTime endOfDay = date.atTime(LocalTime.MAX);

        // --- PARTE 1: POSTS DOS AMIGOS ---

        // 1. Acha todos os amigos (como objetos User)
        List<Friendship> friendships = friendshipRepository.findAllByStatusAndRequesterOrReceiver(
                FriendshipStatus.ACCEPTED, currentUser, currentUser);

        // 2. Extrai os IDs e os objetos User dos amigos
        Set<Long> friendIds = friendships.stream()
                .map(f -> f.getRequester().getId().equals(currentUser.getId()) ? f.getReceiver().getId()
                        : f.getRequester().getId())
                .collect(Collectors.toSet());

        List<User> friends = friendships.stream()
                .map(f -> f.getRequester().getId().equals(currentUser.getId()) ? f.getReceiver() : f.getRequester())
                .collect(Collectors.toList());

        // 3. Monta os grupos de posts de amigos
        List<FriendFeedGroupDTO> friendGroups = new ArrayList<>();
        for (User friend : friends) {
            // 4. Busca os posts do amigo (JÁ ORDENADOS pelo repo)
            List<Post> posts = postRepository.findByAuthorAndCreatedAtBetweenOrderByCreatedAtDesc(
                    friend, startOfDay, endOfDay);

            if (!posts.isEmpty()) {
                // 5. Se ele postou, cria o grupo
                List<PostResponseDTO> postDTOs = posts.stream()
                        .map(PostResponseDTO::new)
                        .collect(Collectors.toList());

                // 6. Pega o timestamp do post mais recente (é o primeiro da lista)
                LocalDateTime latestTimestamp = posts.get(0).getCreatedAt();

                friendGroups.add(new FriendFeedGroupDTO(
                        new UserResponseDTO(friend),
                        postDTOs,
                        latestTimestamp));
            }
        }

        // 7. ORDENA os GRUPOS pelo post mais recente
        friendGroups.sort(Comparator.comparing(FriendFeedGroupDTO::getLatestPostTimestamp).reversed());

        // --- PARTE 2: POSTS PRÓXIMOS (A "APIMENTADA") ---

        List<PostResponseDTO> nearbyPostDTOs = new ArrayList<>();

        // Só busca posts próximos se o usuário tiver uma localização salva
        if (currentUser.getLocation() != null) {

            // 8. Busca TODOS os posts próximos (de amigos ou não)
            List<Post> nearbyPosts = postRepository.findNearbyPostsForFeed(
                    currentUser.getLocation(),
                    NEARBY_RADIUS_METERS,
                    currentUser.getId(),
                    startOfDay,
                    endOfDay);

            // 9. FILTRA: Remove posts de pessoas que JÁ SÃO AMIGAS
            List<Post> nonFriendNearbyPosts = nearbyPosts.stream()
                    .filter(post -> !friendIds.contains(post.getAuthor().getId()))
                    .collect(Collectors.toList());

            // 10. Converte para DTO
            nearbyPostDTOs = nonFriendNearbyPosts.stream()
                    .map(PostResponseDTO::new)
                    .collect(Collectors.toList());
        }

        // --- PARTE 3: Monta a resposta final ---
        return new HomeFeedResponseDTO(friendGroups, nearbyPostDTOs);
    }
}