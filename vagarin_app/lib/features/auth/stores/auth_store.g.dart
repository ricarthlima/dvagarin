// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isLoggedOutComputed;

  @override
  bool get isLoggedOut => (_$isLoggedOutComputed ??= Computed<bool>(
    () => super.isLoggedOut,
    name: '_AuthStore.isLoggedOut',
  )).value;

  late final _$isAuthenticatedAtom = Atom(
    name: '_AuthStore.isAuthenticated',
    context: context,
  );

  @override
  bool get isAuthenticated {
    _$isAuthenticatedAtom.reportRead();
    return super.isAuthenticated;
  }

  @override
  set isAuthenticated(bool value) {
    _$isAuthenticatedAtom.reportWrite(value, super.isAuthenticated, () {
      super.isAuthenticated = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AuthStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_AuthStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$currentUserAtom = Atom(
    name: '_AuthStore.currentUser',
    context: context,
  );

  @override
  AuthUser get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(AuthUser value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$checkLoginStatusAsyncAction = AsyncAction(
    '_AuthStore.checkLoginStatus',
    context: context,
  );

  @override
  Future<void> checkLoginStatus() {
    return _$checkLoginStatusAsyncAction.run(() => super.checkLoginStatus());
  }

  late final _$signInWithEmailAsyncAction = AsyncAction(
    '_AuthStore.signInWithEmail',
    context: context,
  );

  @override
  Future<void> signInWithEmail(String email, String password) {
    return _$signInWithEmailAsyncAction.run(
      () => super.signInWithEmail(email, password),
    );
  }

  late final _$signUpWithEmailAsyncAction = AsyncAction(
    '_AuthStore.signUpWithEmail',
    context: context,
  );

  @override
  Future<void> signUpWithEmail(String email, String password) {
    return _$signUpWithEmailAsyncAction.run(
      () => super.signUpWithEmail(email, password),
    );
  }

  late final _$signInWithGoogleAsyncAction = AsyncAction(
    '_AuthStore.signInWithGoogle',
    context: context,
  );

  @override
  Future<void> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  late final _$signOutAsyncAction = AsyncAction(
    '_AuthStore.signOut',
    context: context,
  );

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$_AuthStoreActionController = ActionController(
    name: '_AuthStore',
    context: context,
  );

  @override
  void _handleAuthStateChange(AuthUser authUser) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
      name: '_AuthStore._handleAuthStateChange',
    );
    try {
      return super._handleAuthStateChange(authUser);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAuthenticated: ${isAuthenticated},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
currentUser: ${currentUser},
isLoggedOut: ${isLoggedOut}
    ''';
  }
}
