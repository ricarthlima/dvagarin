package br.com.vagarin.api.security;

import br.com.vagarin.api.exception.ErrorResponseDTO;
import br.com.vagarin.api.user.User;
import br.com.vagarin.api.user.UserRepository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Optional;

// 1. Component: Avisa ao Spring para gerenciar esta classe (para podermos injetar o UserRepository)
// 2. OncePerRequestFilter: Garante que o filtro rode apenas UMA VEZ por requisição
@Component
public class FirebaseTokenFilter extends OncePerRequestFilter {

    // 3. Injeta o repositório de usuário para buscarmos o usuário no NOSSO banco
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain)
            throws ServletException, IOException {

        String header = request.getHeader("Authorization");

        if (header == null || !header.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        String token = header.substring(7);

        try {
            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(token);
            String firebaseUid = decodedToken.getUid();
            Optional<User> userOptional = userRepository.findByFirebaseUid(firebaseUid);

            if (userOptional.isPresent()) {
                User user = userOptional.get();
                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null,
                        new ArrayList<>());
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }

        } catch (FirebaseAuthException e) {

            ErrorResponseDTO errorResponse = new ErrorResponseDTO(
                    HttpServletResponse.SC_UNAUTHORIZED, // 401
                    "Unauthorized",
                    "Token do Firebase inválido ou expirado: " + e.getMessage(),
                    request.getRequestURI());

            // Configura a resposta HTTP
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");

            // Escreve o JSON na resposta
            response.getWriter().write(objectMapper.writeValueAsString(errorResponse));

            // 5. PARA A EXECUÇÃO! Não chama o filterChain.doFilter()
            return;
        }

        filterChain.doFilter(request, response);
    }
}