class MyUser {
  final String email;

  MyUser({required this.email});


  MyUser.fromMap(Map snapshot)
      : email = snapshot['email'] ?? '';
}

class UserData{

  late final String name;
  late final String email;
  late final int status;
  late final List<dynamic> students;

  UserData({
    required this.status,
    required this.name,
    required this.email,
    required this.students});
}

