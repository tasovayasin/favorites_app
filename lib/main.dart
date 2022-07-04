import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:favorites_app/src/app/pages/home_view.dart';
import 'package:favorites_app/src/domain/entities/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox("favoriteUsers");
  await Hive.openBox("users");

  runApp(
    MaterialApp(
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
