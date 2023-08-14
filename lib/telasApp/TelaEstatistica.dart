import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/PedidoDAO.dart';


class TelaEstatistica extends StatefulWidget {
  @override
  _EstatisticaState createState() => _EstatisticaState();
}

class _EstatisticaState extends State<TelaEstatistica> {
  String? categoriaSelecionada;
  double valorTotalVendas = 0;
  int quantItensVendidos = 0;
  int quantVendas = 0;
  String itemMaisVendido = '';

  @override
  void initState() {
    super.initState();
    estatisticas();
  }

  Future<void> estatisticas() async {
    double vTotal = await PedidoDAO.calcularValorTotal();
    int qVendas = await PedidoDAO().contarVendas();
    int itensVendidos = await PedidoDAO().calcularQuantidadeTotalItensVendidos();
    String maisVendido = await PedidoDAO().produtoMaisVendido();
    setState(() {
      valorTotalVendas = vTotal;
      quantVendas = qVendas;
      quantItensVendidos = itensVendidos;
      itemMaisVendido = maisVendido;
    });
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
                        CabecalhoWidget(textoTitulo: 'Estatisticas de Venda'),
                  ),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Quantidade de vendas:', textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('$quantVendas', style: TextStyle  (
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'montserrat',
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Valor Total de Vendas:', textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('R\$ ${valorTotalVendas.toStringAsFixed(2).replaceAll('.', ',')}', style: TextStyle  (
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'montserrat',
                                  color: Color.fromARGB(255, 11, 218, 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Quantidade de itens vendidos:', textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('$quantItensVendidos', style: TextStyle  (
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'montserrat',
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Item mais vendido:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('$itemMaisVendido', style: TextStyle  (
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'montserrat',
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ),
    );
  }
}
