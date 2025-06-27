import 'package:flutter/material.dart';
import 'package:intern_app/core/constants/window_constants.dart';
import 'package:intern_app/features/user/widgets/user_search.dart';

class UserDisplayTableHead extends StatelessWidget {
  const UserDisplayTableHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: windowDesktopAppWidth(context) * 0.8,
      height: windowDesktopAppHeight(context) * 0.16,
      padding: EdgeInsets.only(top: 12),
      margin: EdgeInsets.only(top: windowDesktopAppHeight(context) * 0.2, left: 24,right: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Color.fromRGBO(244, 244, 244, 1),
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(191, 191, 191, 1),
                width: 2
          )
        )
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 40),
                child: UserSearch()
            ),
            Container(
              margin: EdgeInsets.only(left: windowDesktopAppWidth(context) * 0.028),
              child: Row(
                  spacing: windowDesktopAppWidth(context) * 0.072,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Nome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Matricula",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Tipo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: windowDesktopAppWidth(context) * 0.16)
                  ],
                ),
            ),
          ],
      ),
    );
  }
}
