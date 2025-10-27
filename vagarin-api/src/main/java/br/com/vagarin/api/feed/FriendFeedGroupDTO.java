package br.com.vagarin.api.feed;

import br.com.vagarin.api.post.PostResponseDTO;
import br.com.vagarin.api.user.UserResponseDTO;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class FriendFeedGroupDTO {

    // O amigo que postou
    private UserResponseDTO friend;

    // A lista de posts dele (convertida para DTO)
    private List<PostResponseDTO> posts;

    // O timestamp do post MAIS RECENTE (para ordenarmos a lista de grupos)
    private LocalDateTime latestPostTimestamp;

    public FriendFeedGroupDTO(UserResponseDTO friend, List<PostResponseDTO> posts, LocalDateTime latestPostTimestamp) {
        this.friend = friend;
        this.posts = posts;
        this.latestPostTimestamp = latestPostTimestamp;
    }
}