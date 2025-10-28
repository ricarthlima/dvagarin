package br.com.vagarin.api.friendship;

import br.com.vagarin.api.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface FriendshipRepository extends JpaRepository<Friendship, UUID> {
    // JpaRepository<Entidade, TipoDoId>

    // Método mágico para achar um pedido específico (para aceitar/rejeitar)
    Optional<Friendship> findByRequesterAndReceiver(User requester, User receiver);

    // Método para listar amigos (requisições ACEITAS)
    // "Encontre onde eu sou o 'requester' OU o 'receiver' E o status é 'ACCEPTED'"
    List<Friendship> findByRequesterOrReceiverAndStatus(User requester, User receiver, FriendshipStatus status);

    // Método para listar pedidos PENDENTES que eu recebi
    List<Friendship> findByReceiverAndStatus(User receiver, FriendshipStatus status);

    // "Encontre todas as amizades ACEITAS onde eu sou o requester OU o receiver"
    // (A gente já tinha um parecido, mas esse é mais específico)
    List<Friendship> findAllByStatusAndRequesterOrReceiver(
            FriendshipStatus status,
            User requester,
            User receiver);
}