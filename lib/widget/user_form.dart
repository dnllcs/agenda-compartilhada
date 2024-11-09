import 'package:agenda_compartilhada/domain/dto/dto_user.dart';
import 'package:agenda_compartilhada/infrastructure/database/dao/dao_user.dart';
import 'package:agenda_compartilhada/rotas.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  late DAOUser daoUser = DAOUser();

  late String _name = "";
  late String _email = "";
  late String _password = "";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      daoUser.salvar(DTOUser(name: _name, email: _email, password: _password));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully')));
      Navigator.pushNamed(context, Rotas.details);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill out the fields correctly')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Form Example')),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name.';
                    } else if (value.length <= 2) {
                      return 'Please enter a valid name.';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
