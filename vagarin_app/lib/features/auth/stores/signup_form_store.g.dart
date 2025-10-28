// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpFormStore on _SignUpFormStoreBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: '_SignUpFormStoreBase.isLoading',
  )).value;
  Computed<String?>? _$errorMessageComputed;

  @override
  String? get errorMessage => (_$errorMessageComputed ??= Computed<String?>(
    () => super.errorMessage,
    name: '_SignUpFormStoreBase.errorMessage',
  )).value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit => (_$canSubmitComputed ??= Computed<bool>(
    () => super.canSubmit,
    name: '_SignUpFormStoreBase.canSubmit',
  )).value;

  late final _$emailAtom = Atom(
    name: '_SignUpFormStoreBase.email',
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
    name: '_SignUpFormStoreBase.password',
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

  late final _$confirmPasswordAtom = Atom(
    name: '_SignUpFormStoreBase.confirmPassword',
    context: context,
  );

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$emailErrorAtom = Atom(
    name: '_SignUpFormStoreBase.emailError',
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
    name: '_SignUpFormStoreBase.passwordError',
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

  late final _$confirmPasswordErrorAtom = Atom(
    name: '_SignUpFormStoreBase.confirmPasswordError',
    context: context,
  );

  @override
  String? get confirmPasswordError {
    _$confirmPasswordErrorAtom.reportRead();
    return super.confirmPasswordError;
  }

  @override
  set confirmPasswordError(String? value) {
    _$confirmPasswordErrorAtom.reportWrite(
      value,
      super.confirmPasswordError,
      () {
        super.confirmPasswordError = value;
      },
    );
  }

  late final _$submitSignUpAsyncAction = AsyncAction(
    '_SignUpFormStoreBase.submitSignUp',
    context: context,
  );

  @override
  Future<void> submitSignUp() {
    return _$submitSignUpAsyncAction.run(() => super.submitSignUp());
  }

  late final _$_SignUpFormStoreBaseActionController = ActionController(
    name: '_SignUpFormStoreBase',
    context: context,
  );

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_SignUpFormStoreBaseActionController.startAction(
      name: '_SignUpFormStoreBase.setEmail',
    );
    try {
      return super.setEmail(value);
    } finally {
      _$_SignUpFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_SignUpFormStoreBaseActionController.startAction(
      name: '_SignUpFormStoreBase.setPassword',
    );
    try {
      return super.setPassword(value);
    } finally {
      _$_SignUpFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_SignUpFormStoreBaseActionController.startAction(
      name: '_SignUpFormStoreBase.setConfirmPassword',
    );
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_SignUpFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail() {
    final _$actionInfo = _$_SignUpFormStoreBaseActionController.startAction(
      name: '_SignUpFormStoreBase.validateEmail',
    );
    try {
      return super.validateEmail();
    } finally {
      _$_SignUpFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword() {
    final _$actionInfo = _$_SignUpFormStoreBaseActionController.startAction(
      name: '_SignUpFormStoreBase.validatePassword',
    );
    try {
      return super.validatePassword();
    } finally {
      _$_SignUpFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePasswordsMatch() {
    final _$actionInfo = _$_SignUpFormStoreBaseActionController.startAction(
      name: '_SignUpFormStoreBase.validatePasswordsMatch',
    );
    try {
      return super.validatePasswordsMatch();
    } finally {
      _$_SignUpFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
emailError: ${emailError},
passwordError: ${passwordError},
confirmPasswordError: ${confirmPasswordError},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
canSubmit: ${canSubmit}
    ''';
  }
}
