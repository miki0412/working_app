import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';
import 'package:working_app/pages/administrator_pages/holidaywork_application_approval.dart';

class HolidayworkapplicationsList extends HookConsumerWidget{
  HolidayworkapplicationsList({super.key});

  final Stream<QuerySnapshot> _holidayworkapplicationsStream = FirebaseFirestore.instance.collection('休日出勤申請').snapshots();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('休日出勤申請書一覧',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _holidayworkapplicationsStream,
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<DocumentSnapshot> holidayworkapplicationsData = snapshot.data!.docs;
                return ListView.separated(
                    shrinkWrap:true,
                    itemBuilder: (BuildContext context,int index){
                      final holidayworkapplicationData = holidayworkapplicationsData[index];
                      //Map<String, dynamic> holidayworkapplicationData = holidayworkapplicationsData[index].data()! as Map<String,dynamic>;
                      return Expanded(child: ListTile(
                        title: Text('${holidayworkapplicationData.get('month')}月${holidayworkapplicationData.get('day')}日'),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HolidayworkApplicationApproval(holidayworkapplicationData)));
                        },
                      ),);
                    },
                    separatorBuilder: (BuildContext context,int index) => const Divider(),
                    itemCount: holidayworkapplicationsData.length,
                );
              }else{
                return Center(child:Text('未承認の申請はありません',style: Textstyle.titlesize),);
              }
            },
          ),
        ),
      ),
    );
  }
}