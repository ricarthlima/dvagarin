package br.com.vagarin.api.notification;

import br.com.vagarin.api.post.PostRepository;
import br.com.vagarin.api.user.User;
import br.com.vagarin.api.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Component
public class ScheduledTasks {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private NotificationService notificationService;

    // "Rode todo dia, às 20:00:00"
    @Scheduled(cron = "0 0 20 * * ?", zone = "America/Recife")
    public void remindUsersToPost() {
        System.out.println("TASK AGENDADA: Procurando usuários para lembrar...");

        // 1. Pega todos os usuários que QUEREM o lembrete
        List<User> usersToRemind = userRepository.findByConfigNotifyPostReminder(true);

        LocalDate today = LocalDate.now();

        for (User user : usersToRemind) {
            // 2. Checa se o usuário postou hoje
            long postCount = postRepository.countByAuthorAndCreatedAtBetween(
                    user,
                    today.atStartOfDay(),
                    today.atTime(LocalTime.MAX));

            // 3. Se não postou (count == 0), envia a notificação
            if (postCount == 0) {
                notificationService.sendNotificationToUser(
                        user,
                        "Como foi seu dia, " + user.getName() + "?",
                        "Seus amigos no Vagarin sentem sua falta. Que tal postar algo?");
            }
        }
        System.out.println("TASK AGENDADA: Lembretes enviados.");
    }
}