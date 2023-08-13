import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/PedidoDAO.dart';


class TelaEstatistica extends StatefulWidget {
  @override
  _EstatisticaState createState() => _EstatisticaState();
}

class _EstatisticaState extends State<TelaEstatistica> {
  String? categoriaSelecionada;
  double valorTotal = 0;

  @override
  void initState() {
    super.initState();
    _carregarValorTotal();
  }

  Future<void> _carregarValorTotal() async {
    double total = await PedidoDAO.calcularValorTotal();

    setState(() {
      valorTotal = total;
    });
  }

  List<DropdownMenuItem<String>> categorias = [
    DropdownMenuItem(
      value: 'Hoje',
      child: Text('Hoje'),
    ),
    DropdownMenuItem(
      value: 'Esta Semana',
      child: Text('Esta Semana'),
    ),
    DropdownMenuItem(
      value: 'Este Mês',
      child: Text('Este Mês'),
    ),
    DropdownMenuItem(
      value: 'Período Total',
      child: Text('Período Total'),
    ),
  ];
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
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0, // Altura desejada para a borda
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' Valor da Venda',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0, // Altura desejada para a borda
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Valor Total de Vendas: R\$ $valorTotal',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
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
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0, // Altura desejada para a borda
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' Quant. de Vendas',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 160,
                          height: 140,
                          child: Container(
                            height: 100.0,
                            width: 150.0, // Altura desejada para a borda
                            decoration: BoxDecoration(
                                color: Color.fromARGB(200, 255, 218, 52),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' Produto +Vendido',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
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
          bottomNavigationBar: BottomAppBar(
              child: Container(
            height: 70,
            child: DropdownButtonFormField<String>(
              value: categoriaSelecionada,
              items: categorias,
              onChanged: (novaCategoria) {
                setState(
                  () {
                    categoriaSelecionada = novaCategoria!;
                  },
                );
              },
              decoration: InputDecoration(
                labelText: 'Selecione o período que deseja',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ))),
    );
  }
}
