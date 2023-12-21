import 'package:flutter/material.dart';

Container valueNumber(int index) {
  return Container(
    height: 60,
    width: 60,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: const Color(0xFF4c4f4d)),
    ),
    child: Text(
      '${index + 1}',
      style: const TextStyle(fontSize: 40),
    ),
  );
}