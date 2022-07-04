// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:favorites_app/src/domain/entities/user.dart';
import 'package:favorites_app/src/domain/repositories/user_repository.dart';

class DataUserRepository implements UserRepository {
  final UsersBox = Hive.box("users");

  final client = Dio();
  @override
  Future<List<User>> getUser() async {
    try {
      final response = await client.get("https://dummyjson.com/users/");
      if (response.statusCode == 200) {
        UsersBox.put(
          "users",
          List<User>.from(
            (response.data["users"]).map(
              (json) => User.fromJson(json),
            ),
          ),
        );
        return UsersBox.get("users");
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
