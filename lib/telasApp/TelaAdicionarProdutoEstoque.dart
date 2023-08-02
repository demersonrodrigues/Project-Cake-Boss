import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/telasApp/TelaAdicionarPV.dart';
import 'package:flutterapp/telasApp/TelaCadastrarProduto.dart';
import 'package:flutterapp/telasApp/TelaEstoqueProduto.dart';

import '../classesDAO/ProdutoDAO.dart';
import '../classesObjeto/ProdutoClasse.dart';

class TelaAdicionarProdutoEstoqueWidget extends StatefulWidget {
  @override
  _TelaAdicionarProdutoEstoqueState createState() =>
      _TelaAdicionarProdutoEstoqueState();
}

class _TelaAdicionarProdutoEstoqueState
    extends State<TelaAdicionarProdutoEstoqueWidget> {
  List<Produto> produtos = [];
  late int novaQuantidade;

  void carregarProdutos() async {
    List<Produto> produtosFirebase = await ProdutoDAO().listarProdutos();
    setState(() {
      produtos = produtosFirebase;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

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
                  child:
                      CabecalhoWidget(textoTitulo: 'Adicionar Produto Estoque'),
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
              SizedBox(height: 16.0),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      'Item',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 70.0),
                    child: Text(
                      'Qtd.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: produtos.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  Produto produto = produtos[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(),
                    ),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(produto.nome),
                          Spacer(flex: 1),
                          Text('${produto.quantidadeEstoque}'),
                          Spacer(flex: 1),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Digite a nova quantidade'),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    novaQuantidade = int.tryParse(value)!;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ProdutoDAO().adicionarAoEstoque(produto.nome, novaQuantidade);
                                      print(novaQuantidade);
                                      print(produto.quantidadeEstoque);
                                    },
                                    child: Text('Confirmar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: Text(
                    'Toque no icone (+) para adicionar uma nova quantidade de itens no estoque',
                    style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
