package br.com.vagarin.api.reaction;

import java.util.UUID;

import br.com.vagarin.api.post.Post;
import br.com.vagarin.api.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "reactions", uniqueConstraints = {
        // A MÁGICA DA SUA LÓGICA ESTÁ AQUI:
        // Garante que a combinação (usuário + post + tipo) seja ÚNICA.
        @UniqueConstraint(columnNames = { "user_id", "post_id", "type" })
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reaction {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(columnDefinition = "uuid", updatable = false, nullable = false)
    private UUID id;

    // Quem reagiu
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // Em qual post
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

    // Com qual reação
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ReactionType type;
}