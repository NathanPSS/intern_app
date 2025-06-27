import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';

class UserDisplayTableCell extends StatelessWidget {
  const UserDisplayTableCell({
    super.key,
    required this.userName,
    required this.userMatricula,
    required this.userEmail,
    required this.userType,
  });

  final String userName;

  final String userMatricula;

  final String userEmail;

  final Widget userType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: windowDesktopAppWidth(context) * 0.024,top: 16, bottom: 16),
      width: windowDesktopAppWidth(context) * 0.8,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(191, 191, 191, 1), width: 2),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: windowDesktopAppWidth(context) * 0.48,
            child: Row(
              spacing: windowDesktopAppWidth(context) * 0.072,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(userName, style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(userMatricula, style: TextStyle(fontWeight: FontWeight.w600)),
                  Text(userEmail, style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 32, height: 32, child: userType),
                ],
              ),
          ),
          SizedBox(width: windowDesktopAppWidth(context) * 0.056),
          SizedBox(
          width:  windowDesktopAppWidth(context) * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Colors.transparent,
                    child: InkWell(
                        onTap: () => {},
                        hoverColor: Colors.blue[100],
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Container(padding: EdgeInsets.all(4), child: Image.asset("assets/imgs/edit-user.png")),
                        ),
                      ),
                    ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => {},
                    hoverColor: Colors.blue[100],
                      child: Container(padding: EdgeInsets.all(4), child: Icon(Icons.person_remove,color: Colors.red,size: 34)),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
