import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:consumoservicoavancado/ObjetoPost.dart';

class TelaGet extends StatefulWidget {
  const TelaGet({Key? key}) : super(key: key);

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  //metodos

  String vUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<ObjetoPost?>?> _GetDadosWebService() async {
    http.Response vResponse = await http.get(Uri.parse(vUrl));

    if (vResponse.statusCode.toString() == "200") {
      var ObejetoJson = json.decode(vResponse.body.toString());

      List<ObjetoPost> MinhaListaObjetosPost = []; //// Crio a minha lista de objetos vazia

      //Como meu retorno Json por padrão vem como MAP preciso percorrer para atribuir ao meu objeto...
      for (var i in ObejetoJson) {
        ObjetoPost vObejetoPost =  ObjetoPost(i["userId"], i["id"], i["title"], i["body"]);

        MinhaListaObjetosPost.add(vObejetoPost);
      }

      return MinhaListaObjetosPost;
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get"),
        ),
        body: FutureBuilder<List<ObjetoPost?>?>(
            future: _GetDadosWebService(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return throw("Erro");
                  } else {
                    //dados da lista

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        List<ObjetoPost?>? vlista = snapshot.data;

                        return ListTile(
                          title: Text(vlista![i]!.id.toString()),
                          subtitle: Text(vlista![i]!.title),
                        );
                      },
                    );
                  }
              }
            }));
  }
}
