import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/helpers/digits_only.dart';
import '../../../../shared/models/user_model.dart';
import '../../../auth/stores/auth_store.dart';
import '../../data/repositories/i_user_repository.dart';
import '../../domain/user_register_data.dart';

part 'register_store.g.dart';

enum RegisterPage { basics, phone, photo, geo, confirm }

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final IUserRepository _userRepository;
  final AuthStore _authStore;
  final Logger _logger;

  _RegisterStore(this._userRepository, this._authStore, this._logger);

  // Para a subimissão
  @observable
  ObservableFuture<UserModel?> registerFuture = ObservableFuture.value(null);

  @observable
  bool isSubmitting = false;

  @computed
  bool get canSubmit => currentPage == RegisterPage.confirm && !isSubmitting;

  @observable
  String? submissionError;

  @observable
  RegisterPage currentPage = RegisterPage.basics;

  @observable
  String name = '';
  @observable
  String? nameErrorText;

  @observable
  String username = '';
  @observable
  String? usernameErrorText;

  @observable
  DateTime birthday = DateTime.now();

  @computed
  String get formattedBirthday =>
      "${birthday.day}/${birthday.month}/${birthday.year}";

  @observable
  String bio = '';

  @observable
  String phone = '';

  @observable
  String? phoneError;

  @observable
  File? imageFile;

  @observable
  Position? geoPosition;
  @computed
  bool get hasLocation => geoPosition != null;

  @observable
  bool hasActiveNotifications = false;

  @computed
  bool get canNextPage {
    switch (currentPage) {
      case RegisterPage.basics:
        return (name != '' &&
            nameErrorText == null &&
            username != '' &&
            usernameErrorText == null);
      case RegisterPage.phone:
        return (phone != '' && phoneError == null);
      case RegisterPage.photo:
        return true;
      case RegisterPage.geo:
        return true;
      case RegisterPage.confirm:
        return false;
    }
  }

  @computed
  String get labelContinueButton {
    switch (currentPage) {
      case RegisterPage.basics:
        return "Continuar";
      case RegisterPage.phone:
        return "Continuar";
      case RegisterPage.photo:
        return (imageFile != null) ? "Continuar" : "Pular";
      case RegisterPage.geo:
        return hasLocation ? "Continuar" : "Pular";
      case RegisterPage.confirm:
        return isSubmitting ? "Enviando..." : "";
    }
  }

  @action
  void backPage() {
    if (currentPage != RegisterPage.basics) {
      currentPage = RegisterPage.values[currentPage.index - 1];
    }
  }

  void nextPage() {
    if (currentPage != RegisterPage.confirm) {
      currentPage = RegisterPage.values[currentPage.index + 1];
    }
  }

  @action
  void setName(String? value) {
    if (value == null || value.trim().isEmpty) {
      nameErrorText = 'O nome é obrigatório';
      return;
    }
    if (value.trim().split(' ').length < 2) {
      nameErrorText = 'Por favor, digite o nome completo';
      return;
    }
    nameErrorText = null;
    name = value;
  }

  @action
  void setUsername(String? value) {
    if (value == null || value.isEmpty) {
      usernameErrorText = 'O username é obrigatório';
      return;
    }
    if (value.length < 3) {
      usernameErrorText = 'Username muito curto (mín. 3 caracteres)';
      return;
    }
    usernameErrorText = null;
    username = value;
  }

  @action
  void setBirthday(DateTime date) {
    birthday = date;
  }

  @action
  void setBio(String? bio) {
    this.bio = bio ?? '';
  }

  @action
  void setPhone(String? value) {
    final raw = digitsOnly(value);
    if (raw.isEmpty) {
      phoneError = 'Informe o telefone';
      return;
    }
    if (raw.length < 10 || raw.length > 11) {
      phoneError = 'Telefone inválido';
      return;
    }
    phoneError = null;
    phone = raw;
  }

  @action
  void setPhoto({required File? imageFile}) {
    this.imageFile = imageFile;
  }

  @action
  void cleanPhoto() {
    imageFile = null;
  }

  @action
  void setGeo({required Position pos}) {
    geoPosition = pos;
  }

  @action
  void cleanGeo() {
    geoPosition = null;
  }

  @action
  void setNotification({required bool hasActiveNotifications}) {
    this.hasActiveNotifications = hasActiveNotifications;
    currentPage = RegisterPage.confirm;
  }

  @action
  void submit() async {
    if (isSubmitting) return;

    isSubmitting = true;
    submissionError = null;

    try {
      // 1. Cria o DTO (UserRegisterData)
      final data = UserRegisterData(
        name: name,
        username: username,
        birthday: birthday,
        bio: bio,
        phone: phone,
        imageFile: imageFile,
        geoPosition: geoPosition,
        hasActiveNotifications: hasActiveNotifications,
        firebaseUid: _authStore.currentUser.uid, // Pega o UID do usuário logado
      );

      _logger.i(
        '[RegisterStore] Enviando dados de registro para o repositório...',
      );

      // 2. Chama o Repositório
      await _userRepository.registerUser(data);

      // 3. Sucesso! Navega para Home
      _logger.i(
        '[RegisterStore] Registro finalizado com sucesso! Navegando para Home.',
      );

      _authStore.completeBackendRegistration();
    } on Exception catch (e) {
      _logger.e('[RegisterStore] Erro na submissão do registro', error: e);
      submissionError =
          'Falha ao finalizar o registro. Verifique a conexão ou tente um username diferente.';
    }
  }
}
