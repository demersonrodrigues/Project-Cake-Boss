import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/PedidoDAO.dart';
import 'package:flutterapp/classesDAO/ProdutoDAO.dart';
import 'package:flutterapp/classesObjeto/ClienteClasse.dart';
import 'package:flutterapp/classesObjeto/NotaFiscalClasse.dart';
import 'package:flutterapp/telasApp/TelaInicial.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../classesObjeto/PedidoClasse.dart';

class TelaNotaFiscal extends StatefulWidget {
  late final Pedido pedido;
  late final String idPedido;
  TelaNotaFiscal({required this.pedido, required this.idPedido});

  @override
  _NotaFiscalState createState() => _NotaFiscalState();
}

class _NotaFiscalState extends State<TelaNotaFiscal> {
//variaveis de controle das textField
  TextEditingController nomeClienteController = TextEditingController();
  TextEditingController metodoPagamentoController = TextEditingController();

  //variavel da categoria
  String? categoriaSelecionada;

  //lista de categorias, quando for implementado o BD a lista sera importada do banco
  List<DropdownMenuItem<String>> categorias = [
    DropdownMenuItem(
      value: 'Pix',
      child: Text('Pix / Carteira  Digital'),
    ),
    DropdownMenuItem(
      value: 'Dinheiro',
      child: Text('Dinheiro'),
    ),
    DropdownMenuItem(
      value: 'Débito',
      child: Text('Débito'),
    ),
    DropdownMenuItem(
      value: 'Crédito',
      child: Text('Crédito'),
    ),
  ];


  @override
  void dispose() {
    super.dispose();
    nomeClienteController.dispose();

    metodoPagamentoController.dispose();
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
                  child: CabecalhoWidget(textoTitulo: 'Cadastrar  Produto'),
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
                TextField(
                  controller: nomeClienteController,
                  decoration: InputDecoration(
                      labelText: 'Digite o nome do Cliente',
                      hintText: 'Ex: Marcio Santana...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    SizedBox(width: 2.0),
                    Expanded(
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
                          labelText: 'Método de Pagamentos',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 250,
                    height: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        String nome = nomeClienteController.text;
                        
                        widget.pedido.cliente = nome;
                        widget.pedido.metodoPagamento = categoriaSelecionada;

                        PedidoDAO().nomeMetodoPagamento(widget.idPedido, widget.pedido);

                        
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        backgroundColor: Color.fromARGB(255, 255, 255, 248),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Gerar Nota Fiscal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Icon(
                            Icons.note_add_rounded,
                            size: 50,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}