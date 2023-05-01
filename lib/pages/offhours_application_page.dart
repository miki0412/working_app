import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';


class OffhoursApplicationPage extends HookConsumerWidget{
  OffhoursApplicationPage({super.key});

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController hour = TextEditingController();
  final TextEditingController minute = TextEditingController();
  final TextEditingController _hour = TextEditingController();
  final TextEditingController _minute = TextEditingController();
  final TextEditingController thepurpose = TextEditingController();
  final TextEditingController offhoursworkplace = TextEditingController();
  final placeProvider = StateProvider((ref) => '残業場所を選択してください');

  void applications() async {
    await FirebaseFirestore.instance.collection('時間外申請').doc().set({
      'month':month.text,
      'day':day.text,
      'hour':hour.text,
      'minute':minute.text,
      '_hour':_hour.text,
      '_minute':_minute.text,
      'thepurpose':thepurpose.text,
      'offhourswokplace':offhoursworkplace.text,
      'submissiontime':DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    final place = ref.watch(placeProvider);
    return Scaffold(
      appBar: const appbarmodel(
        title: '時間外申請',
      ),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(child:Container(
        margin: const EdgeInsets.only(top: 30,right: 10,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('時間外申請はなるべく当日の15時までに申請するようにしましょう'),
              ),
            ),
            const SizedBox(height: 10),
            const Text('時間外をする日にち及び時間を入力してください'),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child:Column(
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
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: container(controller: hour, hinttext: '時'),),
                    const Text('時'),
                    Expanded(child: container(controller: minute, hinttext: '分'),),
                    const Text('分'),
                    const Text('〜'),
                    Expanded(child: container(controller: _hour, hinttext: '時'),),
                    const Text('時'),
                    Expanded(child: container(controller: _minute, hinttext: '分'),),
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
                      DropdownMenuItem(value:'残業場所を選択してください',child: Text('残業場所を選択ださい'),),
                      DropdownMenuItem(value:'会社',child: Text('会社'),),
                      DropdownMenuItem(value:'現場',child: Text('現場'),),
                    ],
                    value: place,
                    onChanged: (String? value){
                      ref.read(placeProvider.notifier).state = value!;
                      offhoursworkplace.text = value!;
                      },
                  ),),
                Container(
                  margin: const EdgeInsets.only(top: 15,bottom:15),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorModel.primary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:TextFormField(
                  maxLines: 5,
                  controller: thepurpose,
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
                      onPressed: (){applications();},
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

