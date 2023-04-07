import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';

final monthprovider = StateProvider((ref) => '月');
final dayProvider = StateProvider((ref) => '日');

class PaidleaveApplicationPage extends HookConsumerWidget {
  PaidleaveApplicationPage({super.key});

  final lists = <String>[
    '月',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _month = ref.watch(monthprovider);
    final _day = ref.watch(dayProvider);
    return Scaffold(
      appBar: const appbarmodel(title:'有給休暇申請'),
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            const Text('有給取得日'),
            Row(
              children: [
                DropdownButton<String>(
                    value: _month,
                    items: lists
                        .map((String list) =>
                            DropdownMenuItem(value: list, child: Text(list)))
                        .toList(),
                    onChanged: (String? value) {
                      ref.read(monthprovider.notifier).state = value!;
                    }),
                const Text('月'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
