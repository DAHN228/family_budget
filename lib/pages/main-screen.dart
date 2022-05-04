import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Бюжет семьи'),
          centerTitle: true,
        ),
        body: Column(children: [
          const Padding(
            padding:  EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Text(
                'Данное приложение позволяет вносить доходы и расходы семьи, а также выводить отчеты бюджета',
                style: TextStyle(color: Colors.white)),
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/budget');
                  },
                  child: const Text('К бюджету')),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(75, 20, 0, 20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reports');
                  },
                  child: const Text('Отчеты')),
            ),

          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Авторизация')),
          )
        ]));
  }
}
