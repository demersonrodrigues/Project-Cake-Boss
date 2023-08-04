import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesObjeto/ItemPedidoClasse.dart';
import 'package:flutterapp/classesObjeto/PedidoClasse.dart';
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
                    onPressed: () {
                      double valorTotal = calcularValorTotal().toDouble();

                      DateTime atual = DateTime.now();
                      String dataAtual = '${atual.day}/${atual.month}/${atual.year}';
                      String horarioAtual = '${atual.hour}:${atual.minute}:${atual.second}';

                      Pedido venda = Pedido(dataPedido:  dataAtual, horarioPedido: horarioAtual, valorTotal: valorTotal);

                      List<ItemPedido> itensPedidos = [];
                      
                      int index = 0;
                      for (Produto produto in widget.produtosSelecionados){
                        ItemPedido itens = ItemPedido(pedido: venda, produto: widget.produtosSelecionados[index], quantidade: quantidades[index]);
                        index++;
                        itensPedidos.add(itens);
                      }
                      print("Itens do Pedido:");
                      for (ItemPedido item in itensPedidos) {
                        print("Produto: ${item.produto.nome}");
                        print("Quantidade: ${item.quantidade}");
                        print("Valor unitario: ${item.produto.valor}");
                        print("Valor total: R\$${item.produto.valor * item.quantidade}");
                        print("Data: ${item.pedido.dataPedido}");
                        print("Horario: ${item.pedido.horarioPedido}");
                        print("-------------");
                      }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: Size(150, 50),
                  ),
                  child: Text('Finalizar Pedido',
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
