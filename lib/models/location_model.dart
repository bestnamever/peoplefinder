import 'package:flutter_chat_ui_starter/models/user_model.dart';

class UserLocation {
  final User user;
  final double x;
  final double y;
  final double z;
  final bool online;

  UserLocation({
    this.user,
    this.x,
    this.y,
    this.z,
    this.online,
  });
}

final User currentUser =
    User(id: "0", name: 'Current User', imageUrl: 'assets/images/greg.jpg');

// USERS
final User greg = User(id: "1", name: 'Greg', imageUrl: 'assets/images/greg.jpg');
final User james =
    User(id: "2", name: 'James', imageUrl: 'assets/images/james.jpg');
final User john = User(id: "3", name: 'John', imageUrl: 'assets/images/john.jpg');
final User olivia =
    User(id: "4", name: 'Olivia', imageUrl: 'assets/images/olivia.jpg');
final User sam = User(id: "5", name: 'Sam', imageUrl: 'assets/images/sam.jpg');
final User sophia =
    User(id: "6", name: 'Sophia', imageUrl: 'assets/images/sophia.jpg');
final User steven =
    User(id: "7", name: 'Steven', imageUrl: 'assets/images/steven.jpg');

List<UserLocation> coordinate = [
  UserLocation(user: currentUser, x: 132.0, y: 36.0, z: 3.5,online: true),
  UserLocation(user: james, x: 256.0, y: 27.0, z: 0.0,online: false),
  UserLocation(user: greg, x: 256.0, y: 27.0, z: 0.0,online: true),
  UserLocation(user: john, x: 222.0, y: 68.0, z: 3.0,online: false),
  UserLocation(user: sam, x: 52.0, y: 99.0, z: 2.0,online: false),
  UserLocation(user: sophia, x: 150.0, y: 156.0, z: 4.0,online: true),
  UserLocation(user: steven, x: 45.0, y: 204.0, z: 6.0,online: true),
];
