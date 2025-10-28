// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginFormStore on _LoginFormStoreBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: '_LoginFormStoreBase.isLoading',
  )).value;
  Computed<String?>? _$errorMessageComputed;

  @override
  String? get errorMessage => (_$errorMessageComputed ??= Computed<String?>(
    () => super.errorMessage,
    name: '_LoginFormStoreBase.errorMessage',
  )).value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit => (_$canSubmitComputed ??= Computed<bool>(
    () => super.canSubmit,
    name: '_LoginFormStoreBase.canSubmit',
  )).value;

  late final _$emailAtom = Atom(
    name: '_LoginFormStoreBase.email',
    context: context,
  );

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom = Atom(
    name: '_LoginFormStoreBase.password',
    context: context,
  );

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$emailErrorAtom = Atom(
    name: '_LoginFormStoreBase.emailError',
    context: context,
  );

  @override
  String? get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(String? value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  late final _$passwordErrorAtom = Atom(
    name: '_LoginFormStoreBase.passwordError',
    context: context,
  );

  @override
  String? get passwordError {
    _$passwordErrorAtom.reportRead();
    return super.passwordError;
  }

  @override
  set passwordError(String? value) {
    _$passwordErrorAtom.reportWrite(value, super.passwordError, () {
      super.passwordError = value;
    });
  }

  late final _$submitLoginAsyncAction = AsyncAction(
    '_LoginFormStoreBase.submitLogin',
    context: context,
  );

  @override
  Future<void> submitLogin() {
    return _$submitLoginAsyncAction.run(() => super.submitLogin());
  }

  late final _$submitGoogleLoginAsyncAction = AsyncAction(
    '_LoginFormStoreBase.submitGoogleLogin',
    context: context,
  );

  @override
  Future<void> submitGoogleLogin() {
    return _$submitGoogleLoginAsyncAction.run(() => super.submitGoogleLogin());
  }

  late final _$_LoginFormStoreBaseActionController = ActionController(
    name: '_LoginFormStoreBase',
    context: context,
  );

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginFormStoreBaseActionController.startAction(
      name: '_LoginFormStoreBase.setEmail',
    );
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginFormStoreBaseActionController.startAction(
      name: '_LoginFormStoreBase.setPassword',
    );
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail() {
    final _$actionInfo = _$_LoginFormStoreBaseActionController.startAction(
      name: '_LoginFormStoreBase.validateEmail',
    );
    try {
      return super.validateEmail();
    } finally {
      _$_LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword() {
    final _$actionInfo = _$_LoginFormStoreBaseActionController.startAction(
      name: '_LoginFormStoreBase.validatePassword',
    );
    try {
      return super.validatePassword();
    } finally {
      _$_LoginFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
emailError: ${emailError},
passwordError: ${passwordError},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
canSubmit: ${canSubmit}
    ''';
  }
}
