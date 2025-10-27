package br.com.vagarin.api.comment;

import br.com.vagarin.api.user.UserResponseDTO;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class CommentResponseDTO {
    private Long id;
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