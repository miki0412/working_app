import'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';
import 'package:working_app/style.dart';

class AdministratorInformationPage extends HookConsumerWidget{
  AdministratorInformationPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title:Text('お知らせ',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:Column(
            children: [
              Text('お知らせ'),
            ],
          )
        ),
      ),
    );
  }
}