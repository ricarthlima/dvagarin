package br.com.vagarin.api.friendship;

import br.com.vagarin.api.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "friendships")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Friendship {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 1. Relacionamento: Quem PEDIU a amizade
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "requester_id", nullable = false)
    private User requester;

    // 2. Relacionamento: Quem RECEBEU o pedido
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "receiver_id", nullable = false)
    private User receiver;

    // 3. Status da amizade, usando o Enum
    @Enumerated(EnumType.STRING) // Salva "PENDING" no banco em vez de 0
    @Column(nullable = false)
    private FriendshipStatus status;

    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    // 4. (Opcional, mas útil) Um índice único para garantir que
    // o Usuário A não possa pedir o Usuário B em amizade duas vezes.
    @Table(uniqueConstraints = {
            @UniqueConstraint(columnNames = { "requester_id", "receiver_id" })
    })
    public static class UniqueRequestConstraint {
    } // Apenas uma classe placeholder
}