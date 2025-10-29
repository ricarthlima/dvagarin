# Dvagarin - Uma rede, de fato, social

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

### Acesse a Documentação da API
http://localhost:8080/swagger-ui.html


### Liberando o Firewall
Se encontrar problemas em parear um dispositivo físico externo ao localhost, use:

```
netsh advfirewall firewall add rule name="SpringBoot8080" dir=in action=allow protocol=TCP localport=8080
```

Lembre-se de acessar com o seu IP local, como http://192.168.3.28:8080/swagger-ui/index.html

## Como Rodar (Flutter)
Siga estas etapas para executar a aplicação Flutter do DVagarin localmente.

### Pré-requisitos
- **Flutter SDK:** Certifique-se de ter o Flutter SDK instalado na sua máquina. Siga as instruções em flutter.dev. A versão usada no projeto foi ^3.10.0-154.0.dev, mas versões estáveis recentes (como 3.19+) devem funcionar.

- **IDE:** VS Code (com extensões Dart & Flutter) ou Android Studio/IntelliJ.

- **Backend Rodando:** O backend Spring Boot precisa estar em execução. Siga as instruções na seção "Como Rodar (Backend Spring Boot)" do README.

- **Firebase CLI:** Necessário para configurar a conexão com o Firebase (se você for configurar um novo projeto). Instale via npm install -g firebase-tools e faça login com firebase login.

### Configuração
###### Clone o Repositório:

```Bash

git clonehttps://github.com/ricarthlima/dvagarin
cd vagarin_app 
```
###### Configure o Firebase:

- Crie um projeto no Firebase Console.

- Adicione apps para Android, iOS e Web. Siga as instruções do console.

No terminal, na raiz do projeto Flutter, rode:

```Bash
flutterfire configure
```

Siga as instruções do CLI para selecionar seu projeto e plataformas. Isso irá gerar/atualizar o lib/firebase_options.dart.

###### Instale as Dependências:


```bash
flutter pub get
```
###### Gere o Código (MobX, JsonSerializable):

```
flutter pub run build_runner build --delete-conflicting-outputs
```

### Executando a Aplicação

###### Configurando conexão
- O backend Spring Boot precisa estar rodando.
- O Firewall do seu computador precisa permitir conexões na porta 8080.
- A configuração localWifiIp no arquivo `lib/shared/injection_container.dart` precisa ter o IP correto da sua máquina na rede Wi-Fi.

###### Conecte o dispositivo:

- Habilite as "Opções do Desenvolvedor" e a "Depuração USB" no seu dispositivo Android.

- Conecte via USB ou configure a depuração Wi-Fi (adb connect SEU_IP_DO_DISPOSITIVO:PORTA).

- Verifique o Dispositivo:
```
flutter devices
```
- Execute:
```
flutter run -d SEU_DEVICE_ID 
```
> (Substitua SEU_DEVICE_ID pelo ID encontrado).
