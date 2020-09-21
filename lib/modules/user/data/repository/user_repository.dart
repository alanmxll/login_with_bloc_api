import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/ports/i_user_repository.dart';
import '../datasource/i_user_datasource.dart';
import '../exception/user_not_found_exception.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._datasource);

  final IUserDatasource _datasource;

  @override
  Future<User> getUserByLoginAndPassword(String login, String password) async {
    try {
      final user = await _datasource.getUserLogin(login, password);

      if (user == null) {
        throw UserNotFoundException();
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
