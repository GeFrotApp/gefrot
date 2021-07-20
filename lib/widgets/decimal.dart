import "package:flutter/services.dart";

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r"^\d*\,?\d*");
    var newValueNew =
        TextEditingValue(text: newValue.text.replaceAll(".", ","), selection: TextSelection.fromPosition(TextPosition(offset: newValue.text.length)));
    String newString = regEx.stringMatch(newValueNew.text) ?? "";
    return newString == newValueNew.text ? newValueNew : oldValue;
  }
}
