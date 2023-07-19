import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';



class TelaAdicionarPV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double appBarHeight = constraints.biggest.height;
              return AppBar(
                flexibleSpace: Container(
                  height: appBarHeight,
                  child: CabecalhoWidget(textoTitulo: 'Selecionar Produto'),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              //controller: nomeProdutoController,
              decoration: InputDecoration(
                labelText: 'Insira o nome do produto',
                hintText: 'Ex: Coxinha; Pastel; Kibe...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 241, 169, 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                minimumSize: Size(200, 50)
              ),
              child: Text('Adicionar Produto',
                style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 243, 243, 243)),
              ),
            ),
            ),
          ]
          

          
        ),
          )
          
        )
      )
    );
  }

}