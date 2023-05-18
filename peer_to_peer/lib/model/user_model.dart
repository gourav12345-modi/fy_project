class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Nick Fury',
  imageUrl: 'assets/images/nick-fury.jpg',
  isOnline: true,
);

// USERS
final User GouravModi = User(
  id: 1,
  name: 'Gourav Modi',
  imageUrl: 'assets/images/ironman.jpeg',
  isOnline: true,
);
final User VishalAnand = User(
  id: 2,
  name: 'Vishal Anand',
  imageUrl: 'assets/images/captain-america.jpg',
  isOnline: true,
);
final User Yuvraj = User(
  id: 3,
  name: 'Yuvraj',
  imageUrl: 'assets/images/hulk.jpg',
  isOnline: false,
);
final User Alfardan = User(
  id: 5,
  name: 'Alfardan arfin',
  imageUrl: 'assets/images/spiderman.jpg',
  isOnline: true,
);
