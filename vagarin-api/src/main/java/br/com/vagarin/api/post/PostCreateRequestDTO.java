package br.com.vagarin.api.post;

import lombok.Data;
import java.util.List;

// DTO para a requisição de criação de Post
// Só os dados que o Flutter vai enviar

@Data
public class PostCreateRequestDTO {

    private String content;
    private List<String> imageUrls;
    private List<String> tags;

    // Note que não temos 'authorId'.
    // Vamos pegar o autor do TOKEN de autenticação!
}