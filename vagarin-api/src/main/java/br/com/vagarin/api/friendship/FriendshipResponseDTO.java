package br.com.vagarin.api.friendship;

import br.com.vagarin.api.user.UserResponseDTO;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
public class FriendshipResponseDTO {

    private UUID id;
    private UserResponseDTO requester;
    private UserResponseDTO receiver;
    private FriendshipStatus status;
    private LocalDateTime createdAt;

    // Construtor para facilitar a conversão
    public FriendshipResponseDTO(Friendship friendship) {
        this.id = friendship.getId();
        this.requester = new UserResponseDTO(friendship.getRequester());
        this.receiver = new UserResponseDTO(friendship.getReceiver());
        this.status = friendship.getStatus();
        this.createdAt = friendship.getCreatedAt();
    }
}