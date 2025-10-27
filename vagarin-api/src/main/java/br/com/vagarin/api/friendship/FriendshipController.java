package br.com.vagarin.api.friendship;

import br.com.vagarin.api.user.User;
import br.com.vagarin.api.user.UserResponseDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/friends")
public class FriendshipController {

    @Autowired
    private FriendshipService friendshipService;

    @PostMapping("/request/{userId}")
    public ResponseEntity<?> sendRequest( // Mudei pra '?' pra caber o DTO ou a String de erro
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long userId) {

        try {
            Friendship newRequest = friendshipService.sendFriendRequest(currentUser, userId);

            // 2. CONVERTER PARA DTO ANTES DE RETORNAR
            FriendshipResponseDTO responseDTO = new FriendshipResponseDTO(newRequest);

            return ResponseEntity.status(201).body(responseDTO); // 3. RETORNAR O DTO
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @PostMapping("/accept/{requestId}")
    public ResponseEntity<?> acceptRequest( // Mudei pra '?'
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long requestId) {

        try {
            Friendship acceptedRequest = friendshipService.acceptFriendRequest(currentUser, requestId);

            // 4. CONVERTER PARA DTO
            FriendshipResponseDTO responseDTO = new FriendshipResponseDTO(acceptedRequest);

            return ResponseEntity.ok(responseDTO); // 5. RETORNAR O DTO
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    /**
     * Endpoint para REJEITAR um pedido de amizade
     * O {requestId} na URL é o ID da AMIZADE
     */
    @PostMapping("/reject/{requestId}")
    public ResponseEntity<?> rejectRequest(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long requestId) {

        try {
            Friendship rejectedRequest = friendshipService.rejectFriendRequest(currentUser, requestId);
            FriendshipResponseDTO responseDTO = new FriendshipResponseDTO(rejectedRequest);
            return ResponseEntity.ok(responseDTO);
        } catch (Exception e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    /**
     * Endpoint para LISTAR pedidos PENDENTES (que eu recebi)
     */
    @GetMapping("/requests")
    public ResponseEntity<List<FriendshipResponseDTO>> getPendingRequests(
            @AuthenticationPrincipal User currentUser) {

        List<FriendshipResponseDTO> requests = friendshipService.listPendingRequests(currentUser);
        return ResponseEntity.ok(requests);
    }

    /**
     * Endpoint para LISTAR meus AMIGOS (status ACEITO)
     */
    @GetMapping("/my-friends") // Mudei para /my-friends para não colidir com um futuro /users
    public ResponseEntity<List<UserResponseDTO>> getMyFriends(
            @AuthenticationPrincipal User currentUser) {

        List<UserResponseDTO> friends = friendshipService.listFriends(currentUser);
        return ResponseEntity.ok(friends);
    }
}