import 'package:CakeBoss/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:CakeBoss/classesDAO/ItemPedidoDAO.dart';
import 'package:CakeBoss/classesObjeto/ItemPedidoClasse.dart';
import 'package:CakeBoss/classesObjeto/PedidoClasse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
import '../classesDAO/PedidoDAO.dart';
=======
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/ItemPedidoDAO.dart';
import 'package:flutterapp/classesDAO/PedidoDAO.dart';
import 'package:flutterapp/classesObjeto/ItemPedidoClasse.dart';
import 'package:flutterapp/classesObjeto/PedidoClasse.dart';
import 'package:flutterapp/telasApp/TelaNotaFiscal.dart';
>>>>>>> 2a915d008379c2920107c37396bc9bcbbfa2e02f
import '../classesObjeto/ProdutoClasse.dart';
import 'TelaNotaFiscal.dart';

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
  late String idPedido;
  late List<int> valores = [];
  late String valorItemFormatado = '';

  @override
  void initState() {
    super.initState();
    quantidades = List.filled(widget.produtosSelecionados.length, 0);
    valores = List.filled(widget.produtosSelecionados.length, 0);
  }

  int calcularTotalQuantidade() {
    return quantidades.fold(0, (sum, quantity) => sum + quantity);
  }

  int calcularValorTotal() {
    return valores.fold(0, (sum, quantity) => sum + quantity);
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
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${produto.nome}\n',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(height: 25)),
                      TextSpan(
                        text:
                            'R\$${produto.valor.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: SizedBox(
                  width: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      int quantidade = int.tryParse(value) ?? 0;
                      setState(() {
                        quantidades[index] = quantidade;
                        double valorItem = produto.valor * quantidade;
                        valores[index] = valorItem.toInt();
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
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total de produtos: ${calcularTotalQuantidade()}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Valor total do pedido: R\$${calcularValorTotal().toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      bool quantidadeInvalida = false;

                      for (int quantidade in quantidades) {
                        if (quantidade <= 0) {
                          quantidadeInvalida = true;
                          break;
                        }
                      }
                      if (quantidadeInvalida) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erro'),
                              content: Text(
                                  'Adicione pelo menos 1 produto em cada campo'),
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
                        double valorTotal = calcularValorTotal().toDouble();

                        DateTime atual = DateTime.now();
                        String dataAtual =
                            '${atual.day}/${atual.month}/${atual.year}';
                        String horarioAtual =
                            '${atual.hour}:${atual.minute}:${atual.second}';

                        Pedido venda = Pedido(

                            dataPedido: dataAtual,
                            horarioPedido: horarioAtual,
                            valorTotal: valorTotal);

                        DocumentReference<Object?>? pedidoID =
                            await PedidoDAO().cadastrarPedido(venda);

                        if (pedidoID != null) {
                          idPedido = pedidoID.id;
                        }
                        List<ItemPedido> itensPedidos = [];
                        print(idPedido);
                        venda.docRef = idPedido;

                        int index = 0;
                        for (Produto produto in widget.produtosSelecionados) {
                          ItemPedido itens = ItemPedido(
                              idPedido: idPedido,
                              pedido: venda,
                              produto: widget.produtosSelecionados[index],
                              quantidade: quantidades[index]);
                          ItemPedidoDAO().cadastrarItens(itens);
                          index++;
                          itensPedidos.add(itens);
                        }
                        print("Itens do Pedido:");
                        for (ItemPedido item in itensPedidos) {
                          print("Produto: ${item.produto.nome}");
                          print("Quantidade: ${item.quantidade}");
                          print("Valor unitario: ${item.produto.valor}");
                          print(
                              "Valor total: R\$${item.produto.valor * item.quantidade}");
                          print("Data: ${item.pedido.dataPedido}");
                          print("Horario: ${item.pedido.horarioPedido}");
                          print("-------------");
                        }
                        print(idPedido);
                        PedidoDAO().adicionarID(idPedido, venda);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaNotaFiscal(
                                  pedido: venda,
                                  idPedido: idPedido,
                                  itensPedidos: itensPedidos)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(150, 50),
                    ),
                    child: Text(
                      'Finalizar Pedido',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
