// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:favorites_app/src/app/pages/favorites_view.dart';
import 'package:favorites_app/src/app/pages/home_presenter.dart';
import 'package:favorites_app/src/app/pages/home_view.dart';
import 'package:favorites_app/src/domain/entities/user.dart';
import 'package:favorites_app/src/domain/repositories/user_repository.dart';

class HomeController extends Controller {
  List<User> favoriteUsers = [];
  final HomePresenter _presenter;
  final favoritesBox = Hive.box("favoriteUsers");
  final usersBox = Hive.box("users");

  final bool favorite = false;

  HomeController(
    UserRepository userRepository,
  ) : _presenter = HomePresenter(
          userRepository,
        );

  var users = [];

  void addFavorites(User user) {
    favoriteUsers.add(user);
    favoritesBox.add(user);
    refreshUI();
  }

  void removeFavorite(int i) {
    favoritesBox.deleteAt(i);
    refreshUI();
  }

  @override
  void onInitState() {
    _presenter.getUsers();
    for (int i = 0; i < favoritesBox.length; i++) {
      favoriteUsers.add(favoritesBox.getAt(i));
    }
    for (int i = 0; i < usersBox.length; i++) {
      users.add(List<User>.from(usersBox.getAt(i))[i]);
    }
  }

  @override
  void initListeners() {
    _presenter.getUserOnNext = (List<User> response) {
      users = response;
      usersBox.add(users);
      refreshUI();
    };
    _presenter.getUserOnError = (e) {
      print("Error getUsers");
    };
  }

  @override
  void onDisposed() {
    _presenter.dispose();
  }

  void getUser() {
    _presenter.getUsers();
  }

  void navigateToFavoritesPage() {
    Navigator.push(
      getContext(),
      MaterialPageRoute(builder: (context) => FavoritesView()),
    );
  }

  void navigateToHomePage() {
    Navigator.push(
      getContext(),
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }
}
