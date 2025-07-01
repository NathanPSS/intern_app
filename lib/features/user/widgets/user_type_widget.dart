
import 'package:flutter/material.dart';
import 'package:intern_app/features/user/domain/user_type.dart';

class UserTypeWidget extends StatelessWidget {

  final UserType userType;

  const UserTypeWidget({super.key, required this.userType});

  Widget _getUserTypeImg(){
    String typeString = userType.name;
    return Image.asset("assets/imgs/$typeString.png");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: _getUserTypeImg(),
    );
  }
}