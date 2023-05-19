import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';

class ManHourManagementPage extends HookConsumerWidget{
  ManHourManagementPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('工数管理',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
        leading: null,
      ),
      endDrawer:AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        ),
      ),
    );
  }
}