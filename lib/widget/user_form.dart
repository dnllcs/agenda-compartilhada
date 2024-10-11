import 'package:agenda_compartilhada/domain/dto/dto_user.dart';
import 'package:agenda_compartilhada/infrastructure/database/dao/dao_user.dart';
import 'package:agenda_compartilhada/rotas.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<UserForm> {
  late DAOUser daoUser = new DAOUser();
  String _name = '';
  String _email = '';
  String _password = '';

  void _submitForm(BuildContext context) {
    daoUser.salvar(DTOUser(name: _name, email: _email, password: _password));
    Navigator.pushNamed(context, Rotas.details);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Example'),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email.';
                  }

                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm;
                  Navigator.pushNamed(context, Rotas.home);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
