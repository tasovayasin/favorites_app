import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String avatar;

  @HiveField(4)
  final String age;

  @HiveField(5)
  final String city;

  String get displayName => "$firstName $lastName";

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.age,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["image"],
        age: json["age"].toString(),
        city: json["address"]["city"],
      );
}
