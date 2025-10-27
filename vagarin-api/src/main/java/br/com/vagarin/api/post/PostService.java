package br.com.vagarin.api.post;

import br.com.vagarin.api.exception.PermissionDeniedException;
import br.com.vagarin.api.exception.ResourceNotFoundException;
import br.com.vagarin.api.user.User;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PostService {

    @Autowired
    private PostRepository postRepository;

    // Nosso primeiro método de lógica protegida!
    public Post createPost(PostCreateRequestDTO requestDTO, User author) {

        // 1. Recebemos o DTO (do Flutter) e o User (do Token)

        Post newPost = new Post();
        newPost.setContent(requestDTO.getContent());
        newPost.setImageUrls(requestDTO.getImageUrls());
        newPost.setTags(requestDTO.getTags());

        // 2. A MÁGICA: Seta o usuário autenticado como o autor do post
        newPost.setAuthor(author);

        // 3. Salva o post no banco, já com o relacionamento correto
        return postRepository.save(newPost);
    }

    /**
     * Lógica para BUSCAR um Post único pelo ID
     */
    public Post findPostById(Long postId) {
        return postRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Post não encontrado")); // TODO: Exceção customizada
    }

    /**
     * Lógica para EDITAR um Post
     */
    public Post updatePost(Long postId, PostCreateRequestDTO requestDTO, User currentUser) {
        // 1. Busca o post
        Post post = findPostById(postId);

        // 2. Validação: O usuário logado é o AUTOR do post?
        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            throw new PermissionDeniedException("Você não tem permissão para editar este post");
        }

        // 3. Atualiza os campos
        post.setContent(requestDTO.getContent());
        post.setImageUrls(requestDTO.getImageUrls());
        post.setTags(requestDTO.getTags());
        // 'updatedAt' será atualizado automaticamente pelo @UpdateTimestamp

        // 4. Salva
        return postRepository.save(post);
    }

    /**
     * Lógica para DELETAR um Post
     */
    public void deletePost(Long postId, User currentUser) {
        // 1. Busca o post
        Post post = findPostById(postId);

        // 2. Validação: O usuário logado é o AUTOR do post?
        if (!post.getAuthor().getId().equals(currentUser.getId())) {
            throw new PermissionDeniedException("Você não tem permissão para deletar este post");
        }

        // 3. Deleta
        postRepository.delete(post);
    }

    /**
     * Lógica para BUSCAR posts por conteúdo ou tag
     */
    public List<PostResponseDTO> searchPosts(String query) {

        // 1. Chama o método do repositório
        List<Post> posts = postRepository
                .findDistinctByContentContainingIgnoreCaseOrTagsContainingIgnoreCaseAndAuthorConfigIsPrivateIsFalse(
                        query,
                        query);

        // 2. Converte para DTO
        return posts.stream()
                .map(PostResponseDTO::new)
                .collect(Collectors.toList());
    }
}