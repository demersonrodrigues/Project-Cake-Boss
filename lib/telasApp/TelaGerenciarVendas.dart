import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/ItemPedidoDAO.dart';
import '../classesDAO/PedidoDAO.dart';
import '../classesDAO/ProdutoDAO.dart';
import '../classesObjeto/PedidoClasse.dart';
import '../classesObjeto/ProdutoClasse.dart';

class TelaGerenciarVendas extends StatefulWidget {
  @override
  _GerenciarVendasState createState() => _GerenciarVendasState();
}

class _GerenciarVendasState extends State<TelaGerenciarVendas> {
  List<Pedido> pedidos = [];
  List<bool> isExpandedList = [];
  bool ordenarPorMaior = true;

  Future<void> _mostrarDetalhesItens(String docRef) async {
    print(docRef);
    List<Map<String, dynamic>> detalhesItens =
        await ItemPedidoDAO().buscarItensPorIdPedido(docRef);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detalhes dos Itens do Pedido"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: detalhesItens.map((item) {
              return Text(
                  "Produto: ${item['nomeProduto']}, Quantidade: ${item['quantidade']}");
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  // List<Pedido> ordenarPorMaiorQuantidade(List<Pedido> listaProdutos) {
  //   listaProdutos
  //       .sort((a, b) => b.quantidadeEstoque.compareTo(a.quantidadeEstoque));
  //   return listaProdutos;
  // }

  // List<Produto> ordenarPorMenorQuantidade(List<Produto> listaProdutos) {
  //   listaProdutos
  //       .sort((a, b) => a.quantidadeEstoque.compareTo(b.quantidadeEstoque));
  //   return listaProdutos;
  // }

  void carregarPedidos() async {
    List<Pedido> produtosFirebase = await PedidoDAO().listarPedidos();
    setState(() {
      pedidos = produtosFirebase;
      isExpandedList = List.generate(pedidos.length, (index) => false);
    });
  }

  void _deletarPedido(Pedido pedido) {
    String? docRef = pedido.docRef;
    PedidoDAO().deletarPedido(docRef!).then((_) {
      setState(() {
        pedidos.remove(pedido);
      });
    }).catchError((error) {
      print('Erro ao excluir produto: $error');
    });
  }
  

  @override
  void initState() {
    super.initState();
    carregarPedidos();
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
                            // filtroBusca = novoFiltro!;
                            // if (filtroBusca == 'Maior quantidade') {
                            //   produtos = ordenarPorMaiorQuantidade(produtos);
                            //   ordenarPorMaior = true;
                            // } else if (filtroBusca == 'Menor quantidade') {
                            //   produtos = ordenarPorMenorQuantidade(produtos);
                            //   ordenarPorMaior = false;
                            // }
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
                        EdgeInsets.only(left: 20),
                    child: Text(
                      'Data',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 60),
                    child: Text(
                      ' Valor Total',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 30),
                    child: Text(
                      'Deletar',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 30),
                    child: Text(
                      '   Exibir\nDetalhes',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: pedidos.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  Pedido pedido = pedidos[index];
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
                              Text('${pedido.dataPedido}'),
                              Spacer(flex: 2),
                              Text('R\$${pedido.valorTotal.toStringAsFixed(2).replaceAll('.', ',')}'),
                              Spacer(flex: 1),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            'Deseja realmente excluir o pedido selecionado?'),
                                        content: Text(''),
                                        actions: [
                                          TextButton(
                                            child: Text('Sim'),
                                            onPressed: () {
                                              _deletarPedido(pedido);
                                              print(pedido.docRef);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Não'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              SizedBox(width: 30),
                              IconButton(
                                icon: Icon(Icons.info, color: Colors.blue),
                                onPressed: () {
                                  _mostrarDetalhesItens(pedido.docRef!);
                                },
                              ),
                            ],
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
                                    'Cliente: ${pedido.cliente} || Horario: ${pedido.horarioPedido}')
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
