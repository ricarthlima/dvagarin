package br.com.vagarin.api.post;

import br.com.vagarin.api.comment.Comment;
import br.com.vagarin.api.reaction.Reaction;
import br.com.vagarin.api.user.User; // 1. Importe a entidade User
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "posts")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 2. RELACIONAMENTO: Muitos Posts para Um Usuário
    @ManyToOne(fetch = FetchType.LAZY) // LAZY = só carrega o usuário do banco quando pedirmos
    @JoinColumn(name = "author_id", nullable = false) // 3. Nome da Chave Estrangeira (FK)
    private User author;

    @Column(columnDefinition = "TEXT") // 4. Boa prática para textos longos (bio, content)
    private String content;

    // 5. COLEÇÃO DE ELEMENTOS: Para salvar listas de coisas simples (Strings)
    @ElementCollection
    @CollectionTable(name = "post_image_urls", joinColumns = @JoinColumn(name = "post_id"))
    @Column(name = "image_url", nullable = false)
    private List<String> imageUrls; // O Spring vai criar uma tabela separada para isso

    @ElementCollection
    @CollectionTable(name = "post_tags", joinColumns = @JoinColumn(name = "post_id"))
    @Column(name = "tag")
    private List<String> tags;

    // 6. MÁGICA: O Hibernate preenche a data de criação automaticamente
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    // 7. MÁGICA: O Hibernate atualiza a data de modificação automaticamente
    @UpdateTimestamp
    private LocalDateTime updatedAt;

    // (Junto com o @ManyToOne 'author')
    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<Reaction> reactions;

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<Comment> comments;
}