package br.com.vagarin.api.feed;

import br.com.vagarin.api.post.PostResponseDTO;
import lombok.Data;

import java.util.List;

@Data
public class HomeFeedResponseDTO {

    // A lista de amigos, já agrupada e ordenada
    private List<FriendFeedGroupDTO> friendPosts;

    // A "apimentada": lista simples de posts próximos
    private List<PostResponseDTO> nearbyPosts;

    public HomeFeedResponseDTO(List<FriendFeedGroupDTO> friendPosts, List<PostResponseDTO> nearbyPosts) {
        this.friendPosts = friendPosts;
        this.nearbyPosts = nearbyPosts;
    }
}