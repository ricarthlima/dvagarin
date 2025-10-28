package br.com.vagarin.api.device;

import br.com.vagarin.api.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserDeviceRepository extends JpaRepository<UserDevice, UUID> {
    // Acha um token específico (para "upsert")
    Optional<UserDevice> findByFcmToken(String fcmToken);

    // Acha todos os tokens de um usuário (para enviar a notificação)
    List<UserDevice> findByUser(User user);
}