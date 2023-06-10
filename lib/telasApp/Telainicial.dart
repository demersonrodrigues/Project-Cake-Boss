import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/telasApp/TelaCadastrarProduto.dart';


class TelainicialWidget extends StatelessWidget {
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
                  child: CabecalhoWidget(textoTitulo: 'Oque Deseja fazer?'),
                ),
              );
            },
          ),
        ),
        body: Center(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                // Chama a tela de gerar venda
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text(
                'Gerar Venda',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                // chama a tela de precificar produto
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text('Precificar \nProduto'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                // chama a tela de gerenciar vendas
              },
              
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text('Gerenciar Vendas'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                // chama a tela de visualizar estoque
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text('Visualizar Estoque'),
            ),
          ),
        ],
      ),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaCadastrarProduto()),
            );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text('Cadastrar Produto'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                // chama a tela de add produto ao estoque
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text('Adicionar\nProduto ao\nEstoque'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                // chama a tela de estatistica
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text('Estatisticas'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: ElevatedButton(
              onPressed: () {
                // chama a tela de personalizar
              },
              
                style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.orange,
              ),              child: Text('Personalizar'),
            ),
          ),
        ],
      ),
    ],
  ),
),
      ),
    );
  }
}