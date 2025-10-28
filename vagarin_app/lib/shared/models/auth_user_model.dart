import 'package:equatable/equatable.dart';

/// Como, a priori, nossa autenticação via usar o FirebaseAuth
/// ficaríamos dependentes do 'User' deles. Então para evitar o acoplamento
/// costumo criar um [AuthUser] interno nas minhas aplicações que
/// pode ser alimentado com uid e email de qualquer provedor de autenticação.
class AuthUser extends Equatable {
  //Equatable só pra nao escrever hash na mao
  final String uid;
  final String? email;

  const AuthUser({required this.uid, this.email});

  /// Usuário vazio/nulo (para estados de 'não logado').
  static const empty = AuthUser(uid: '');

  bool get isEmpty => this == AuthUser.empty;
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [uid, email];
}
