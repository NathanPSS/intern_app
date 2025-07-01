import 'package:intern_app/features/user/domain/user_type.dart';

class User {
  final String matricula;
  final String email;
  final String password;
  final String name;
  final UserType role;

  User({required this.name,required this.matricula, required this.email, required this.password, required this.role});

factory User.fromJSON(Map<String,dynamic> data){
return User(
  name: data['name'],
  matricula: data['matricula'],
  email: data['email'],
  password: data['password'],
  role: data['role']
);
}
}