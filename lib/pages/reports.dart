import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Отчеты'),
          centerTitle: true,
        ),
        body: Container(
        padding: const EdgeInsets.only(top: 5),
    child:  Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/income-report');
            },
            child: Text('Отчет по прибыли'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/expenses-report');
            },
            child: Text('Отчет по расходам'),
          ),
        ElevatedButton(onPressed: () {
          Navigator.pushNamed(context, '/chart');
        },
          child: const Text('С диаграммой'),),
        ]
      )
    ),
        ),

    );
  }
}
