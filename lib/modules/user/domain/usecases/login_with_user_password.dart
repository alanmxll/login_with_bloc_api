import 'package:injectable/injectable.dart';

import '../entities/user.dart';
import '../ports/i_user_repository.dart';

@LazySingleton()
class LoginWithUserPassword {
  LoginWithUserPassword(this._repository);

  final IUserRepository _repository;

  Future<User> call(String login, String password) {
    return _repository.getUserByLoginAndPassword(login, password);
  }
}
