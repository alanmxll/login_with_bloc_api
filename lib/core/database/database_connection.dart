import 'package:injectable/injectable.dart';
import 'package:login_with_bloc_api/core/database/i_database_connection.dart';
import 'package:mysql1/mysql1.dart';

@LazySingleton(as: IDatabaseConnection)
class DatabaseConnection implements IDatabaseConnection {
  @override
  Future<MySqlConnection> openConnection() {
    return MySqlConnection.connect(
      ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'login_with_bloc',
        db: 'login_with_bloc',
      ),
    );
  }
}
