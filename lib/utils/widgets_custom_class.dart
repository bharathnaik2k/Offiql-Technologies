import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String? title;
  final Widget? iconWidget;
  const CustomAppbar({
    super.key,
    required this.title,
    this.iconWidget,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (iconWidget != null) iconWidget!,
      ],
      backgroundColor: const Color.fromARGB(255, 68, 68, 68),
      foregroundColor: Colors.white,
      centerTitle: true,
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.nameController,
    required this.hintText,
  });

  final TextEditingController nameController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color.fromARGB(255, 215, 215, 215)),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
          ),
        ),
        controller: nameController,
      ),
    );
  }
}
