import 'package:flutter/material.dart';

Center errorWidget() {
  return const Center(
    child: Text(
      'Empty Data\nPlease Add Data',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
