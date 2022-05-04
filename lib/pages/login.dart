import 'package:family_budget/models/budget-entry.dart';
import 'package:flutter/material.dart';

import '../database-helper.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<LoginState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Вход в аккаут'),
          centerTitle: true,
        ),
        body:
        Center(
            child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Center (child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                labelText: 'Пароль *',
                                hintText: 'Какая пароль?',
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
                                  return 'Пожалуйста, введите пароль';
                                }
                                return null;
                              },
                              controller: passwordController,
                            ),),

                          ElevatedButton(
                            onPressed: () async {
                              // if (_formKey.currentState!.validate()) {
                              //   await DatabaseHelper.instance.add(
                              //     BudgetEntry(userName: userNameController.text, cost: double.tryParse(costController.text) ?? 0, transactionType: dropdownValue , transactionCategory: transactionCategoryController.text),
                              //   );
                              //   setState(() {
                              //     userNameController.clear();
                              //     passwordController.clear();
                              //   }
                              //   );
                              // }
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: const Text('Войти'),
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