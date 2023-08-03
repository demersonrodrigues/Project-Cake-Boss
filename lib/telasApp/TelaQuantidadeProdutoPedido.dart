import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
// import '../classesDAO/ProdutoDAO.dart';
import '../classesObjeto/ProdutoClasse.dart';

class TelaQuantidadeProdutosPedido extends StatefulWidget {
  late final List<Produto> produtosSelecionados;

  TelaQuantidadeProdutosPedido({required this.produtosSelecionados});

  @override
  _TelaQuantidadeProdutosPedidoState createState() =>
      _TelaQuantidadeProdutosPedidoState();
}

class _TelaQuantidadeProdutosPedidoState
    extends State<TelaQuantidadeProdutosPedido> {
  late List<int> quantidades;

  @override
  void initState() {
    super.initState();
    quantidades = List.filled(widget.produtosSelecionados.length, 0);
  }

  int calcularTotalQuantidade() {
    return quantidades.fold(0, (sum, quantity) => sum + quantity);
  }

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
                  child: CabecalhoWidget(textoTitulo: 'Quantidades dos Itens'),
                ),
              );
            },
          ),
        ),
        body: ListView.builder(
          itemCount: widget.produtosSelecionados.length,
          itemBuilder: (context, int index) {
            Produto produto = widget.produtosSelecionados[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('Quantidade de ' + produto.nome,
                    style: TextStyle(fontSize: 20)),
                trailing: SizedBox(
                  width: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      int quantidade = int.tryParse(value) ?? 0;
                      setState(() {
                        quantidades[index] = quantidade;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            child: Center(
              child: Text(
                'Total de produtos: ${calcularTotalQuantidade()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
