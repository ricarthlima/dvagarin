// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on _RegisterStore, Store {
  Computed<String>? _$formattedBirthdayComputed;

  @override
  String get formattedBirthday =>
      (_$formattedBirthdayComputed ??= Computed<String>(
        () => super.formattedBirthday,
        name: '_RegisterStore.formattedBirthday',
      )).value;
  Computed<bool>? _$hasLocationComputed;

  @override
  bool get hasLocation => (_$hasLocationComputed ??= Computed<bool>(
    () => super.hasLocation,
    name: '_RegisterStore.hasLocation',
  )).value;
  Computed<bool>? _$canNextPageComputed;

  @override
  bool get canNextPage => (_$canNextPageComputed ??= Computed<bool>(
    () => super.canNextPage,
    name: '_RegisterStore.canNextPage',
  )).value;
  Computed<String>? _$labelContinueButtonComputed;

  @override
  String get labelContinueButton =>
      (_$labelContinueButtonComputed ??= Computed<String>(
        () => super.labelContinueButton,
        name: '_RegisterStore.labelContinueButton',
      )).value;

  late final _$currentPageAtom = Atom(
    name: '_RegisterStore.currentPage',
    context: context,
  );

  @override
  RegisterPage get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(RegisterPage value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$nameAtom = Atom(name: '_RegisterStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$nameErrorTextAtom = Atom(
    name: '_RegisterStore.nameErrorText',
    context: context,
  );

  @override
  String? get nameErrorText {
    _$nameErrorTextAtom.reportRead();
    return super.nameErrorText;
  }

  @override
  set nameErrorText(String? value) {
    _$nameErrorTextAtom.reportWrite(value, super.nameErrorText, () {
      super.nameErrorText = value;
    });
  }

  late final _$usernameAtom = Atom(
    name: '_RegisterStore.username',
    context: context,
  );

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$usernameErrorTextAtom = Atom(
    name: '_RegisterStore.usernameErrorText',
    context: context,
  );

  @override
  String? get usernameErrorText {
    _$usernameErrorTextAtom.reportRead();
    return super.usernameErrorText;
  }

  @override
  set usernameErrorText(String? value) {
    _$usernameErrorTextAtom.reportWrite(value, super.usernameErrorText, () {
      super.usernameErrorText = value;
    });
  }

  late final _$birthdayAtom = Atom(
    name: '_RegisterStore.birthday',
    context: context,
  );

  @override
  DateTime get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(DateTime value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  late final _$bioAtom = Atom(name: '_RegisterStore.bio', context: context);

  @override
  String get bio {
    _$bioAtom.reportRead();
    return super.bio;
  }

  @override
  set bio(String value) {
    _$bioAtom.reportWrite(value, super.bio, () {
      super.bio = value;
    });
  }

  late final _$phoneAtom = Atom(name: '_RegisterStore.phone', context: context);

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$phoneErrorAtom = Atom(
    name: '_RegisterStore.phoneError',
    context: context,
  );

  @override
  String? get phoneError {
    _$phoneErrorAtom.reportRead();
    return super.phoneError;
  }

  @override
  set phoneError(String? value) {
    _$phoneErrorAtom.reportWrite(value, super.phoneError, () {
      super.phoneError = value;
    });
  }

  late final _$imageFileAtom = Atom(
    name: '_RegisterStore.imageFile',
    context: context,
  );

  @override
  File? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  late final _$geoPositionAtom = Atom(
    name: '_RegisterStore.geoPosition',
    context: context,
  );

  @override
  Position? get geoPosition {
    _$geoPositionAtom.reportRead();
    return super.geoPosition;
  }

  @override
  set geoPosition(Position? value) {
    _$geoPositionAtom.reportWrite(value, super.geoPosition, () {
      super.geoPosition = value;
    });
  }

  late final _$hasActiveNotificationsAtom = Atom(
    name: '_RegisterStore.hasActiveNotifications',
    context: context,
  );

  @override
  bool get hasActiveNotifications {
    _$hasActiveNotificationsAtom.reportRead();
    return super.hasActiveNotifications;
  }

  @override
  set hasActiveNotifications(bool value) {
    _$hasActiveNotificationsAtom.reportWrite(
      value,
      super.hasActiveNotifications,
      () {
        super.hasActiveNotifications = value;
      },
    );
  }

  late final _$_RegisterStoreActionController = ActionController(
    name: '_RegisterStore',
    context: context,
  );

  @override
  void backPage() {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.backPage',
    );
    try {
      return super.backPage();
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String? value) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setName',
    );
    try {
      return super.setName(value);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsername(String? value) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setUsername',
    );
    try {
      return super.setUsername(value);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(DateTime date) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setBirthday',
    );
    try {
      return super.setBirthday(date);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBio(String? bio) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setBio',
    );
    try {
      return super.setBio(bio);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String? value) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setPhone',
    );
    try {
      return super.setPhone(value);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoto({required File? imageFile}) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setPhoto',
    );
    try {
      return super.setPhoto(imageFile: imageFile);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanPhoto() {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.cleanPhoto',
    );
    try {
      return super.cleanPhoto();
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGeo({required Position pos}) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setGeo',
    );
    try {
      return super.setGeo(pos: pos);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanGeo() {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.cleanGeo',
    );
    try {
      return super.cleanGeo();
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotification({required bool hasActiveNotifications}) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setNotification',
    );
    try {
      return super.setNotification(
        hasActiveNotifications: hasActiveNotifications,
      );
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void submit() {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.submit',
    );
    try {
      return super.submit();
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
name: ${name},
nameErrorText: ${nameErrorText},
username: ${username},
usernameErrorText: ${usernameErrorText},
birthday: ${birthday},
bio: ${bio},
phone: ${phone},
phoneError: ${phoneError},
imageFile: ${imageFile},
geoPosition: ${geoPosition},
hasActiveNotifications: ${hasActiveNotifications},
formattedBirthday: ${formattedBirthday},
hasLocation: ${hasLocation},
canNextPage: ${canNextPage},
labelContinueButton: ${labelContinueButton}
    ''';
  }
}
