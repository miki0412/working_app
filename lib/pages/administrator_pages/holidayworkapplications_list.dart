import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';

class HolidayworkapplicationsList extends HookConsumerWidget{
  HolidayworkapplicationsList({super.key});

  final Stream<QuerySnapshot> _holidayworkapplicationsStream = FirebaseFirestore.instance.collection('休日出勤申請').snapshots();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title:'休日出勤申請書一覧'),
      endDrawer: const AdminstratorCustomDrawer(),
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
                      Map<String, dynamic> holidayworkapplicationData = holidayworkapplicationsData[index].data()! as Map<String,dynamic>;
                      return Expanded(child: ListTile(
                        title: Text('${holidayworkapplicationData['month']}月${holidayworkapplicationData['day']}日'),
                        onTap: (){},
                      ),);
                    },
                    separatorBuilder: (BuildContext context,int index) => const Divider(),
                    itemCount: holidayworkapplicationsData.length,
                );
              }else{
                return Center(child:Text('未承認の申請はありません',style: textstyle.titlesize),);
              }
            },
          ),
        ),
      ),
    );
  }
}