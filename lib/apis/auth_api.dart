import 'package:appwrite/models.dart' as models;
import 'package:tweet/core/core.dart';

//want to signup , use model.user
//want to signin , use account.service
//to acess user data, use model.user

abstract class IAuthAPI {
  FutureEither<models.User> signUp(
      {required String email, required String passowrd});
}
