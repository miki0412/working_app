import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';
import 'package:working_app/pages/offhours_application_page.dart';
import 'package:working_app/pages/paidleave_application_page.dart';

class RequestListsPage extends HookConsumerWidget{
  const RequestListsPage ({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(
          title: '申請一覧'
      ),
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('申請する項目を選んでください',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            const SizedBox(height: 20,),
            sizedbox(
              widthsize: double.infinity,
              heightsize: 50,
              child: ElevatedButton(
                onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OffhoursApplicationPage()));},
                child: Text('時間外申請',style: textstyle),
              ),
            ),
            const SizedBox(height: 20),
            sizedbox(
              widthsize: double.infinity,
              heightsize: 50,
              child: ElevatedButton(onPressed: (){},child: Text('休日出勤申請',style: textstyle),),
            ),
            const SizedBox(height: 20),
            sizedbox(
              widthsize: double.infinity,
              heightsize: 50,
              child: ElevatedButton(onPressed: (){},child: Text('出張申請',style: textstyle),),
            ),
            const SizedBox(height: 20),
            sizedbox(
              widthsize: double.infinity,
              heightsize: 50,
              child: ElevatedButton(
                onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaidleaveApplicationPage()));},
                child: Text('有給休暇申請',style: textstyle),
            ),),
            const SizedBox(height: 20),
            sizedbox(
              widthsize: double.infinity,
              heightsize: 50,
              child: ElevatedButton(onPressed: (){},child: Text('振替休日申請',style: textstyle),),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle textstyle = const TextStyle(fontSize: 20);
