import '../model/login_model.dart';

abstract class IUserDatasource {
  Future<LoginModel> getUserLogin(String login, String password);
}
