import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/ProdutoDAO.dart';
import '../classesObjeto/ProdutoClasse.dart';

class TelaEstoqueProduto extends StatefulWidget {
  @override
  _EstoqueProdutoState createState() => _EstoqueProdutoState();
}

class _EstoqueProdutoState extends State<TelaEstoqueProduto> {
  List<Produto> produtos = [];
  List<bool> isExpandedList = [];
  bool ordenarPorMaior = true;

  List<Produto> ordenarPorMaiorQuantidade(List<Produto> listaProdutos) {
    listaProdutos
        .sort((a, b) => b.quantidadeEstoque.compareTo(a.quantidadeEstoque));
    return listaProdutos;
  }

  List<Produto> ordenarPorMenorQuantidade(List<Produto> listaProdutos) {
    listaProdutos
        .sort((a, b) => a.quantidadeEstoque.compareTo(b.quantidadeEstoque));
    return listaProdutos;
  }

  void carregarProdutos() async {
    List<Produto> produtosFirebase = await ProdutoDAO().listarProdutos();
    setState(() {
      produtos = produtosFirebase;
      isExpandedList = List.generate(produtos.length, (index) => false);
    });
  }

  void _deletarProduto(Produto produto) {
    String nomeProduto = produto.nome;
    ProdutoDAO().deletarProduto(nomeProduto).then((_) {
      setState(() {
        produtos.remove(produto);
      });
    }).catchError((error) {
      print('Erro ao excluir produto: $error');
    });
  }


  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> filtros = [
      DropdownMenuItem(
        value: 'Maior quantidade',
        child: Text('Maior quantidade'),
      ),
      DropdownMenuItem(
        value: 'Menor quantidade',
        child: Text('Menor quantidade'),
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
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                            if (filtroBusca == 'Maior quantidade') {
                              produtos = ordenarPorMaiorQuantidade(produtos);
                              ordenarPorMaior = true;
                            } else if (filtroBusca == 'Menor quantidade') {
                              produtos = ordenarPorMenorQuantidade(produtos);
                              ordenarPorMaior = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Ordenar por:',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                    child: Text(
                      'Quantidade',
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
                  bool isExpanded = isExpandedList[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(produto.nome),
                              Spacer(flex: 2),
                              Text('${produto.quantidadeEstoque}'),
                              Spacer(flex: 1),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Deseja realmente excluir o item selecionado?'),
                                    content: Text(''),
                                    actions: [
                                      TextButton(
                                        child: Text('Sim'),
                                        onPressed: () {
                                          _deletarProduto(produto);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Não'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          onTap: () {
                            setState(() {
                              isExpandedList[index] = !isExpanded;
                            });
                          },
                        ),
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                    'Preço: R\$ ${produto.valor} || Peso: ${produto.peso}g || Descrição: ${produto.descricao}')
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
