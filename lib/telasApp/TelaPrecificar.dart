import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/ProdutoDAO.dart';
import 'package:flutterapp/classesObjeto/ProdutoClasse.dart';
import 'package:flutterapp/telasApp/TelaCadastrarProduto.dart';
import 'package:flutterapp/telasApp/TelaIngredientes.dart';
import 'package:flutterapp/telasApp/TelaAddProdutoVenda.dart';
import 'package:flutterapp/telasApp/TelaEstoqueProduto.dart';
import 'TelaQuantidadeProdutoPedido.dart';

class TelaPrecificar extends StatefulWidget {
  @override
  _PrecificarState createState() => _PrecificarState();
}

class _PrecificarState extends State<TelaPrecificar> {
//variaveis de controle das textField
  TextEditingController nomeReceitaController = TextEditingController();
  TextEditingController rendimentoController = TextEditingController();
  TextEditingController lucroController = TextEditingController();
  TextEditingController listaMateriaisController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nomeReceitaController.dispose();
    rendimentoController.dispose();
    lucroController.dispose();

    listaMateriaisController.dispose();
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
                  child: CabecalhoWidget(textoTitulo: 'Precificar'),
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
                  controller: nomeReceitaController,
                  decoration: InputDecoration(
                      labelText: 'Insira o nome da receita',
                      hintText: 'Ex: Coxinha; Pastel; Kibe...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 6.0),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: rendimentoController,
                      decoration: InputDecoration(
                          labelText: 'Rendimento',
                          hintText: 'Ex: 2 unidades',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                    )),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextField(
                        controller: lucroController,
                        decoration: InputDecoration(
                            labelText: 'Lucro (%)',
                            hintText: 'Ex: 50%; 100%...',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                      ),
                    ),
                    SizedBox(height: 80.0),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: listaMateriaisController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 10),
                          labelText: 'Lista de Materiais',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaIngredientes()));
                      //Cria as variaveis pegando o valor digitado pelo usuario
                      String nomeProduto = nomeReceitaController.text;
                      double precoProduto =
                          double.parse(rendimentoController.text);
                      int quantidadeProduto = int.parse(lucroController.text);
                      String descricaoProduto = listaMateriaisController.text;

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 92, 204, 72),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        minimumSize: Size(200, 50)),
                    child: Text(
                      'Próximo',
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
