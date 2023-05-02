import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';
import 'package:working_app/pages/administrator_pages/offhours_application_approval.dart';

class OffhoursapplicationList extends HookConsumerWidget{
  OffhoursapplicationList({super.key});

  final Stream<QuerySnapshot> _offhoursStream = FirebaseFirestore.instance.collection('時間外申請').snapshots();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title:'時間外申請書一覧'),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          //margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: StreamBuilder<QuerySnapshot> (
            stream: _offhoursStream,
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<DocumentSnapshot> offhoursData = snapshot.data!.docs;
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext contex,int index){
                      Map<String,dynamic> offhourData = offhoursData[index].data()! as Map<String,dynamic>;
                      return Expanded(child: ListTile(
                        title: Text('${offhourData['month']}月${offhourData['day']}日'),
                        subtitle: Text('${offhourData['hour']}:${offhourData['minute']}〜${offhourData['_hour']}:${offhourData['_minute']}'),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OffhoursApplicationApproval()));
                        },
                      ),);
                    },
                    separatorBuilder: (BuildContext context,int index) => const Divider(),
                    itemCount: offhoursData.length,
                );
              }else{
                return Text('未承認の申請はありません',style: textstyle.titlesize);
              }
            },
          ),
        ),
      ),
    );
  }
}