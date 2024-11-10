import 'package:agenda_compartilhada/rotas.dart';
import 'package:agenda_compartilhada/widget/user_details.dart';
import 'package:agenda_compartilhada/widget/user_form.dart';
import 'package:agenda_compartilhada/widget/user_list.dart';
import 'package:flutter/material.dart';

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Agenda Compartilhada',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          Rotas.home: (context) => UserList(),
          Rotas.form: (context) => UserForm(),
          Rotas.details: (contexto) => const UserDetails()
        });
  }
}
