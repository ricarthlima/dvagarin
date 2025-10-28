package br.com.vagarin.api.comment;

import br.com.vagarin.api.user.UserResponseDTO;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
public class CommentResponseDTO {
    private UUID id;
    private UserResponseDTO author;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public CommentResponseDTO(Comment comment) {
        this.id = comment.getId();
        this.author = new UserResponseDTO(comment.getAuthor());
        this.content = comment.getContent();
        this.createdAt = comment.getCreatedAt();
        this.updatedAt = comment.getUpdatedAt();
    }
}