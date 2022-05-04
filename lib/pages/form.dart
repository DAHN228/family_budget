import 'package:family_budget/models/budget-entry.dart';
import 'package:flutter/material.dart';

import '../database-helper.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({Key? key}) : super(key: key);


  @override
  EntryFormState createState() {
    return EntryFormState();
  }
}

class EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final costController = TextEditingController();
  final transactionCategoryController = TextEditingController();

  String dropdownValue = 'Потрачено';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Новая запись'),
        centerTitle: true,
      ),
      body:
          Center(
            child: Column(
              children: [
                DropdownButton<String>(
                  hint: const Text('Выберите тип транзакции'),
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black45, fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: Colors.amber,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Потрачено', 'Получено']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Form(
                key: _formKey,
                child: Center (child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child:
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Сумма *',
                          hintText: 'Сколько получили или потратили?',
                          prefixIcon: Icon(Icons.attach_money),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.amber, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите сумму транзакции';
                          }
                          return null;
                        },
                        controller: costController,
                      ),),
                    Padding(padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child:
                      TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Имя пользователя *',
                          hintText: 'Как вас зовут?',
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.amber, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите имя пользователя';
                          }
                          return null;
                        },
                        controller: userNameController,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child:
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Категория *',
                          hintText: 'Какая категория транзакции?',
                          prefixIcon: Icon(Icons.add_shopping_cart),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.amber, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите категорию транзакции';
                          }
                          return null;
                        },
                        controller: transactionCategoryController,
                      ),),

                    ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // routeArgs.selectedId != null
                          //     ? await DatabaseHelper.instance.update(
                          //   BudgetEntry(id: routeArgs.selectedId, userName: userNameController.text, cost: double.tryParse(costController.text) ?? 0, transactionType: dropdownValue , transactionCategory: transactionCategoryController.text )
                          // )
                          //   :
                          await DatabaseHelper.instance.add(
                              BudgetEntry(userName: userNameController.text, cost: double.tryParse(costController.text) ?? 0, transactionType: dropdownValue , transactionCategory: transactionCategoryController.text),
                            );
                            setState(() {
                              userNameController.clear();
                              transactionCategoryController.clear();
                              costController.clear();
                            }
                          );
                        }
                        Navigator.pushReplacementNamed(context, '/budget');
                      },
                      child: const Text('Подтвердить'),
                    ),
                  ],
                ),
                )
            ),
            ])
              
            
          )
    // Build a Form widget using the _formKey created above.
    );
  }
}