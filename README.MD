Este código é proprietário e protegido por direitos autorais (All Rights Reserved). 
Ele está público apenas para fins de avaliação e não pode ser copiado, modificado ou distribuído sem permissão expressa do autor.

## Como rodar (Backend - Spring Boot)

### Pré-requisitos:

- JDK 17
- Docker
- Maven (opcional, se usar IDE)

### Clone o projeto: 
```
git clone https://github.com/ricarthlima/dvagarin.git
```

### Configure o Firebase:
> Esse projeto usa Firebase Auth para autenticação

- Crie um projeto Firebase;
- Em "Visão geral do projeto", clique na engrenagem, e em "Configurações do Projeto";
- Procure por "Contas de Serviço";
- Clique em "Gerar nova chave privada";
- Obtenha serviceAccountKey.json (renomeie);
- Coloque este arquivo na pasta `src/main/resources/`;

### Suba o Banco de Dados (Postgres + PostGIS):
> Abra um terminal na raiz do projeto

```
docker-compose up -d
```


### Rode a Aplicação

O IntelliJ ou o VSCode, se tiverem as extensões corretas instaladas, aceitarão rodar o arquivo `VagarinApiApplication.java`. Se você tiver o Maven configurado, basta rodar na raiz:

```
mvn spring-boot:run
```

# Acesse a Documentação da API
http://localhost:8080/swagger-ui.html


### Liberando o Firewall
Se encontrar problemas em parear um dispositivo físico externo ao localhost, use:

```
netsh advfirewall firewall add rule name="SpringBoot8080" dir=in action=allow protocol=TCP localport=8080
```

Lembre-se de acessar com o seu IP local, como http://192.168.3.28:8080/swagger-ui/index.html