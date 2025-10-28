package br.com.vagarin.api.config;

// 1. Importe o filtro que acabamos de criar
import br.com.vagarin.api.security.FirebaseTokenFilter;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityScheme;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
// 2. Importe este
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@SecurityScheme(name = SecurityConfig.SECURITY, type = SecuritySchemeType.HTTP, bearerFormat = "JWT", scheme = "bearer")
public class SecurityConfig {
    public static final String SECURITY = "bearerAuth";

    // 3. Injeta o nosso filtro
    @Autowired
    private FirebaseTokenFilter firebaseTokenFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(authorize -> authorize
                        // 4. Mantém o endpoint de registro público
                        .requestMatchers(HttpMethod.POST, "/api/v1/users/register").permitAll()

                        // 2. Endpoints do Swagger (para ver a documentação)
                        .requestMatchers("/swagger-ui.html", "/swagger-ui/**", "/v3/api-docs/**").permitAll()

                        // 5. MUDANÇA IMPORTANTE:
                        // Agora, qualquer outra requisição DEVE estar autenticada
                        .anyRequest().authenticated())
                // 6. ADICIONA O NOSSO FILTRO!
                // Diz ao Spring para rodar o 'firebaseTokenFilter' ANTES do filtro
                // padrão de login (UsernamePasswordAuthenticationFilter)
                .addFilterBefore(firebaseTokenFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}