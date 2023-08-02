import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
// import '../classesDAO/ProdutoDAO.dart';
import '../classesObjeto/ProdutoClasse.dart';

class TelaQuantidadeProdutosPedido extends StatefulWidget {
  late final List<Produto> produtosSelecionados;

  TelaQuantidadeProdutosPedido({required this.produtosSelecionados});

  @override
  _TelaQuantidadeProdutosPedidoState createState() => _TelaQuantidadeProdutosPedidoState();
}

class _TelaQuantidadeProdutosPedidoState extends State<TelaQuantidadeProdutosPedido> {
  @override
  Widget build(BuildContext context){
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
                      child: CabecalhoWidget(textoTitulo: 'Definir quantidades do pedido'),
                    ),
                  );
                },
              ),
            ),
            body: ListView.builder(
              itemCount: widget.produtosSelecionados.length,
              itemBuilder: (ontext, int index) {
                Produto produto = widget.produtosSelecionados[index];
                return ListTile(
                  title: Text(produto.nome, style: TextStyle(fontSize: 20)),
                  trailing: SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        int quantidade = int.tryParse(value) ?? 0;
                        setState(() {
                          int quantidadePedido = quantidade;
                          print(quantidade);
                          print(quantidadePedido);
                        }
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                );
              },
            ),
        ),
      );
  }
}