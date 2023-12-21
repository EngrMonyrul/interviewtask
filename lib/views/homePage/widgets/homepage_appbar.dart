import 'package:flutter/material.dart';

AppBar homepageAppbar(
    {required bool needActionButton, required String title, Function()? actionButtonPressed, IconData? iconData}) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: false,
    title: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Color(0xFF4c4f4d),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(5, 5),
            spreadRadius: 0,
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(title),
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );
}
