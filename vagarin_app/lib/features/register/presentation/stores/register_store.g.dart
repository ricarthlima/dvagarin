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
  Computed<bool>? _$canNextPageComputed;

  @override
  bool get canNextPage => (_$canNextPageComputed ??= Computed<bool>(
    () => super.canNextPage,
    name: '_RegisterStore.canNextPage',
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

  late final _$imageBytesAtom = Atom(
    name: '_RegisterStore.imageBytes',
    context: context,
  );

  @override
  Uint8List? get imageBytes {
    _$imageBytesAtom.reportRead();
    return super.imageBytes;
  }

  @override
  set imageBytes(Uint8List? value) {
    _$imageBytesAtom.reportWrite(value, super.imageBytes, () {
      super.imageBytes = value;
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

  late final _$latAtom = Atom(name: '_RegisterStore.lat', context: context);

  @override
  double get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(double value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  late final _$longAtom = Atom(name: '_RegisterStore.long', context: context);

  @override
  double get long {
    _$longAtom.reportRead();
    return super.long;
  }

  @override
  set long(double value) {
    _$longAtom.reportWrite(value, super.long, () {
      super.long = value;
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
  void setPhoto({required Uint8List imageBytes}) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setPhoto',
    );
    try {
      return super.setPhoto(imageBytes: imageBytes);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone({required String phone}) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setPhone',
    );
    try {
      return super.setPhone(phone: phone);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGeo({required double lat, required double long}) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
      name: '_RegisterStore.setGeo',
    );
    try {
      return super.setGeo(lat: lat, long: long);
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
imageBytes: ${imageBytes},
phone: ${phone},
lat: ${lat},
long: ${long},
hasActiveNotifications: ${hasActiveNotifications},
formattedBirthday: ${formattedBirthday},
canNextPage: ${canNextPage}
    ''';
  }
}
