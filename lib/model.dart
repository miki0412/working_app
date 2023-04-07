import 'package:flutter/material.dart';

class appbarmodel extends StatelessWidget implements PreferredSizeWidget{
  const appbarmodel({
    required this.title
  });
  final String title;

  @override
  Widget build(BuildContext context){
    return AppBar(
      title: Text(title,style: const TextStyle(color:Color(0xFFFFFFFF),),),
      backgroundColor:const  Color(0xFF3CB371),
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
