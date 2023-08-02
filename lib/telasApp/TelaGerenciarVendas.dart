import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
// import 'package:flutterapp/telasApp/TelaAddProdutoVenda.dart';
// import 'package:flutterapp/telasApp/TelaCadastrarProduto.dart';
// import 'package:flutterapp/telasApp/TelaEstoqueProduto.dart';


class TelaGerenciarVendaWidget extends StatelessWidget {
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
                  child: CabecalhoWidget(textoTitulo: 'Gerenciar Vendas'),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          
        ),
      ),
    );
  }
}