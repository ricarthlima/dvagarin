import 'dart:typed_data';

import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

enum RegisterPage { basics, photo, phone, geo, notifications, confirm }

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
  Uint8List? imageBytes;

  @observable
  String phone = '';

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
      case RegisterPage.phone:
        return true;
      case RegisterPage.geo:
        return true;
      case RegisterPage.notifications:
        return true;
      case RegisterPage.confirm:
        return true;
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
  void setPhoto({required Uint8List imageBytes}) {
    this.imageBytes = imageBytes;
    currentPage = RegisterPage.phone;
  }

  @action
  void setPhone({required String phone}) {
    this.phone = phone;
    currentPage = RegisterPage.geo;
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
