import 'package:flutter/material.dart';
import 'package:consumoservicoavancado/TelaGet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:consumoservicoavancado/ObjetoPost.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

String _vAtualizarRetorno = '';
String vUrl = "https://jsonplaceholder.typicode.com/posts";

class _HomeState extends State<Home> {
  _Post() async {

    //exemplo convertendo de objeto para json....
    ObjetoPost post = new ObjetoPost(100, 0, 'Título', 'Incluindo....');
    String CorpoJson = json.encode(post.ObjetoToJson()); //Aqui to passando o Map que crie pelo meu método da classe ObejetoPost;;;;

    http.Response response = await http.post(
      Uri.parse(vUrl),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: CorpoJson,
    );

    if (response.statusCode.toString() == '201') {
      setState(() {
        _vAtualizarRetorno = 'Incluido!       Registro: ${response.body}';
      });
    } else {
      setState(() {
        _vAtualizarRetorno = 'Erro ao Postar';
      });
    }
  }


  //Exemplo Json escrito na mão....
  _Put() async {
    String CorpoJson = json.encode({
      "id": null,
      "title": 'Título',
      "body": 'Atualizando',
      "userId": 1
    });

    http.Response response = await http.put(
      Uri.parse(vUrl + '/1'),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: CorpoJson,
    );

    if (response.statusCode.toString() == '200') {
      setState(() {
        _vAtualizarRetorno = 'Atualizado! Registro: ${response.body}';
      });
    } else {
      setState(() {
        _vAtualizarRetorno = 'Erro ao Atualizar';
      });
    }
  }

  _Patch() async {
    String CorpoJson = json.encode({
      "id": null,
      "title": 'Atualizando somente o title- Patch',
    });

    http.Response response = await http.patch(
      Uri.parse(vUrl + '/1'),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: CorpoJson,
    );

    if (response.statusCode.toString() == '200') {
      setState(() {
        _vAtualizarRetorno = 'Atualizado! Registro: ${response.body}';
      });
    } else {
      setState(() {
        _vAtualizarRetorno = 'Erro ao Atualizar';
      });
    }
  }

  _Delete() async {
    http.Response response = await http.delete(Uri.parse(vUrl + '/2'));

    if (response.statusCode.toString() == '200') {
      setState(() {
        _vAtualizarRetorno = 'Deletado! Registro: ${response.body}';
      });
    } else {
      setState(() {
        _vAtualizarRetorno = 'Erro ao Deletar';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Consumo de serviço 'Avançado' "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TelaGet())),
                        icon: Icon(Icons.get_app),
                        label: Text('Get'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black54))),
                  ),
                  Padding(
                      padding: EdgeInsets.all(1),
                      child: ElevatedButton.icon(
                          onPressed: _Post,
                          icon: Icon(Icons.add_box),
                          label: Text('Post'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black54)))),
                  Padding(
                      padding: EdgeInsets.all(1),
                      child: ElevatedButton.icon(
                          onPressed: _Put,
                          icon: Icon(Icons.update),
                          label: Text('put'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black54)))),
                  Padding(
                      padding: EdgeInsets.all(1),
                      child: ElevatedButton.icon(
                          onPressed: _Patch,
                          icon: Icon(Icons.update),
                          label: Text('Patch'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black54)))),
                  Padding(
                      padding: EdgeInsets.all(1),
                      child: ElevatedButton.icon(
                          onPressed: _Delete,
                          icon: Icon(Icons.delete),
                          label: Text('delete'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black54)))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
              child: Text(
                _vAtualizarRetorno,
                style: TextStyle(color: Colors.blue, fontSize: 32),
              ),
            )
          ],
        ),
      ),
    );
  }
}
