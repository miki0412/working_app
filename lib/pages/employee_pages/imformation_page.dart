import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';
import 'package:working_app/style.dart';

class InformationPage extends HookConsumerWidget{
  InformationPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('お知らせ',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.brown,width:5),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context,index) {
                return ListTile(
                  title: Text(lists[index].titles),
                  subtitle: Text(lists[index].info),
                  onTap: (){},
                );
              },
              separatorBuilder: (BuildContext context,int index) => Container(height: 0.5,color: Colors.black,),
              itemCount: lists.length,
          ),
        ),
      ),
    );
  }
}

class Listtile {
  const Listtile({
    required this.titles,
    required this.info,
  });
  final String titles;
  final String info;
}

const List<Listtile>  lists =[
  Listtile(
      titles: '〇〇イベントのお知らせ',
      info: '5月31日にA会場で〇〇イベントが開催されます。\nお気軽にご参加ください。',
  ),
  Listtile(
    titles: '事務所修繕のお知らせ',
    info: '6月1日から6月10日まで事務所の修繕を行います。\nご迷惑をおかけしますがよろしくお願いいたします',
  ),
  Listtile(
    titles: '社員入社のお知らせ',
    info: '6月1日より土木部へ１名社員が入社します。\nよろしくお願いいたします',
  ),
  Listtile(
      titles: '社内研修のお知らせ',
      info: '6月15日に社員研修を実施します。\n特別な事情がない限りは全員参加となりますのでよろしくお願いいたします。'
  ),
];


