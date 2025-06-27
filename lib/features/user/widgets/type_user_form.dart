import 'package:flutter/material.dart';
import 'package:intern_app/features/user/widgets/user_type_radio.dart';

class TypeUserForm extends StatelessWidget {
  const TypeUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 32,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tipo",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          UserTypeRadio(
            iconUserName: "RESIDENTE",
            iconUserType: Image.asset("assets/imgs/students.png"),
            ),
          UserTypeRadio(
            iconUserName: "PRECEPTOR",
            iconUserType: Image.asset("assets/imgs/doctor.png"),
          ),
          UserTypeRadio(
            iconUserName: "ADMINISTRADOR",
            iconUserType: Image.asset("assets/imgs/admin.png"),
          ),
        ],
      ),
    );
  }
}
