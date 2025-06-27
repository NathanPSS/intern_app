
import 'package:flutter/material.dart';

class DataUserForm extends StatelessWidget {
  const DataUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 40,
        children: [
          Text(
            "Dados",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(decoration: InputDecoration(hintText: "Email")),
          TextField(
            decoration: InputDecoration(hintText: "Matrícula"),
          ),
          TextField(decoration: InputDecoration(hintText: "Nome")),
          TextField(decoration: InputDecoration(hintText: "Senha")),
        ],
      ),
    );
  }
}