import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';


class SubstituteholidayApplicationPage extends HookConsumerWidget{
  SubstituteholidayApplicationPage({super.key});

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _day = TextEditingController();
  final TextEditingController thepurpose = TextEditingController();

  void application() async{
    await FirebaseFirestore.instance.collection('振替休日申請').doc().set({
      'month':month.text,
      'day':day.text,
      '_month':_month.text,
      '_day':_day.text,
      'thepurpose':thepurpose.text,
      'submissiontime':DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('振替休日申請',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      body: SingleChildScrollView(child:Container(
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text('振替休日を申請する場合は2日前までに提出してください'),
            const SizedBox(height: 10),
            const Text('振替をする日にちを入力してください'),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.only(top: 15,right: 10,left:10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  const Text('の出勤に変えて'),
                  Row(
                    children:[
                      Expanded(
                        child: ContainerBox(
                            keybordtype: TextInputType.datetime,
                            controller: _month,
                            hinttext: '月'
                        ),
                      ),
                      const Text('月'),
                      Expanded(
                          child: ContainerBox(
                            keybordtype: TextInputType.datetime,
                            controller: _day,
                            hinttext: '日',
                          )
                      ),
                      const Text('日'),
                    ],
                  ),
                  const Text('の振替休日を申請します。'),
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
                          application();
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
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

