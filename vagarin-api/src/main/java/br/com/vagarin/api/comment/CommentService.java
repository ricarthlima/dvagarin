package br.com.vagarin.api.comment;

import br.com.vagarin.api.exception.PermissionDeniedException;
import br.com.vagarin.api.exception.ResourceNotFoundException;
import br.com.vagarin.api.friendship.Friendship;
import br.com.vagarin.api.friendship.FriendshipRepository;
import br.com.vagarin.api.friendship.FriendshipStatus;
import br.com.vagarin.api.post.Post;
import br.com.vagarin.api.post.PostRepository;
import br.com.vagarin.api.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private PostRepository postRepository;

    // 1. PRECISAMOS DISSO PARA A REGRA DE PRIVACIDADE!
    @Autowired
    private FriendshipRepository friendshipRepository;

    /**
     * REGRA 2: Helper para checar se o usuário pode comentar
     */
    private void checkCommentingPermission(User currentUser, Post post) {
        // Regra 2.1: O próprio dono pode comentar
        if (post.getAuthor().getId().equals(currentUser.getId())) {
            return;
        }

        // Regra 2.2: Checa se são amigos (em qualquer direção)

        // Direção 1: O usuário logado pediu o autor do post em amizade
        Optional<Friendship> f1 = friendshipRepository.findByRequesterAndReceiver(
                currentUser, post.getAuthor());

        // Checa se o pedido existe E se o status é ACCEPTED
        if (f1.isPresent() && f1.get().getStatus() == FriendshipStatus.ACCEPTED) {
            return; // São amigos, pode comentar.
        }

        // Direção 2: O autor do post pediu o usuário logado em amizade
        Optional<Friendship> f2 = friendshipRepository.findByRequesterAndReceiver(
                post.getAuthor(), currentUser);

        // Checa se o pedido existe E se o status é ACCEPTED
        if (f2.isPresent() && f2.get().getStatus() == FriendshipStatus.ACCEPTED) {
            return; // São amigos, pode comentar.
        }

        // Se chegou até aqui, não achou amizade ACEITA em nenhuma direção.
        throw new PermissionDeniedException("Apenas amigos do autor podem comentar neste post.");
    }

    /**
     * REGRA 1: Criar um comentário
     */
    public CommentResponseDTO createComment(User currentUser, UUID postId, CommentRequestDTO dto) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Post não encontrado"));

        // CHAMA A REGRA 2
        checkCommentingPermission(currentUser, post);

        Comment newComment = new Comment();
        newComment.setAuthor(currentUser);
        newComment.setPost(post);
        newComment.setContent(dto.getContent());

        Comment savedComment = commentRepository.save(newComment);
        return new CommentResponseDTO(savedComment);
    }

    /**
     * REGRA 5: Editar seu próprio comentário
     */
    public CommentResponseDTO updateComment(User currentUser, UUID commentId, CommentRequestDTO dto) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comentário não encontrado"));

        // Checa se o usuário logado é o AUTOR do comentário
        if (!comment.getAuthor().getId().equals(currentUser.getId())) {
            throw new PermissionDeniedException("Você só pode editar seus próprios comentários.");
        }

        comment.setContent(dto.getContent());
        Comment updatedComment = commentRepository.save(comment);
        return new CommentResponseDTO(updatedComment);
    }

    /**
     * REGRAS 3 & 4: Deletar um comentário
     */
    public void deleteComment(User currentUser, UUID commentId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comentário não encontrado"));

        boolean isAuthor = comment.getAuthor().getId().equals(currentUser.getId());
        boolean isPostOwner = comment.getPost().getAuthor().getId().equals(currentUser.getId());

        // REGRA 3 (Dono do post) ou REGRA 4 (Dono do comentário)
        if (isAuthor || isPostOwner) {
            commentRepository.delete(comment);
        } else {
            throw new PermissionDeniedException("Você não tem permissão para deletar este comentário.");
        }
    }

    /**
     * Lógica para LISTAR todos os comentários de um post
     */
    public List<CommentResponseDTO> listCommentsForPost(UUID postId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Post não encontrado"));

        // (Aqui estamos assumindo que se o usuário pode ver o post,
        // ele pode ver os comentários)

        List<Comment> comments = commentRepository.findByPostOrderByCreatedAtAsc(post);

        return comments.stream()
                .map(CommentResponseDTO::new)
                .collect(Collectors.toList());
    }
}