import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';

class SubstituteapplicationList extends HookConsumerWidget{
  SubstituteapplicationList({super.key});

  final Stream<QuerySnapshot> _substituteholidayapplicationsStream = FirebaseFirestore.instance.collection('振替休日申請').snapshots();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title:'振替休日申請書一覧'),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: _substituteholidayapplicationsStream,
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<DocumentSnapshot> substitutesData = snapshot.data!.docs;
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      Map<String,dynamic> substituteData = substitutesData[index].data()! as Map<String,dynamic>;
                      return Expanded(
                          child: ListTile(
                            title: Text('${substituteData['month']}月${substituteData['day']}日 → ${substituteData['_month']}月${substituteData['_day']}日'),
                            onTap: (){},
                          )
                      );
                    },
                    separatorBuilder: (BuildContext context,int index) => const Divider(),
                    itemCount: substitutesData.length,
                );
              }else{
                return Center(
                  child:Text('未承認の申請はありません',style: textstyle.titlesize),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}