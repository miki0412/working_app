import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';
import 'package:working_app/style.dart';

class TaskList extends HookConsumerWidget {
  TaskList({super.key});

  void addtask() async {
    await FirebaseFirestore.instance.collection('タスク').doc().set({
      'タスク': taskcontroller.text,
      '期限': datecontroller.text,
      '登録日時': DateTime.now(),
    });
  }

  final Stream<QuerySnapshot> _tasklistStream =
      FirebaseFirestore.instance.collection('タスク').orderBy('期限').snapshots();

  final TextEditingController taskcontroller = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タスク一覧', style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: CustomDrawer(),
      body:  Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[const Text('右へスライドで完了済みタスク\n左へスライドでタスクの削除が行えます。',style: TextStyle(fontSize: 15),),StreamBuilder<QuerySnapshot>(
              stream: _tasklistStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> taskDatas = snapshot.data!.docs;
                  return ListView.separated(
                      shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> taskData =
                          taskDatas[index].data()! as Map<String, dynamic>;
                      return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.horizontal,
                        onDismissed: (direction) async{
                          await FirebaseFirestore.instance.collection('タスク').doc(taskDatas[index].id).delete();
                        },
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.blue,
                            child: const Text('削除'),
                          ),
                          secondaryBackground:Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.orange,
                            child: const Text('完了'),
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${taskData['タスク']}',
                                    style: Textstyle.titlesize),
                                Text('期限　${taskData['期限']}'),
                              ],
                            ),
                          ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: taskDatas.length,
                  );
                } else {
                  return Center(
                    child: Text('登録されたタスクはありません', style: Textstyle.titlesize),
                  );
                }
              }),],),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('タスク登録'),
                  content: SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: taskcontroller,
                          maxLength: 15,
                          decoration:
                              const InputDecoration(hintText: 'タスクを入力してください'),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          controller: datecontroller,
                          decoration:
                              const InputDecoration(hintText: '期限 年／月／日'),
                          inputFormatters: [DateInputFormatter()],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        addtask();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('タスクが1件登録されました'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      },
                      child: const Text('タスクを追加'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
