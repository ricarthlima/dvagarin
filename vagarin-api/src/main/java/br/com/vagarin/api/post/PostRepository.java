package br.com.vagarin.api.post;

import br.com.vagarin.api.user.User;

import org.locationtech.jts.geom.Point;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface PostRepository extends JpaRepository<Post, UUID> {
        // JpaRepository<Entidade, TipoDoId>

        // Método mágico para o seu feed diário:
        // "Encontre Posts Por Autor E Por 'CreatedAt' Entre (data de início) E (data de
        // fim)"
        List<Post> findByAuthorAndCreatedAtBetween(User author, LocalDateTime start, LocalDateTime end);

        // Método para a "Lista de posts" de um usuário (talvez ordenado)
        List<Post> findByAuthorOrderByCreatedAtDesc(User author);

        /**
         * "Encontre por (Conteúdo Contendo Ignorando Case) OU (Tags Contendo Ignorando
         * Case)
         * E (O Autor.configIsPrivate é Falso)"
         * O 'Distinct' evita posts duplicados se a query bater no content E na tag.
         */
        List<Post> findDistinctByContentContainingIgnoreCaseOrTagsContainingIgnoreCaseAndAuthorConfigIsPrivateIsFalse(
                        String contentQuery,
                        String tagQuery);

        List<Post> findByAuthorAndCreatedAtBetweenOrderByCreatedAtDesc(User author, LocalDateTime start,
                        LocalDateTime end);

        // Query PostGIS para posts próximos (com join para checar privacidade do autor)
        @Query(value = "SELECT p.* FROM posts p " +
                        "INNER JOIN users u ON p.author_id = u.id " +
                        "WHERE p.created_at BETWEEN :startOfDay AND :endOfDay " + // Filtra pela data
                        "AND u.id != :userId " + // Não sou eu
                        "AND u.config_is_private = false " + // Não é privado
                        "AND u.config_show_proximity = true " + // Permite proximidade
                        "AND ST_DWithin(u.location, :userLocation, :radiusMeters)", // Está no raio
                        nativeQuery = true)
        List<Post> findNearbyPostsForFeed(
                        @Param("userLocation") Point userLocation,
                        @Param("radiusMeters") double radiusMeters,
                        @Param("userId") UUID userId,
                        @Param("startOfDay") LocalDateTime startOfDay,
                        @Param("endOfDay") LocalDateTime endOfDay);

        long countByAuthorAndCreatedAtBetween(User author, LocalDateTime start, LocalDateTime end);
}