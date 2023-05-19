import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

