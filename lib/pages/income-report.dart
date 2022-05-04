import 'package:flutter/material.dart';

import '../database-helper.dart';
import '../models/budget-entry.dart';

class IncomeReport extends StatefulWidget {
  const IncomeReport({Key? key}) : super(key: key);



  @override
  State<IncomeReport> createState() => _IncomeReportState();
}

void initDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class _IncomeReportState extends State<IncomeReport> {

  @override
  Widget build(BuildContext context) {
    initDatabase();
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Отчеты'),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.only(top: 5),
            child: Center(
              child: Column(children: [
              FutureBuilder<List<BudgetEntry>>(
              future: DatabaseHelper.instance.getIncomeEntries(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<BudgetEntry>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: Text('Загрузка...',
                            style: TextStyle(color: Colors.white)));
                  }
                  double costSum = 0;
                  snapshot.data?.forEach((entry) {
                    entry.transactionType == 'Получено'
                        ? costSum += entry.cost
                        : costSum -= entry.cost;
                  });
                  return snapshot.data!.isEmpty
                      ? const Center(
                      child: Text('В списке нет записей',
                          style: TextStyle(color: Colors.white)))
                      :  Expanded(
                      child: Column(children: [
                        Expanded(
                          child: SizedBox(
                            height: 200.0,
                            child: ListView(
                                shrinkWrap: true,
                                children: snapshot.data!.map((entry) {
                                  return Center(
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: Text(
                                                entry.transactionType +
                                                    ' ' +
                                                    entry.cost
                                                        .toString() +
                                                    '₽',
                                                style:
                                                entry.transactionType ==
                                                    'Получено'
                                                    ? const TextStyle(
                                                    color: Colors
                                                        .green)
                                                    : const TextStyle(
                                                    color: Colors
                                                        .red)),
                                            subtitle: Text(
                                              entry.userName +
                                                  ' ' +
                                                  entry
                                                      .transactionCategory,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                        Text('Итого: ' + costSum.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18))
                      ]));
                }),
              ]),
            )));
  }
}
