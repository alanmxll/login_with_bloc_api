import 'package:injectable/injectable.dart';
import 'package:login_with_bloc_api/core/database/i_database_connection.dart';
import 'package:login_with_bloc_api/core/exception/exceptions.dart';
import 'package:login_with_bloc_api/core/utils/cripty_utils.dart';
import 'package:login_with_bloc_api/modules/user/data/model/login_model.dart';

import 'i_user_datasource.dart';

@LazySingleton(as: IUserDatasource)
class UserDatasource implements IUserDatasource {
  UserDatasource(this._database);

  final IDatabaseConnection _database;

  @override
  Future<LoginModel> getUserLogin(String login, String password) async {
    final connection = await _database.openConnection();

    try {
      final queryResult = await connection.query('''
          SELECT user_id, user_login, user_password 
          FROM user_system 
          WHERE user_login = ? AND user_password = ?
          ''', [login, CriptyUtils.generateSha256Hash(password)]);

      if (queryResult.isEmpty) {
        return null;
      }

      return LoginModel.mapper(queryResult.first.asMap());
    } catch (e, s) {
      print(e);
      print(s);
      throw DatabaseException('Error on login');
    } finally {
      await connection.close();
    }
  }
}
