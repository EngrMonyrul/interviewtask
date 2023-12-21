import 'package:flutter/material.dart';

Column inputField(
    {required String title,
    required String hintText,
    required TextEditingController controller,
    required bool maxLine,
    required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        height: maxLine ? MediaQuery.of(context).size.height * .3 : null,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          maxLines: maxLine ? null : null,
          keyboardType: title == 'ID:' ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    ],
  );
}
