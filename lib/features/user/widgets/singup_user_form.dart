import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intern_app/core/constants/window_constants.dart';
import 'package:intern_app/core/widgets/generic_button.dart';
import 'package:intern_app/features/user/widgets/data_user_form.dart';
import 'package:intern_app/features/user/widgets/type_user_form.dart';

class SingUpUserForm extends StatelessWidget {
  const SingUpUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        padding: EdgeInsets.only(left: 56, right: 56, top: 16),
        margin: EdgeInsets.only(top: 156, left: 24),
        width: windowDesktopAppWidth(context) * 0.8,
        height: windowDesktopAppHeight(context) * 0.64 + 28,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DataUserForm(),
                SizedBox(width: 100),
                TypeUserForm()
              ],
            ),
            SizedBox(height: 36),
            GenericButton(text: "Cadastrar",buttonWidth: 200,buttonHeight: 40)
          ],
        ),
      ),
    );
  }
}
