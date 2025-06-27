import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';
import 'package:intern_app/features/user/widgets/user_display_table_cell.dart';

class UserDisplayTableBody extends StatelessWidget {
  const UserDisplayTableBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: windowDesktopAppHeight(context) * 0.36,
        right: 24,
        left: 24,
      ),
      height: windowDesktopAppHeight(context) * 0.54,
      width: windowDesktopAppWidth(context) * 0.8,
      decoration: BoxDecoration(color: Colors.white,border: Border(left : BorderSide(color: Color.fromRGBO(191, 191, 191, 1), width: 1))),
      child: ListView(children: [
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/admin.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/students.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
        UserDisplayTableCell(userName: "userName", userMatricula: "userMatricula", userEmail: "userEmail", userType: Image.asset("assets/imgs/doctor.png")),
      ]));
  }
}
