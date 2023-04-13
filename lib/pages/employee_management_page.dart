import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/adminstrator_custom_drawer.dart';
import 'package:working_app/pages/businesstrip_application_page.dart';


class EmployeeManagementPage extends HookConsumerWidget{
  EmployeeManagementPage({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController department = TextEditingController();
  final TextEditingController year = TextEditingController();
  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController keepworking = TextEditingController();
  final TextEditingController offday = TextEditingController();

  final departmentProvider = StateProvider((ref) => '部署を選択してください');

  void employee() async{
    await FirebaseFirestore.instance.collection('employee').doc().set({
      'employee_name':name.text,
      'department':department.text,
      'year':year.text,
      'month':month.text,
      'day':day.text,
      'keppworking':keepworking.text,
      'offday':offday.text,
    });
  }

  @override
  final departmentlists = <String>[
    '部署を選択してください',
    '企画部',
    '建築部',
    '土木部',
    '住宅事業部',
    '管理部'
  ];

  Widget build(BuildContext context,WidgetRef ref){
    final departmentmethod = ref.watch(departmentProvider);
    return Scaffold(
      appBar: const appbarmodel(
        title: '従業員管理',
      ),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const  Text('氏名'),
              textfild(
                  hinttext: '従業員名を入力してください',
                  controller: name,
              ),
              const  Text('所属部署'),
              sizedbox,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorModel.primary),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: DropdownButton(
                  underline: Container(),
                  isExpanded: true,
                  items:departmentlists.map((String departmentlists) => DropdownMenuItem(value:departmentlists,child: Text(departmentlists))).toList(),
                  value: departmentmethod,
                  onChanged: (value){
                    ref.read(departmentProvider.notifier).state = value!;
                    department.text = value!;
                  },
                ),
              ),
              sizedbox,
              const Text('入社年月日'),
              Row(
                children: [
                 Expanded(child:  textfild(
                      hinttext: '年',
                      controller: year
                  ),),
                  const Text('年'),
                  Expanded(child: textfild(
                      hinttext: '月',
                      controller: month
                  ),),
                  const Text('月'),
                  Expanded(child: textfild(
                      hinttext: '日',
                      controller: day
                  ),),
                  const Text('日'),
                ],
              ),
             sizedbox,
             const Text('勤続年数'),
              textfild(
                  hinttext: '勤続年数を入力してください',
                  controller: keepworking
              ),
              sizedbox,
              const Text('有給日数'),
              Row(
                children: [
                  Expanded(child: textfild(
                      hinttext: '有給日数を入力してください',
                      controller: offday
                  ),),
                  const Text('日'),
                ],
              ),
              sizedbox,
              SizedBox(
                width: double.infinity,
                child:ElevatedButton(
                  onPressed: (){employee();},
                  child: const Text('登録する'),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}

class textfild extends StatelessWidget{
  const textfild({
    required this.hinttext,
    required this.controller,
 });
  final String hinttext;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorModel.primary),
        borderRadius: BorderRadius.circular(5),
      ),
      //width: double.infinity,
      child:TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      )
    );
  }
}

SizedBox sizedbox = const SizedBox(height: 10);