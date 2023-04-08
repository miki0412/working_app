import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';


class SubstituteholidayApplicationPage extends HookConsumerWidget{
  SubstituteholidayApplicationPage({super.key});

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController hour = TextEditingController();
  final TextEditingController minute = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(
        title: '振替休日申請',
      ),
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('振替休日を申請する場合は2日前までに提出してください'),
              ),
            ),
            const SizedBox(height: 10),
            const Text('振替をする日にちを入力してください'),
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
                    ],
                  ),
                  const Text('の出勤に変えて'),
                  Row(
                    children:[
                      Expanded(
                        child: container(
                            controller: month,
                            hinttext: '月'
                        ),
                      ),
                      const Text('月'),
                      Expanded(
                          child: container(
                            controller: day,
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
                        onPressed: (){},
                        child: const Text('申請する',style: TextStyle(fontSize: 15),),
                      )
                  ),
                ],
              ),),
          ],
        ),
      ),
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
        decoration: InputDecoration(
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

