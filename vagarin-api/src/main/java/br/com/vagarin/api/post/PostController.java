package br.com.vagarin.api.post;

import br.com.vagarin.api.comment.CommentRequestDTO;
import br.com.vagarin.api.comment.CommentResponseDTO;
import br.com.vagarin.api.comment.CommentService;
import br.com.vagarin.api.reaction.ReactionRequestDTO;
import br.com.vagarin.api.reaction.ReactionService;
import br.com.vagarin.api.reaction.ReactionSummaryDTO;
import br.com.vagarin.api.user.User;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/api/v1/posts")
public class PostController {

    @Autowired
    private PostService postService;

    @Autowired
    private ReactionService reactionService;

    @Autowired
    private CommentService commentService;

    @PostMapping
    public ResponseEntity<PostResponseDTO> createPost(
            @RequestBody PostCreateRequestDTO requestDTO,
            @AuthenticationPrincipal User user) {

        Post createdPost = postService.createPost(requestDTO, user);
        PostResponseDTO responseDTO = new PostResponseDTO(createdPost);
        return ResponseEntity.status(201).body(responseDTO);
    }

    /**
     * Endpoint para BUSCAR um Post único
     * (Não precisa de autenticação para VER, por enquanto)
     */
    @GetMapping("/{postId}")
    public ResponseEntity<?> getPostById(@PathVariable UUID postId) {
        Post post = postService.findPostById(postId);
        PostResponseDTO responseDTO = new PostResponseDTO(post);
        return ResponseEntity.ok(responseDTO);
    }

    /**
     * Endpoint para EDITAR um Post
     * (Precisa ser o autor)
     */
    @PutMapping("/{postId}")
    public ResponseEntity<?> updatePost(
            @PathVariable UUID postId,
            @RequestBody PostCreateRequestDTO requestDTO,
            @AuthenticationPrincipal User currentUser) {

        Post updatedPost = postService.updatePost(postId, requestDTO, currentUser);
        PostResponseDTO responseDTO = new PostResponseDTO(updatedPost);
        return ResponseEntity.ok(responseDTO);
    }

    /**
     * Endpoint para DELETAR um Post
     * (Precisa ser o autor)
     */
    @DeleteMapping("/{postId}")
    public ResponseEntity<?> deletePost(
            @PathVariable UUID postId,
            @AuthenticationPrincipal User currentUser) {

        postService.deletePost(postId, currentUser);
        return ResponseEntity.noContent().build();
    }

    /**
     * Endpoint para "Toggle" (adicionar/remover) uma reação em um post
     */
    @PostMapping("/{postId}/react")
    public ResponseEntity<ReactionSummaryDTO> toggleReaction(
            @PathVariable UUID postId,
            @RequestBody ReactionRequestDTO requestDTO,
            @AuthenticationPrincipal User currentUser) {

        // (O GlobalExceptionHandler cuida dos erros 404/403)
        ReactionSummaryDTO summary = reactionService.toggleReaction(
                currentUser,
                postId,
                requestDTO.getType());
        return ResponseEntity.ok(summary);
    }

    /**
     * Endpoint para LER o resumo das reações de um post
     * (O Flutter vai chamar isso quando carregar o post)
     */
    @GetMapping("/{postId}/reactions")
    public ResponseEntity<ReactionSummaryDTO> getReactions(
            @PathVariable UUID postId,
            @AuthenticationPrincipal User currentUser) {

        ReactionSummaryDTO summary = reactionService.getReactionSummary(currentUser, postId);
        return ResponseEntity.ok(summary);
    }

    /**
     * Endpoint para BUSCAR posts (por conteúdo ou tag)
     * Ex: /api/v1/posts/search?query=flutter
     */
    @GetMapping("/search")
    public ResponseEntity<List<PostResponseDTO>> searchPosts(
            @RequestParam("query") String query) {

        List<PostResponseDTO> posts = postService.searchPosts(query);
        return ResponseEntity.ok(posts);
    }

    /**
     * Endpoint para CRIAR um novo comentário em um post
     */
    @PostMapping("/{postId}/comments")
    public ResponseEntity<CommentResponseDTO> createComment(
            @PathVariable UUID postId,
            @RequestBody CommentRequestDTO requestDTO,
            @AuthenticationPrincipal User currentUser) {

        // (GlobalExceptionHandler cuida dos erros 403, 404, etc)
        CommentResponseDTO newComment = commentService.createComment(
                currentUser, postId, requestDTO);
        return ResponseEntity.status(201).body(newComment);
    }

    /**
     * Endpoint para LISTAR os comentários de um post
     */
    @GetMapping("/{postId}/comments")
    public ResponseEntity<List<CommentResponseDTO>> listComments(
            @PathVariable UUID postId) {

        List<CommentResponseDTO> comments = commentService.listCommentsForPost(postId);
        return ResponseEntity.ok(comments);
    }
}