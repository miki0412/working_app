import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';

class PaidleaveapplicationList extends HookConsumerWidget{
  PaidleaveapplicationList({super.key});

  final Stream<QuerySnapshot> _paidleaveStream = FirebaseFirestore.instance.collection('有給休暇申請').snapshots();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('有給休暇申請書一覧',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: _paidleaveStream,
            builder: (context,snapshot){
              if(snapshot.hasData) {
                List<DocumentSnapshot> paidleavesData = snapshot.data!.docs;
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index) {
                      Map<String,dynamic> paidleaveData = paidleavesData[index].data()! as Map<String,dynamic>;
                      return Expanded(child: ListTile(
                        title: Text('${paidleaveData['month']}月${paidleaveData['day']}日〜${paidleaveData['_month']}月${paidleaveData['_day']}日'),
                        onTap: (){},
                      ),);
                    },
                    separatorBuilder: (BuildContext context,int index) => const Divider(),
                    itemCount: paidleavesData.length,
                );
              }else{
                return Center(child: Text('未承認のデータはありません',style: Textstyle.titlesize),);
              }
            },
          ),
        ),
      ),
    );
  }
}