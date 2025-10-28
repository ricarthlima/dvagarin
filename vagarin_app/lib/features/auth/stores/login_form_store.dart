import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart'; // Exemplo de pacote de validação
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/shared/injection_container.dart';

part 'login_form_store.g.dart';

class LoginFormStore = _LoginFormStoreBase with _$LoginFormStore;

abstract class _LoginFormStoreBase with Store {
  final AuthStore _authStore = getIt<AuthStore>();

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String? emailError;

  @observable
  String? passwordError;

  @computed
  bool get isLoading => _authStore.isLoading;

  @computed
  String? get errorMessage => _authStore.errorMessage;

  @computed
  bool get canSubmit =>
      emailError == null &&
      passwordError == null &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      !isLoading;

  @action
  void setEmail(String value) {
    email = value;
    validateEmail();
  }

  @action
  void setPassword(String value) {
    password = value;
    validatePassword();
  }

  @action
  void validateEmail() {
    if (!isEmail(email)) {
      emailError = 'E-mail inválido';
    } else {
      emailError = null;
    }
  }

  @action
  void validatePassword() {
    if (password.isEmpty || password.length < 6) {
      passwordError = 'Senha deve ter pelo menos 6 caracteres';
    } else {
      passwordError = null;
    }
  }

  @action
  Future<void> submitLogin() async {
    validateEmail();
    validatePassword();

    if (canSubmit) {
      await _authStore.signInWithEmail(email, password);
    }
  }

  @action
  Future<void> submitGoogleLogin() async {
    await _authStore.signInWithGoogle();
  }
}
