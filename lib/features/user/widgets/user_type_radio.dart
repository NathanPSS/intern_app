import 'package:flutter/material.dart';

class UserTypeRadio extends StatelessWidget {
  const UserTypeRadio({
    super.key,
    required this.iconUserType,
    required this.iconUserName,
  });

  final Widget iconUserType;

  final String iconUserName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: 2, groupValue: [], onChanged: (value) {}),
        SizedBox(width: 36),
        SizedBox(width: 56, height: 56, child: iconUserType),
        SizedBox(width: 36),
        Text(iconUserName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ],
    );
  }
}
