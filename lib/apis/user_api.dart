import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tweet/core/core.dart';
import 'package:tweet/models/user_model.dart';
import 'package:tweet/constants/constants.dart';

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollection,
          documentId: ID.unique(),
          data: userModel.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? 'some unexpected error occured', st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
