import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/telasApp/TelaQuantidadeProdutoPedido.dart';
import '../classesDAO/ProdutoDAO.dart';
import '../classesObjeto/ProdutoClasse.dart';

class TelaAddProdutoVenda extends StatefulWidget {
  @override
  _TelaAddProdutoVendaState createState() => _TelaAddProdutoVendaState();
}

class _TelaAddProdutoVendaState extends State<TelaAddProdutoVenda> {
  List<Produto> produtos = [];
  late List<bool> _isSelectedList;
  List<Produto> _produtosSelecionados = [];

  void carregarProdutos() async {
    List<Produto> produtosFirebase = await ProdutoDAO().listarProdutos();
    setState(() {
      produtos = produtosFirebase;
      setState(() {
        produtos = produtosFirebase;
        _isSelectedList = List.generate(produtos.length, (index) => false);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    carregarProdutos();
    if (produtos.isNotEmpty) {
      _isSelectedList = List.generate(produtos.length, (index) => false);
    } else {
      _isSelectedList = [];
    }
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
                child: CabecalhoWidget(textoTitulo: 'Selecionar Produto'),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: produtos.length,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 10.0),
            itemBuilder: (BuildContext context, int index) {
              Produto produto = produtos[index];
              bool isSelected = _isSelectedList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _isSelectedList[index] = !_isSelectedList[index];
                    if (_isSelectedList[index]) {
                      _produtosSelecionados.add(produto);
                    } else {
                      _produtosSelecionados.remove(produto);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color.fromARGB(255, 212, 212, 212)
                        : const Color.fromRGBO(242, 242, 242, 1),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(produto.nome),
                        Spacer(flex: 2),
                        Text('${produto.quantidadeEstoque}'),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                if(_produtosSelecionados.isEmpty){
                  showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erro'),
                              content: Text(
                                  'Adicione pelo menos 1 produto'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                } else {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaQuantidadeProdutosPedido(
                      produtosSelecionados: _produtosSelecionados,
                    ),
                  ),
                );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(100, 50),
              ),
              child: Text(
                'Adicionar produtos ao pedido',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
