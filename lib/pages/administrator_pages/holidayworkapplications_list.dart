import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';
import 'package:working_app/pages/custom_drawer.dart';

class HolidayworkapplicationsList extends HookConsumerWidget{
  const HolidayworkapplicationsList({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title:'休日出勤申請書一覧'),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        ),
      ),
    );
  }
}