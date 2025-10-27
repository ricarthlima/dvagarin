package br.com.vagarin.api.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import java.io.InputStream;

@Configuration
public class FirebaseConfig {

    @PostConstruct // 1. Garante que este método rode DEPOIS que o Spring construir a classe
    public void initializeFirebase() {
        try {
            // 2. Pega o arquivo .json que colocamos na pasta 'resources'
            ClassPathResource resource = new ClassPathResource("serviceAccountKey.json");
            InputStream serviceAccount = resource.getInputStream();

            // 3. Configura as opções do Firebase
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            // 4. Inicializa o App do Firebase, se ainda não foi inicializado
            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                System.out.println("FirebaseApp inicializado com sucesso!");
            }
        } catch (Exception e) {
            // Isso aqui vai quebrar a aplicação se não achar o arquivo,
            // o que é bom, pois não deve rodar sem ele.
            e.printStackTrace();
            throw new RuntimeException("Erro ao inicializar o Firebase Admin SDK", e);
        }
    }
}