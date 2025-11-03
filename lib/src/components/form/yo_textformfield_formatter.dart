import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedText.isEmpty) return newValue.copyWith(text: '');

    final number = int.parse(cleanedText);
    final formatted = _formatCurrency(number);

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatCurrency(int amount) {
    if (amount == 0) return '0';

    final formatter = NumberFormat.currency(
      symbol: 'Rp ',
      decimalDigits: 0,
      locale: 'id_ID',
    );

    return formatter.format(amount);
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.isEmpty) return newValue.copyWith(text: '');

    String formatted = '';
    if (text.startsWith('0')) {
      if (text.length >= 3) {
        formatted = text.substring(0, 3);
        if (text.length > 3)
          formatted += ' ${text.substring(3, min(text.length, 7))}';
        if (text.length > 7)
          formatted += ' ${text.substring(7, min(text.length, 11))}';
        if (text.length > 11)
          formatted += ' ${text.substring(11, min(text.length, 15))}';
      } else {
        formatted = text;
      }
    } else if (text.startsWith('62')) {
      formatted = '+62';
      if (text.length > 2)
        formatted += ' ${text.substring(2, min(text.length, 5))}';
      if (text.length > 5)
        formatted += ' ${text.substring(5, min(text.length, 9))}';
      if (text.length > 9)
        formatted += ' ${text.substring(9, min(text.length, 13))}';
    } else {
      formatted = text;
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.isEmpty) return newValue.copyWith(text: '');

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) formatted += ' ';
      formatted += text[i];
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
