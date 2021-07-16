import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mask_text_input_formatter/mask_text_input_formatter.dart";

class CustomPassTextField extends StatelessWidget {
  CustomPassTextField({this.hint, this.prefix, this.suffix, this.obscure = false,
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

      padding: EdgeInsets.fromLTRB(0, 0.0, 5.0, 0.0),
      alignment: Alignment.center,
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
        inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(92), formatter!=null? formatter: new MaskTextInputFormatter(mask: "###############################################", filter: { "#": RegExp(r"[a-zA-Z0-9@. ]") })],
        decoration: InputDecoration(
          suffixIcon: suffix,
          hintText: hint,
          contentPadding: EdgeInsets.fromLTRB(5.0 , 15.0 , 5.0 , 15.0),
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Color.fromARGB(255, 25, 153, 158))),

        ),
        textAlignVertical: TextAlignVertical.bottom,

      ),
    );
  }
}
