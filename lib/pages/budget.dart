import 'package:family_budget/database-helper.dart';
import 'package:family_budget/models/budget-entry.dart';
import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  late int selectedId;

  void initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Записи'),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Center(
              child: FutureBuilder<List<BudgetEntry>>(
                  future: DatabaseHelper.instance.getBudgetEntries(),
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
                        : Column(children: [
                    Expanded(
                    child: SizedBox(
                    height: 200.0,
                        child:
                            ListView(
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
                                                entry.cost.toString() +
                                                '₽',
                                            style: entry.transactionType == 'Получено'
                                                    ? const TextStyle(color: Colors.green)
                                                    : const TextStyle(color: Colors.red)),
                                        subtitle: Text(
                                          entry.userName +
                                              ' ' +
                                              entry.transactionCategory,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          TextButton(
                                            child: const Text('Редактировать'),
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context, '/form', arguments: {
                                                selectedId: entry.id
                                              });
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          TextButton(
                                            child: const Text('Удалить'),
                                            onPressed: () {
                                              setState(() {
                                                DatabaseHelper.instance
                                                    .remove(entry.id!);
                                              });
                                            },
                                            style: TextButton.styleFrom(
                                              primary: Colors.amber,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList()), ),),
                            Text('Итого: ' + costSum.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 18))
                          ]);
                  }))),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/form');
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add_box, color: Colors.white)),
    );
  }
}
