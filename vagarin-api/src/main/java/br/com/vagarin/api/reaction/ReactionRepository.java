package br.com.vagarin.api.reaction;

import br.com.vagarin.api.post.Post;
import br.com.vagarin.api.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ReactionRepository extends JpaRepository<Reaction, UUID> {

    // Método chave para o "toggle": Achar uma reação específica
    Optional<Reaction> findByUserAndPostAndType(User user, Post post, ReactionType type);

    // Método para pegar todas as reações de um post (para fazer a contagem)
    List<Reaction> findByPost(Post post);
}