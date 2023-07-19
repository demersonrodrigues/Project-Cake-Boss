import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/ProdutoDAO.dart';
import '../classesObjeto/ProdutoClasse.dart';

class TelaEstoqueProduto extends StatefulWidget {

  @override
  _EstoqueProdutoState createState() => _EstoqueProdutoState();
}

class _EstoqueProdutoState extends State<TelaEstoqueProduto>{

  List<Produto> produtos = [];

  void carregarProdutos() async {
    List<Produto> produtosFirebase = await ProdutoDAO().listarProdutosDoFirestore();
    setState(() {
      produtos = produtosFirebase;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Widget build(BuildContext context){

    List<DropdownMenuItem<String>> filtros = [
      DropdownMenuItem(
        value: 'Maior quantidade',
        child: Text('Maior quantidade'),
      ),
      DropdownMenuItem(
        value: 'Menor quantidade',
        child: Text('Menor quantidade'),
      ),
      DropdownMenuItem(
        value: 'Recentes',
        child: Text('Recentes'),
      ),
    ];

    var filtroBusca;

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
                  child: CabecalhoWidget(textoTitulo: 'Estoque de Produtos'),
                ),
              );
            },
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextField(
                      style: TextStyle(fontSize: 12.0, height: 2.0),
                      onChanged: (value) {
                        // Realize a busca com base no valor digitado
                      },
                      decoration: InputDecoration(
                        labelText: 'Procurar Produto',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: filtroBusca,
                      items: filtros,
                      onChanged: (novoFiltro) {
                        setState(() {
                          filtroBusca = novoFiltro!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Ordenar',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: produtos.length,
              itemBuilder: (BuildContext context, int index) {
                Produto produto = produtos[index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Preço: R\$ ${produto.valor.toStringAsFixed(2)}'),
                      Text('Quantidade: ${produto.quantidadeEstoque}'),
                      Text('Peso: ${produto.peso}'),
                    ],
                  ),
                );
              },
            ),
          ],
      ),
    ),
  ),
      )
    );
  }
}