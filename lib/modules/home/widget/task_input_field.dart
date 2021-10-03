import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TaskInputField extends StatelessWidget {
  const TaskInputField({
    Key? key,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFEBEBEB),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: ListTile(
        title: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isCollapsed: true,
            contentPadding: EdgeInsets.zero,
            labelText: 'Adicione uma tarefa',
            labelStyle: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFFB2B2B2),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        trailing: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 56,
            padding: const EdgeInsets.only(left: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 1.0,
                  color: Color(0xFFEBEBEB),
                ),
              ),
            ),
            child: const Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xFFB2B2B2),
            ),
          ),
        ),
      ),
    );
  }
}
