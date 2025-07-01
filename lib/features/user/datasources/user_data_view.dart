import 'package:intern_app/features/user/domain/user.dart';
import 'package:intern_app/features/user/domain/user_type.dart';

class UserDataView {
  final String userName;
  final String userEmail;
  final String userMatricula;
  final UserType userType;

  UserDataView({
    required this.userName,
    required this.userEmail,
    required this.userMatricula,
    required this.userType,
  });

  factory UserDataView.fromUser(User user) {
    return UserDataView(
      userName: user.name,
      userEmail: user.email,
      userMatricula: user.matricula,
      userType: user.role,
    );
  }
}
