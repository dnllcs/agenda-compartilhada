import 'package:agenda_compartilhada/domain/dto/dto_user.dart';
import 'package:agenda_compartilhada/infrastructure/database/dao/dao_user.dart';
import 'package:agenda_compartilhada/rotas.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  late DAOUser dao = new DAOUser();

  Widget criarBotao(BuildContext context, String text, String rota) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, rota), child: Text(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder(
          future: dao.consultar(),
          builder: (context, AsyncSnapshot<List<DTOUser>> snapshot) {
            var dados = snapshot.data;
            if (dados == null) {
              return Text('Dados não encontrados');
            }
            List<DTOUser> lista = dados;
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.person),
                title: Text(lista[index].name),
                subtitle: Text(lista[index].email),
              ),
              itemCount: lista.length,
            );
          }),
    );

    //   return Container(
    //       child: Column(
    //     children: [
    //       criarBotao(context, 'Details', Rotas.details),
    //       criarBotao(context, 'Form', Rotas.form)
    //     ],
    //   ));
    // }
  }
}
