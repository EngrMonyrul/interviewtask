import 'package:flutter/material.dart';

import '../../../../../controls/providers/home_page_provider.dart';

Row taskStatus(HomePageProvider property) {
  return Row(
    children: [
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Task Status:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(width: 30),
      DropdownButton<bool>(
        hint: const Text('Select'),
        value: property.status,
        onChanged: (actionValue) {
          property.setStatus(value: actionValue!);
        },
        items: const [
          DropdownMenuItem(
            value: true,
            child: Text('Completed'),
          ),
          DropdownMenuItem(
            value: false,
            child: Text('Backlog'),
          ),
        ],
      ),
    ],
  );
}
