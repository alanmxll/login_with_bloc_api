import 'package:aqueduct/aqueduct.dart';
import 'package:injectable/injectable.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../../data/exception/user_not_found_exception.dart';
import '../../domain/usecases/login_with_user_password.dart';
import '../models/check_login_request.dart';

@LazySingleton()
class CheckLoginPasswordController extends ResourceController {
  CheckLoginPasswordController(this._useCase);

  final LoginWithUserPassword _useCase;

  @Operation.post()
  Future<Response> checkLogin(
      @Bind.body() CheckLoginRequest requestLogin) async {
    try {
      final userResult =
          await _useCase(requestLogin.login, requestLogin.password);

      return Response.ok({'token': generateJWTToken(userResult.id)});
    } catch (e) {
      if (e is UserNotFoundException) {
        return Response.forbidden(body: {'message': 'Access Denied!'});
      }

      return Response.serverError(body: {'message': e.toString()});
    }
  }

  String generateJWTToken(int userId) {
    final claimSet = JwtClaim(
      issuer: 'http://localhost',
      subject: userId.toString(),
      expiry: DateTime.now().add(const Duration(days: 1)),
      notBefore: DateTime.now(),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{},
      maxAge: const Duration(days: 1),
    );

    return issueJwtHS256(claimSet, 'LOGIN_WITH_BLOC_API');
  }
}
