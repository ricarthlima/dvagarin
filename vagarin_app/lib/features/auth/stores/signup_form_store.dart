import 'package:mobx/mobx.dart';
import 'package:vagarin_app/features/auth/stores/auth_store.dart';
import 'package:vagarin_app/shared/injection_container.dart';
import 'package:validators/validators.dart';

part 'signup_form_store.g.dart'; // Lembre de gerar!

class SignUpFormStore = _SignUpFormStoreBase with _$SignUpFormStore;

abstract class _SignUpFormStoreBase with Store {
  final AuthStore _authStore = getIt<AuthStore>();

  // --- Observables ---
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  String? emailError;

  @observable
  String? passwordError;

  @observable
  String? confirmPasswordError;

  // Reutiliza o estado global do AuthStore
  @computed
  bool get isLoading => _authStore.isLoading;

  @computed
  String? get errorMessage => _authStore.errorMessage;

  // --- Computed ---
  @computed
  bool get canSubmit =>
      emailError == null &&
      passwordError == null &&
      confirmPasswordError == null &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      !isLoading;

  // --- Actions ---
  @action
  void setEmail(String value) {
    email = value;
    validateEmail();
  }

  @action
  void setPassword(String value) {
    password = value;
    validatePassword();
    validatePasswordsMatch();
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
    validatePasswordsMatch();
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
  void validatePasswordsMatch() {
    if (password != confirmPassword && confirmPassword.isNotEmpty) {
      confirmPasswordError = 'As senhas não coincidem';
    } else {
      confirmPasswordError = null;
    }
  }

  @action
  Future<void> submitSignUp() async {
    validateEmail();
    validatePassword();
    validatePasswordsMatch();

    if (canSubmit) {
      await _authStore.signUpWithEmail(email, password);
    }
  }
}
