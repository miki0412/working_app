import 'package:flutter/material.dart';

class appbarmodel extends StatelessWidget implements PreferredSizeWidget{
  const appbarmodel({
    required this.title
  });
  final String title;

  @override
  Widget build(BuildContext context){
    return AppBar(
      title: Text(title,style: TextStyle(color:ColorModel.white,),),
      backgroundColor:ColorModel.green,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class sizedbox extends StatelessWidget{
  const sizedbox ({
    required this.widthsize,
    required this.heightsize,
    required this.child,
  });
  final double widthsize;
  final double heightsize;
  final Widget child;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: widthsize,
      height: heightsize,
      child: child,
    );
  }
}

class ColorModel{
  static Color primary = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color green = const Color(0xFF3CB371);
  static Color red = const Color(0xFFFF0000);
  static Color orange = const Color(0xFFFFA500);
  static Color pink = const Color(0xFFFFC0CB);
}

