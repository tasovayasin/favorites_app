import 'package:favorites_app/src/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUser();
}
