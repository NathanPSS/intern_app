import 'package:flutter/material.dart';

class RegistryDataTableRecord {
  final String id;
  final String residente;
  final String preceptor;
  final DateTime data;
  final String setor;
  final Widget status;

  RegistryDataTableRecord({
    required this.id,
    required this.residente,
    required this.preceptor,
    required this.data,
    required this.setor,
    required this.status,
  });
}