import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';


class PaidleaveApplicationPage extends HookConsumerWidget{
  PaidleaveApplicationPage({super.key});

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _day = TextEditingController();
  final TextEditingController thepurpose = TextEditingController();
  final TextEditingController offdays = TextEditingController();
  final daysProvider = StateProvider((ref) => '有給取得日数を選択してください');

  void application() async{
    await FirebaseFirestore.instance.collection('有給休暇申請').doc().set({
      'month':month.text,
      'day':day.text,
      '_month':month.text,
      '_day':_day.text,
      'thepurpose':thepurpose.text,
      'offdays':offdays.text,
      'submissiontime':DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(
        title: '有給休暇申請',
      ),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(child:Container(
        margin: const EdgeInsets.only(top: 30,right: 10,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('有給休暇申請取得2日前までに申請するようにしましょう'),
            const SizedBox(height: 10),
            const Text('有給休暇を取得する日にちを入力してください'),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(child: container(controller: month, hinttext: '月'),),
                      const Text('月'),
                      Expanded(
                          child: container(
                              controller: day,
                              hinttext: '日'
                          )
                      ),
                      const Text('日'),
                  const Text('〜',textAlign: TextAlign.end,),
                      Expanded(child: container(controller: _month, hinttext: '月'),),
                      const Text('月'),
                      Expanded(
                          child: container(
                              controller: _day,
                              hinttext: '日'
                          )
                      ),
                      const Text('日'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:dropmenu(
                        lists: const [
                          '有給取得日数を選択してください',
                          '0.5日間',
                          '1日間',
                          '1.5日間',
                          '2日間',
                          '2.5日間',
                          '3日間',
                          '3.5日間',
                          '4日間',
                        ],
                        providers: daysProvider,
                        controller: offdays,
                    ),
                  ),
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
                  sizedbox(
                      widthsize: double.infinity,
                      heightsize: 40,
                      child: ElevatedButton(
                        onPressed: (){application();},
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

class container extends StatelessWidget{
  const container({
    required this.controller,
    required this.hinttext,
  });
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

