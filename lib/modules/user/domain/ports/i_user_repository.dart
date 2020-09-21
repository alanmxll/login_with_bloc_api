import '../entities/user.dart';

abstract class IUserRepository {
  Future<User> getUserByLoginAndPassword(String login, String password);
}
