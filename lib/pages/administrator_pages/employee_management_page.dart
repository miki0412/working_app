import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';


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

  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('従業員管理',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const  Text('氏名'),
              Textfild(
                keybordtype: TextInputType.text,
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
                child: Dropmenu(
                    lists: const [
                      '部署を選択してください',
                      '企画部',
                      '建築部',
                      '土木部',
                      '住宅事業部',
                      '管理部',
                    ],
                    providers: departmentProvider,
                    controller: department,
                ),
              ),
              sizedbox,
              const Text('入社年月日'),
              Row(
                children: [
                  Expanded(child:  Textfild(
                      keybordtype: TextInputType.datetime,
                      hinttext: '年',
                      controller: year
                  ),),
                  const Text('年'),
                  Expanded(child: Textfild(
                      keybordtype: TextInputType.datetime,
                      hinttext: '月',
                      controller: month
                  ),),
                  const Text('月'),
                  Expanded(child: Textfild(
                      keybordtype: TextInputType.datetime,
                      hinttext: '日',
                      controller: day
                  ),),
                  const Text('日'),
                ],
              ),
              sizedbox,
              const Text('勤続年数'),
              Textfild(
                  keybordtype: TextInputType.number,
                  hinttext: '勤続年数を入力してください',
                  controller: keepworking
              ),
              sizedbox,
              const Text('有給日数'),
              Row(
                children: [
                  Expanded(child: Textfild(
                      keybordtype: TextInputType.number,
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
                  onPressed: (){
                    employee();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('従業員情報を登録しました'),
                        backgroundColor: Colors.blue,
                      )
                    );},
                  child: const Text('登録する'),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}

class Textfild extends StatelessWidget{
  const Textfild({
    required this.keybordtype,
    required this.hinttext,
    required this.controller,
  });
  final TextInputType keybordtype;
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
          keyboardType: keybordtype,
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