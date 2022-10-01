import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextField extends StatelessWidget {
  DefaultTextField(
      {super.key, this.labelText, this.controller, this.validator, this.lines});

  String? labelText;
  TextEditingController? controller;
  String? Function(String?)? validator;

  int? lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText!),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(255, 221, 221, 221)),
          child: TextFormField(
            validator: validator,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            minLines: lines,
            maxLines: lines,
            controller: controller,
          ),
        )
      ],
    );
  }
}
