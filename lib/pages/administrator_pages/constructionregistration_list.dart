import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';

class ConstractionregistrationList extends HookConsumerWidget{
  const ConstractionregistrationList({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title:'工事登録申請一覧'),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        ),
      ),
    );
  }
}