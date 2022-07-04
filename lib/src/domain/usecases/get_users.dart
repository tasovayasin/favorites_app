import 'dart:async';

import 'package:favorites_app/src/domain/entities/user.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:favorites_app/src/domain/repositories/user_repository.dart';

class GetUsers extends UseCase<List<User>, void> {
  final UserRepository _userRepository;

  GetUsers(this._userRepository);

  @override
  Future<Stream<List<User>?>> buildUseCaseStream(void params) async {
    StreamController<List<User>> controller = StreamController<List<User>>();

    try {
      final List<User> response = await _userRepository.getUser();
      controller.add(response);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
