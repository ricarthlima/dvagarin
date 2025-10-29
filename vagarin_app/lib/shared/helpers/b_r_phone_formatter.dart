import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BRPhoneFormatter extends TextInputFormatter {
  String _digits(String s) => s.replaceAll(RegExp(r'\D'), '');
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final raw = _digits(
      newValue.text,
    ).substring(0, _digits(newValue.text).length.clamp(0, 11));
    String out;
    if (raw.isEmpty) {
      out = '';
    } else if (raw.length <= 2) {
      out = '($raw';
    } else if (raw.length <= 6) {
      out = '(${raw.substring(0, 2)}) ${raw.substring(2)}';
    } else if (raw.length <= 10) {
      out =
          '(${raw.substring(0, 2)}) ${raw.substring(2, 6)}-${raw.substring(6)}';
    } else {
      out =
          '(${raw.substring(0, 2)}) ${raw.substring(2, 7)}-${raw.substring(7)}';
    }
    final sel = out.length;
    return TextEditingValue(
      text: out,
      selection: TextSelection.collapsed(offset: sel),
    );
  }
}
