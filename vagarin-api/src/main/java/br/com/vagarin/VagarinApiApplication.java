package br.com.vagarin;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableAsync // 3. HABILITA MÉTODOS ASSÍNCRONOS
@EnableScheduling // 4. HABILITA TAREFAS AGENDADAS
public class VagarinApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(VagarinApiApplication.class, args);
	}

}
