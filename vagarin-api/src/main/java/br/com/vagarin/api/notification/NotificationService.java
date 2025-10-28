package br.com.vagarin.api.notification;

import br.com.vagarin.api.device.UserDevice;
import br.com.vagarin.api.device.UserDeviceRepository;
import br.com.vagarin.api.user.User;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationService {

    @Autowired
    private UserDeviceRepository userDeviceRepository;

    @Autowired
    private FirebaseMessaging firebaseMessaging; // O Spring vai injetar isso!

    // Importante! Isso faz o método rodar em outra thread.
    @Async
    public void sendNotificationToUser(User user, String title, String body) {

        // 1. Busca todos os dispositivos (tokens) daquele usuário
        List<UserDevice> devices = userDeviceRepository.findByUser(user);
        if (devices.isEmpty()) {
            return; // Usuário não tem dispositivos registrados
        }

        // 2. Monta a notificação
        Notification notification = Notification.builder()
                .setTitle(title)
                .setBody(body)
                .build();

        // 3. Manda para cada dispositivo
        for (UserDevice device : devices) {
            Message message = Message.builder()
                    .setToken(device.getFcmToken())
                    .setNotification(notification)
                    // TODO: Adicionar "data" payload se o Flutter precisar
                    // .putData("postId", "123")
                    .build();

            try {
                firebaseMessaging.send(message);
            } catch (FirebaseMessagingException e) {
                System.err.println("Erro ao enviar FCM: " + e.getMessage());
                // TODO: Se o erro for "UNREGISTERED", apagar o token do banco
            }
        }
    }
}