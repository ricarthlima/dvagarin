import 'dart:io';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

enum RegisterPage { basics, photo, geo, notifications, confirm }

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
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
  File? imageFile;

  @observable
  double lat = 0;

  @observable
  double long = 0;

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

      case RegisterPage.photo:
        return true;
      case RegisterPage.geo:
        return true;
      case RegisterPage.notifications:
        return true;
      case RegisterPage.confirm:
        return true;
    }
  }

  @computed
  String get labelContinueButton {
    switch (currentPage) {
      case RegisterPage.basics:
        return "Continuar";
      case RegisterPage.photo:
        return (imageFile != null) ? "Continuar" : "Pular";
      case RegisterPage.geo:
        return (lat != 0 && long != 0) ? "Continuar" : "Pular";
      case RegisterPage.notifications:
        return (hasActiveNotifications) ? "Continuar" : "Pular";
      case RegisterPage.confirm:
        return "Registrar-se";
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
  void setPhoto({required File? imageFile}) {
    this.imageFile = imageFile;
  }

  @action
  void cleanPhoto() {
    imageFile = null;
  }

  @action
  void setGeo({required double lat, required double long}) {
    this.lat = lat;
    this.long = long;
    currentPage = RegisterPage.notifications;
  }

  @action
  void setNotification({required bool hasActiveNotifications}) {
    this.hasActiveNotifications = hasActiveNotifications;
    currentPage = RegisterPage.confirm;
  }

  @action
  void submit() {}
}
