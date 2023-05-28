import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ColorModel{
  static Color primary = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color green = const Color(0xFF3CB371);
  static Color red = const Color(0xFFFF0000);
  static Color orange = const Color(0xFFFFA500);
  static Color pink = const Color(0xFFFFC0CB);
}

class Textstyle {
  static TextStyle titlesize = const TextStyle(fontSize: 20);
}

class Dropmenu extends HookConsumerWidget{
  const Dropmenu({
    super.key,
    required this.lists,
    required this.providers,
    required this.controller,
  });
  final List<String> lists;
  final StateProvider providers;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context,WidgetRef ref){
    final _providers = ref.watch(providers);
    return DropdownButton(
        isExpanded: true,
        underline: Container(),
        items: lists.map((String lists) => DropdownMenuItem(value: lists,child: Text(lists))).toList(),
        value: _providers,
        onChanged: (value){
          ref.read(providers.notifier).state = value!;
          controller.text = value.toString()!;
        },
    );
  }
}

class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final int value = int.parse(newValue.text.replaceAll(',', ''));
    final formatter = NumberFormat('#,###');
    final newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 入力値から非数字の文字を除去
    final sanitizedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // 年、月、日ごとに区切る
    final formattedText = _formatDate(sanitizedText);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatDate(String text) {
    if (text.length <= 4) {
      return text;
    } else if (text.length <= 6) {
      return '${text.substring(0, 4)}/${text.substring(4)}';
    } else {
      return '${text.substring(0, 4)}/${text.substring(4, 6)}/${text.substring(6)}';
    }
  }
}


