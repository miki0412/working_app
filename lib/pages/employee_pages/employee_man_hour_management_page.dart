import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';
import 'package:working_app/style.dart';

class EmployeeManHourManagementPage extends HookConsumerWidget{
  EmployeeManHourManagementPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('工数管理',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: CustomDrawer(),
    );
  }
}