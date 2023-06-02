import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:working_app/pages/employee_pages/task_list.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';
import 'package:working_app/pages/employee_pages/dialyreport_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class TopPage extends HookConsumerWidget {
  TopPage({super.key});

  void addGotoWorkTime() async {
    await FirebaseFirestore.instance.collection('出勤時間').doc().set({
      '出勤時間': DateTime.now(),
    });
  }

  void addFinishWorkTime() async {
    await FirebaseFirestore.instance.collection('退勤時間').doc().set({
      '退勤時間': DateTime.now(),
    });
  }

  double temperature = 0;
  int humidity = 0;
  final NumberFormat num = NumberFormat('#.#');
  final DateFormat date = DateFormat('yyyy年MM月dd日');
  final DateFormat time = DateFormat('HH:mm:ss');

  final weatherProvider = FutureProvider((ref) async {
    var apiKey = '31293b57d5e0e715a4ca700d2b5fb6b4';
    var city = 'Myoko';
    var lang = 'ja';
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&lang=$lang');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var weather = data['weather'][0];
      var main = data['main'];
      var iconName = data['weather'][0]['icon'];
      String getWeatherIconUrl(String iconName) {
        final iconUrl = 'http://openweathermap.org/img/w/$iconName.png';
        return iconUrl;
      }

      return {
        'weatherDescription': weather['description'],
        'temperature': main['temp'],
        'humidity': main['humidity'],
        'icondata': getWeatherIconUrl(iconName),
      };
    } else {
      throw Exception('リクエストが失敗しました。ステータスコード${response.statusCode}');
    }
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weathers = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('トップページ', style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '山田太郎　ログイン日時${date.format(DateTime.now())}${time.format(DateTime.now())}'),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20, bottom: 50),
                child: Column(
                  children: [
                    Text(
                      date.format(DateTime.now()),
                      style: const TextStyle(fontSize: 40),
                    ),
                    ClockWidget(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child:ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFFF4A460)),
                            ),
                            onPressed: () {
                              addGotoWorkTime();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('出勤時間を記録しました'),
                                  backgroundColor: ColorModel.orange,
                                ),
                              );
                            },
                            child: Text('出勤',style: TextStyle(color:ColorModel.primary),),
                          ),),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child:ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFFF4A460)),
                            ),
                            onPressed: () {
                              addFinishWorkTime();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('退勤時間を記録しました'),
                                  backgroundColor: ColorModel.orange,
                                ),
                              );
                            },
                            child: Text('退勤',style: TextStyle(color:ColorModel.primary),),
                          ),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFF4A460)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DialyreportPage()));
                        },
                        child: Text('日報入力ページへ',style: TextStyle(color: ColorModel.primary),),
                      ),
                    ),
                    const SizedBox(height: 35,),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: const Color(0xFFF4A460),),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(children: [
                        Text(
                          '〈　今日の天気　〉',
                          style: Textstyle.titlesize,
                          textAlign: TextAlign.start,
                        ),
                        weathers.when(
                          loading: () => const CircularProgressIndicator(),
                          error: (error, stackTrack) =>
                              const Text('読み取りに失敗しました'),
                          data: (data) => Center(
                            child: Column(
                              children: [
                                Image.network(
                                  data['icondata'],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        ' 温度 : ${num.format(data['temperature'] - 273.15)}℃',
                                        style: Textstyle.titlesize),
                                    Text(
                                        ' 湿度 : ${num.format(data['humidity'])}％',
                                        style: Textstyle.titlesize),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color:const Color(0xFFF4A460)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      height: 100,
                      child: ListTile(
                        title: const Text('本日のタスク'),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text(' 日報を必ず提出', style: Textstyle.titlesize),
                          const Icon(Icons.navigate_next),
                        ]),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TaskList()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final clockProvider = StreamProvider<DateTime>((ref) {
  return Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
    return DateTime.now();
  });
});

class ClockWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clock = ref.watch(clockProvider).value;
    final formatedTime = DateFormat('HH:mm:ss').format(clock ?? DateTime.now());

    return Text(
      formatedTime,
      style: const TextStyle(fontSize: 40),
    );
  }
}
