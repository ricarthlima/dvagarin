package br.com.vagarin.api.user;

import br.com.vagarin.api.comment.Comment;
import br.com.vagarin.api.device.UserDevice;
import br.com.vagarin.api.friendship.Friendship;

import lombok.ToString;
import java.util.List;
import java.util.UUID;

import jakarta.persistence.OneToMany;
import jakarta.persistence.CascadeType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import org.locationtech.jts.geom.Point;

import java.time.LocalDate;

import br.com.vagarin.api.post.Post;
import br.com.vagarin.api.reaction.Reaction;

@Entity // 1. Avisa ao JPA que esta classe é uma tabela
@Table(name = "users") // 2. Diz o nome da tabela no banco (boa prática ser no plural)
@Data // 3. (Lombok) Cria Getters, Setters, equals, hashCode e toString (mágica!)
@NoArgsConstructor // 4. (Lombok) Cria um construtor vazio (obrigatório pelo JPA)
@AllArgsConstructor // 5. (Lombok) Cria um construtor com todos os campos
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID) // <-- MUDANÇA 1
    @Column(columnDefinition = "uuid", updatable = false, nullable = false) // <-- Boa prática
    private UUID id;

    // 8. Chave do Firebase (MUITO IMPORTANTE)
    @Column(nullable = false, unique = true)
    private String firebaseUid;

    // 9. O @Column ajuda a definir regras (ex: não pode ser nulo, deve ser único)
    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String name;

    private LocalDate dateOfBirth; // O JPA converte tipos Java (LocalDate) para SQL (date)

    private String bio;

    private String profilePictureUrl;

    private String phoneNumber;

    @Column(columnDefinition = "geography(Point,4326)")
    private Point location;

    // --- Configurações de Privacidade e Notificação ---
    // Em Java, o padrão de 'boolean' é 'false', o que é ótimo para nós.
    private boolean configShowProximity = false;
    private boolean configIsPrivate = false;
    private boolean configNotifyReactions = true;
    private boolean configNotifyFriendPosts = true;
    private boolean configNotifyPostReminder = false;
    private boolean configNotifyNewFriendRequests = true;

    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<Post> posts;

    // Relacionamento: Pedidos de amizade que EU ENVIEI
    @OneToMany(mappedBy = "requester", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude // Importante para evitar o mesmo erro de LazyInit!
    private List<Friendship> sentFriendRequests;

    // Relacionamento: Pedidos de amizade que EU RECEBI
    @OneToMany(mappedBy = "receiver", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude // Importante para evitar o mesmo erro de LazyInit!
    private List<Friendship> receivedFriendRequests;

    // (Junto com as outras listas, 'posts', 'sentFriendRequests', etc.)
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<Reaction> reactions;

    // (Junto com as outras listas: posts, reactions, etc.)
    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<Comment> comments;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<UserDevice> devices;
}