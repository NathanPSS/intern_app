import 'package:flutter/material.dart';
import 'package:intern_app/core/widgets/test.dart';
import 'package:intern_app/features/registries/domain/records/registry_data_table_record.dart';
import 'package:intern_app/features/user/domain/user_data_table_record.dart';

final sampleDataUsers = [
  UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/admin.png")),
  ),
  UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/doctor.png")),
  ),UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/students.png")),
  ),UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/admin.png")),
  ),UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/students.png")),
  ),UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/doctor.png")),
  ),UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/students.png")),
  ),UserDataTableRecord(
    userMatricula: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    userName: 'João Silva',
    userEmail: 'joao@gmail.com',
    userType: SizedBox(width: 32,height: 32,child: Image.asset("assets/imgs/doctor.png")),
  ),
];