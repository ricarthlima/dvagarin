package br.com.vagarin.api.comment;

import br.com.vagarin.api.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/comments") // Rota base para comentários
public class CommentController {

    @Autowired
    private CommentService commentService;

    /**
     * Endpoint para EDITAR um comentário existente
     */
    @PutMapping("/{commentId}")
    public ResponseEntity<CommentResponseDTO> updateComment(
            @PathVariable Long commentId,
            @RequestBody CommentRequestDTO requestDTO,
            @AuthenticationPrincipal User currentUser) {

        CommentResponseDTO updatedComment = commentService.updateComment(
                currentUser, commentId, requestDTO);
        return ResponseEntity.ok(updatedComment);
    }

    /**
     * Endpoint para DELETAR um comentário
     */
    @DeleteMapping("/{commentId}")
    public ResponseEntity<?> deleteComment(
            @PathVariable Long commentId,
            @AuthenticationPrincipal User currentUser) {

        commentService.deleteComment(currentUser, commentId);
        return ResponseEntity.noContent().build(); // 204
    }
}