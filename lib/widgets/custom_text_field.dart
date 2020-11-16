import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextField extends StatelessWidget {

  CustomTextField({this.hint, this.prefix, this.suffix, this.obscure = false,
    this.textInputType, this.onChanged, this.enabled, this.controller, this.formatter, this.color
  });

  final TextEditingController controller;
  final String hint;
  final Widget prefix;
  final Widget suffix;
  final bool obscure;
  final TextInputType textInputType;
  final Function(String) onChanged;
  final bool enabled;
  final TextInputFormatter formatter;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        textAlign: TextAlign.left,
        style: TextStyle(color: color),
        controller: controller,
        obscureText: obscure,
        keyboardType: textInputType,
        onChanged: onChanged,
        enabled: enabled,
        textCapitalization: TextCapitalization.characters,
        inputFormatters: <TextInputFormatter>[formatter!=null? formatter: new MaskTextInputFormatter(mask: '###############################################', filter: { "#": RegExp(r'[a-zA-Z0-9@. ]') })],
        decoration: InputDecoration(
          hintText: hint,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Color.fromARGB(255, 25, 153, 158))),
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        textAlignVertical: TextAlignVertical.bottom,
      ),
    );
  }
}
