import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';


class HolidayworkApplicationPage extends HookConsumerWidget{
  HolidayworkApplicationPage({super.key});

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController hour = TextEditingController();
  final TextEditingController minute = TextEditingController();
  final TextEditingController _hour =TextEditingController();
  final TextEditingController _minute = TextEditingController();
  final TextEditingController thepurpose = TextEditingController();
  final TextEditingController holidayworkplace = TextEditingController();

  final placeProvider = StateProvider((ref) => '場所を選択してください');

  void applications() async {
    await FirebaseFirestore.instance.collection('休日出勤申請').doc().set({
      'month':month.text,
      'day':day.text,
      'hour':hour.text,
      'minute':minute.text,
      '_hour':_hour.text,
      '_minute':minute.text,
      'thepurpose':thepurpose.text,
      'holidayworkplace':holidayworkplace.text,
      'submissiontime':DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    final place = ref.watch(placeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('休日出勤申請',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      body: SingleChildScrollView(child:Container(
        margin: const EdgeInsets.only(top: 30,right: 10,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('休日出勤をする場合は前日の15時までに提出してください'),
            const SizedBox(height: 10),
            const Text('休日出勤をする日にち及び時間を入力してください'),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child:Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: ContainerBox(keybordtype:TextInputType.datetime,controller: month, hinttext: '月'),),
                      const Text('月'),
                      Expanded(
                          child: ContainerBox(
                              keybordtype: TextInputType.datetime,
                              controller: day,
                              hinttext: '日'
                          )
                      ),
                      const Text('日'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: ContainerBox(keybordtype:TextInputType.datetime,controller: hour, hinttext: '時'),),
                      const Text('時'),
                      Expanded(child: ContainerBox(keybordtype:TextInputType.datetime,controller: minute, hinttext: '分'),),
                      const Text('分'),
                      const Text('〜'),
                      Expanded(child: ContainerBox(keybordtype:TextInputType.datetime,controller: _hour, hinttext: '時'),),
                      const Text('時'),
                      Expanded(child: ContainerBox(keybordtype:TextInputType.datetime,controller: _minute, hinttext: '分'),),
                      const Text('分'),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:DropdownButton(
                      isExpanded:true,
                      underline: Container(),
                      items: const [
                        DropdownMenuItem(value:'場所を選択してください',child: Text('場所を選択してください'),),
                        DropdownMenuItem(value:'会社',child: Text('会社'),),
                        DropdownMenuItem(value:'現場',child: Text('現場'),),
                      ],
                      value: place,
                      onChanged: (value){
                        ref.read(placeProvider.notifier).state = value!;
                        holidayworkplace.text = value!;
                        },
                    ),),
                  Container(
                    margin: const EdgeInsets.only(top: 15,bottom:15),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:TextFormField(
                      controller: thepurpose,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: '理由を入力してください',
                        border: OutlineInputBorder(),
                      ),

                    ),),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: (){
                          applications();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('申請が完了しました'),
                              backgroundColor: Colors.blue,
                            ),
                          );},
                        child: const Text('申請する',style: TextStyle(fontSize: 15),),
                      )
                  ),
                ],
              ),),
          ],
        ),
      ),),
    );
  }
}

class ContainerBox extends StatelessWidget{
  const ContainerBox({
    required this.keybordtype,
    required this.controller,
    required this.hinttext,
  });
  final TextInputType keybordtype;
  final TextEditingController controller;
  final String hinttext;

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF000000),),
        color: ColorModel.white,
      ),
      child: TextFormField(
        keyboardType: keybordtype,
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

