package br.com.vagarin.api.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import org.locationtech.jts.geom.Point;

import java.util.Optional;
import java.util.UUID;

@Repository // Avisa ao Spring que esta é uma interface de Repositório
public interface UserRepository extends JpaRepository<User, UUID> {
        // JpaRepository<TipoDaEntidade, TipoDoId>

        // O Spring Data JPA é tão inteligente que ele cria a query
        // SQL só de você declarar o nome do método assim:

        Optional<User> findByFirebaseUid(String firebaseUid);

        Optional<User> findByUsername(String username);

        // ST_DWithin é a função do PostGIS: "Está Dentro da Distância?"
        // :userLocation = o Ponto do usuário logado
        // :radiusMeters = o raio (em METROS!)
        @Query(value = "SELECT * FROM users u WHERE ST_DWithin(u.location, :userLocation, :radiusMeters) " +
                        "AND u.id != :userId " + // Não incluir a si mesmo
                        "AND u.config_show_proximity = true " + // Respeita a privacidade
                        "AND u.config_is_private = false", // Respeita a privacidade
                        nativeQuery = true)
        List<User> findNearbyUsers(
                        @Param("userLocation") Point userLocation,
                        @Param("radiusMeters") double radiusMeters,
                        @Param("userId") UUID userId);

        /**
         * Método mágico do Spring Data JPA:
         * "Encontre por (Nome Contendo Ignorando Case) OU (Username Contendo Ignorando
         * Case)
         * E (configIsPrivate é Falso)"
         */
        List<User> findByNameContainingIgnoreCaseOrUsernameContainingIgnoreCaseAndConfigIsPrivateIsFalse(
                        String nameQuery,
                        String usernameQuery);

        List<User> findByConfigNotifyPostReminder(boolean value);
}