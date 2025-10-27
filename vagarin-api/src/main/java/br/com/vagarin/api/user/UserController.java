package br.com.vagarin.api.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.vagarin.api.post.PostResponseDTO;
import java.time.LocalDate;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.security.core.annotation.AuthenticationPrincipal;

@RestController // 1. Avisa ao Spring que esta classe define Endpoints REST
@RequestMapping("/api/v1/users") // 2. Define o prefixo da URL para todos os endpoints desta classe
public class UserController {

    // 3. Injeta o "cérebro" (Service) que criamos
    @Autowired
    private UserService userService;

    // 4. Mapeia este método para requisições POST em /api/v1/users/register
    @PostMapping("/register")
    public ResponseEntity<User> registerUser(@RequestBody UserRegisterRequestDTO requestDTO) {
        // 5. @RequestBody: Converte o JSON que o Flutter enviar para o nosso DTO

        // 6. Chama o serviço para fazer a lógica e salvar no banco
        User createdUser = userService.registerNewUser(requestDTO);

        // 7. Retorna HTTP 201 (Created) com o usuário criado no corpo
        return ResponseEntity.status(201).body(createdUser);
    }

    /**
     * Endpoint para LISTAR posts de um usuário.
     * Se ?date= for fornecido, filtra por dia.
     * Se não, lista todos.
     */
    @GetMapping("/{userId}/posts")
    public ResponseEntity<?> getUserPosts( // 1. Mudei o nome do método
            @PathVariable Long userId,
            // 2. A MÁGICA: required = false
            @RequestParam(name = "date", required = false) LocalDate date) {

        List<PostResponseDTO> posts;

        // 3. Lógica condicional
        if (date != null) {
            // Se a data foi fornecida, usa o método antigo
            posts = userService.listUserPostsByDate(userId, date);
        } else {
            // Se a data for NULA, usa o novo método
            posts = userService.listAllUserPosts(userId);
        }

        return ResponseEntity.ok(posts);
    }

    /**
     * Endpoint para LER o perfil COMPLETO do usuário LOGADO
     * (Para a tela de "Configurações" ou "Meu Perfil")
     */
    @GetMapping("/me")
    public ResponseEntity<UserProfileResponseDTO> getMyProfile(
            @AuthenticationPrincipal User currentUser) {

        // O currentUser já vem do token (via @AuthenticationPrincipal)
        UserProfileResponseDTO profileDTO = new UserProfileResponseDTO(currentUser);
        return ResponseEntity.ok(profileDTO);
    }

    /**
     * Endpoint para ATUALIZAR o perfil do usuário LOGADO
     */
    @PutMapping("/me")
    public ResponseEntity<UserProfileResponseDTO> updateMyProfile(
            @AuthenticationPrincipal User currentUser,
            @RequestBody UserUpdateRequestDTO requestDTO) {

        // (Já limpamos o try-catch, o @ControllerAdvice cuida dos erros)
        User updatedUser = userService.updateUserProfile(currentUser, requestDTO);
        UserProfileResponseDTO profileDTO = new UserProfileResponseDTO(updatedUser);
        return ResponseEntity.ok(profileDTO);
    }

    /**
     * Endpoint para LER o perfil PÚBLICO de qualquer usuário
     * (Para visitar o perfil de alguém)
     */
    @GetMapping("/{username}")
    public ResponseEntity<UserResponseDTO> getUserProfileByUsername(
            @PathVariable String username) {

        UserResponseDTO profileDTO = userService.getUserPublicProfile(username);
        return ResponseEntity.ok(profileDTO);
    }

    @GetMapping("/nearby")
    public ResponseEntity<List<UserResponseDTO>> getNearbyUsers(
            @AuthenticationPrincipal User currentUser,
            @RequestParam(defaultValue = "5") double radiusKm) { // Padrão de 5km

        // (O @ControllerAdvice vai pegar erros se o usuário for nulo)

        List<UserResponseDTO> users = userService.findNearbyUsers(currentUser, radiusKm);
        return ResponseEntity.ok(users);
    }

    /**
     * Endpoint para BUSCAR usuários (por nome ou username)
     * Ex: /api/v1/users/search?query=ric
     */
    @GetMapping("/search")
    public ResponseEntity<List<UserResponseDTO>> searchUsers(
            @RequestParam("query") String query) {

        List<UserResponseDTO> users = userService.searchUsers(query);
        return ResponseEntity.ok(users);
    }
}