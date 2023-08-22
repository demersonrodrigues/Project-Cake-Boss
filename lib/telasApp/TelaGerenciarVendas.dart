import 'package:CakeBoss/classesDAO/ItemPedidoDAO.dart';
import 'package:flutter/material.dart';
import '../cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import '../classesDAO/PedidoDAO.dart';
import '../classesObjeto/PedidoClasse.dart';

class TelaGerenciarVendas extends StatefulWidget {
  @override
  _GerenciarVendasState createState() => _GerenciarVendasState();
}

class _GerenciarVendasState extends State<TelaGerenciarVendas> {
  List<Pedido> pedidos = [];
  List<bool> isExpandedList = [];

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
                child: CabecalhoWidget(textoTitulo: 'Historico de Vendas'),
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
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Data',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Valor Total',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Deletar',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '  Exibir\nDetalhes',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
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
                              Text(
                                  'R\$${pedido.valorTotal.toStringAsFixed(2).replaceAll('.', ',')}'),
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
