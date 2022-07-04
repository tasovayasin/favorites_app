import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:favorites_app/src/domain/entities/user.dart';
import 'package:favorites_app/src/domain/repositories/user_repository.dart';
import 'package:favorites_app/src/domain/usecases/get_users.dart';

class HomePresenter extends Presenter {
  late Function getUserOnNext;
  late Function getUserOnError;

  final GetUsers _getUsers;

  HomePresenter(
    UserRepository userRepository,
  ) : _getUsers = GetUsers(userRepository);

  void getUsers() {
    _getUsers.execute(_GetUserObserver(this));
  }

  @override
  void dispose() {
    _getUsers.dispose();
  }
}

class _GetUserObserver extends Observer<List<User>> {
  final HomePresenter _presenter;

  _GetUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getUserOnError(e);
  }

  @override
  void onNext(List<User>? response) {
    _presenter.getUserOnNext(response);
  }
}
