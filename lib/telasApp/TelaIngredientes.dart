import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/ProdutoDAO.dart';
import 'package:flutterapp/classesObjeto/ProdutoClasse.dart';
import 'package:flutterapp/classesObjeto/ReceitaClassse.dart';
import 'package:flutterapp/telasApp/TelaInicial.dart';
import 'package:flutterapp/telasApp/TelaPrecificar.dart';

import '../classesObjeto/IngredienteClasse.dart';
import 'TelaPrecoSugerido.dart';

class TelaIngredientes extends StatefulWidget {
  late final Receita receita;
  TelaIngredientes({required this.receita});
  @override
  IngredientesState createState() => IngredientesState();
  
}

class IngredientesState extends State<TelaIngredientes> {
//variaveis de controle das textField
  TextEditingController nomeIngredienteController = TextEditingController();
  TextEditingController custoIngredienteController = TextEditingController();
  TextEditingController volumeIngredienteController = TextEditingController();
  TextEditingController quantidadeUtilizadaController = TextEditingController();
  List<Ingrediente> ingredientes = []; 

  @override
  void dispose() {
    super.dispose();
    nomeIngredienteController.dispose();
    custoIngredienteController.dispose();

    volumeIngredienteController.dispose();
    quantidadeUtilizadaController.dispose();
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
                  child: CabecalhoWidget(textoTitulo: 'Igredientes'),
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
                  controller: nomeIngredienteController,
                  decoration: InputDecoration(
                      labelText: 'Insira o nome do ingrediente',
                      hintText: 'Ex: Farinha de trigo, açúcar, sal...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 6.0),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: custoIngredienteController,
                      decoration: InputDecoration(
                          labelText: 'Valor do Ingrediente (R\$)',
                          hintText: 'Ex: 6.00',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                    )),
                    SizedBox(height: 80.0),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: volumeIngredienteController,
                        decoration: InputDecoration(
                            labelText: 'Volume Comprado (Kg)',
                            hintText: 'Ex: 0.5, 1, 0.6...',
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
                  ],
                ),
                SizedBox(height: 6.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: quantidadeUtilizadaController,
                        decoration: InputDecoration(
                            labelText: 'Quantidade Utilizada (Kg)',
                            hintText: 'Ex: 0.5, 1, 0.6...',
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
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      //Cria as variaveis pegando o valor digitado pelo usuario
                      String nomeIngrediente = nomeIngredienteController.text;
                      double custoIngrediente =
                          double.parse(custoIngredienteController.text);

                      double volumeIngrediente =
                          double.parse(volumeIngredienteController.text);
                      double quantidadeUtilizada =
                          double.parse(quantidadeUtilizadaController.text);


                      Ingrediente ingrediente = Ingrediente();
                      ingrediente.valor = custoIngrediente;
                      ingrediente.peso = volumeIngrediente;
                      ingrediente.nome = nomeIngrediente;
                      ingrediente.quantidade = quantidadeUtilizada;
                      ingrediente.custo = ingrediente.valor! / ingrediente.peso! * ingrediente.quantidade!;
                      ingredientes.add(ingrediente);
                      for(Ingrediente ingrediente in ingredientes){
                        print(ingrediente.nome);
                        print(ingrediente.custo);
                      }

                
                      // limpar as caixas de textos e salvar em uma lista
                      custoIngredienteController.clear();
                      volumeIngredienteController.clear();
                      nomeIngredienteController.clear();
                      quantidadeUtilizadaController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 10,
                        minimumSize: Size(200, 50)),
                    child: Text(
                      'Adicionar outro Ingrediente',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      int index = 0;
                      double custototal = 0;
                      for(Ingrediente ingrediente in ingredientes){
                          custototal += ingredientes[index].custo!;
                          index++;
                      }
                      double precosugerido = custototal * widget.receita.lucro! /100 / widget.receita.rendimento!;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaPrecoSugerido(ingredientes: ingredientes, receita: widget.receita, custototal: custototal, precosugerido: precosugerido)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(200, 50),
                    ),
                    child: Text(
                      'Finzalizar',
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

