package br.com.vagarin.api.post;

import br.com.vagarin.api.user.UserResponseDTO;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
public class PostResponseDTO {
    private UUID id;
    private String content;
    private List<String> imageUrls;
    private List<String> tags;
    private LocalDateTime createdAt;
    private UserResponseDTO author; // <-- Usa o DTO de usuário!

    // Construtor para facilitar
    public PostResponseDTO(Post post) {
        this.id = post.getId();
        this.content = post.getContent();
        this.imageUrls = post.getImageUrls();
        this.tags = post.getTags();
        this.createdAt = post.getCreatedAt();
        this.author = new UserResponseDTO(post.getAuthor()); // Converte o User em DTO
    }
}