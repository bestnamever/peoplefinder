class User {
  final String id;
  final String name;
  final String imageUrl;
  final double x;
  final double y;
  final double z;
  final bool online;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.x,
    this.y,
    this.z,
    this.online,
  });
}

final User currentUser = User(
  id: "0",
  name: 'Current User',
  imageUrl: 'assets/images/greg.jpg',
  x: 13.8,
  y: 233.1,
  z: 1.0,
  online: true,
);

final User greg = User(
  id: "1",
  name: 'Greg',
  imageUrl: 'assets/images/greg.jpg',
  x: 120.0,
  y: 13.5,
  z: 8.3,
  online: false,
);
final User james = User(
  id: "2",
  name: 'James',
  imageUrl: 'assets/images/james.jpg',
  x: 120.0,
  y: 13.5,
  z: 8.3,
  online: true,
);
final User john = User(
  id: "3",
  name: 'John',
  imageUrl: 'assets/images/john.jpg',
  x: 120.0,
  y: 13.5,
  z: 8.3,
  online: false,
);
final User olivia = User(
  id: "4",
  name: 'Olivia',
  imageUrl: 'assets/images/olivia.jpg',
  x: 120.0,
  y: 13.5,
  z: 8.3,
  online: true,
);
final User sam = User(
  id: "5",
  name: 'Sam',
  imageUrl: 'assets/images/sam.jpg',
  x: 120.0,
  y: 13.5,
  z: 8.3,
  online: true,
);
final User sophia = User(
  id: "6",
  name: 'Sophia',
  imageUrl: 'assets/images/sophia.jpg',
  x: 120.0,
  y: 13.5,
  z: 8.3,
  online: true,
);
final User steven = User(
  id: "7",
  name: 'Steven',
  imageUrl: 'assets/images/steven.jpg',
  x: 120.0,
  y: 13.5,
  z: 8.3,
  online: true,
);
