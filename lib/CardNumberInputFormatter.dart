import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    if (text.length <= 16) {
      var formattedText = '';
      for (var i = 0; i < text.length; i++) {
        if (i % 4 == 0 && i != 0) {
          formattedText += ' ';
        }
        formattedText += text[i];
      }
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    return oldValue;
  }
}
