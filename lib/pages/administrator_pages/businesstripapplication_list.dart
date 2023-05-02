import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';

class BusinesstripapplicationList extends HookConsumerWidget{
  BusinesstripapplicationList({super.key});

  final Stream<QuerySnapshot> _businesstripapplicationStream = FirebaseFirestore.instance.collection('出張申請').snapshots();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title:'出張申請一覧'),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: _businesstripapplicationStream,
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<DocumentSnapshot> businesstripsData = snapshot.data!.docs;
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      Map<String,dynamic> businesstripData = businesstripsData[index].data()! as Map<String,dynamic>;
                      return Expanded(child: ListTile(
                        title: Text('${businesstripData['month']}月${businesstripData['day']}日〜${businesstripData['_month']}月${businesstripData['_day']}日'),
                        subtitle: Text('行き先　${businesstripData['tripplace']}'),
                        onTap: (){},
                      ),);
                    },
                    separatorBuilder: (BuildContext context,int index) => const Divider(),
                    itemCount: businesstripsData.length,
                );
              }else{
                return Center(child: Text('未承認の申請はありません',style: textstyle.titlesize),);
              }
            },
          ),
        ),
      ),
    );
  }
}