import 'package:flutter/material.dart';
import '../cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';


class AdicionarProdutoEstoque extends StatelessWidget {
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
                  child: CabecalhoWidget(textoTitulo: 'Selecione o produto:'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}