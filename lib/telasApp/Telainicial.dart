import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/telasApp/TelaAddProdutoVenda.dart';
import 'package:flutterapp/telasApp/TelaCadastrarProduto.dart';
import 'package:flutterapp/telasApp/TelaEstoqueProduto.dart';
import 'package:flutterapp/telasApp/TelaPrecificar.dart';
import 'package:flutterapp/telasApp/TelaEstatistica.dart';
import 'package:flutterapp/telasApp/TelaGerenciarEstoque.dart';
import 'package:flutterapp/telasApp/TelaGerenciarVendas.dart';


class TelaInicialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(140),
          child: LayoutBuilder(
            builder: (BuildContext context, raints) {
              final double appBarHeight = raints.biggest.height;
              return AppBar(
                flexibleSpace: Container(
                  height: appBarHeight,
                  child: CabecalhoWidget(textoTitulo: 'O que Deseja fazer?'),
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
                      Padding(padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TelaAddProdutoVenda()));
                            // Chama a tela de gerar venda
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor:  const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              ' Gerar \nVenda',
                              style: 
                              TextStyle(fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.receipt_long_sharp,
                                  size: 45,
                                  color: Colors.black,
                              ),  
                            ],
                          )
                        ),
                      ),
                    ),
                      Padding(padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                             Navigator.push(
                            context,
                           MaterialPageRoute(builder: (context) => TelaPrecificar()), 
                          );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor: const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'Precificar \n Produto',
                              style: 
                              TextStyle(fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.monetization_on_outlined,
                                  size: 45,
                                  color: Colors.black,
                              ),  
                            ],
                          ),
                        ),
                      ),
                    ),
                      Padding(padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                           MaterialPageRoute(builder: (context) => TelaGerenciarVendas()), 
                          );
                          },
                          
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor: const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'Gerenciar\n  Vendas',
                              style: 
                              TextStyle(fontSize: 19,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.mode_edit_outline,
                                  size: 40,
                                  color: Colors.black,
                              ),  
                            ],
                          ),
                        ),
                      ),
                    ),
                      Padding(padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TelaEstoqueProduto()),
                          );
                            },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor:  const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'Visualizar\n  Estoque',
                              style: 
                              TextStyle(fontSize: 19,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.inventory_2_outlined,
                                  size: 40,
                                  color: Colors.black,
                              ),  
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                      Padding(padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TelaCadastrarProduto()),
                        );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor:  const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'Cadastrar\n Produto',
                              style: 
                              TextStyle(fontSize: 19,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.note_add_outlined,
                                  size: 40,
                                  color: Colors.black,
                              ),  
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),
                      child: 
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TelaGerenciarEstoqueWidget()),
                              );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor: const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              ' Gerenciar\n  Estoque',
                              style: 
                              TextStyle(fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.add_circle_outline,
                                  size: 40,
                                  color: Colors.black,
                              ),  
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),
                      child: 
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TelaEstatistica()),
                              );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor:  const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'Estatísticas',
                              style: 
                              TextStyle(fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.insert_chart_outlined,
                                  size: 40,
                                  color: Colors.black,
                              ),  
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 140,
                        height: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            // chama a tela de personalizar
                          },
                          
                            style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            backgroundColor:  const Color.fromARGB(255, 254, 165, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                          ),              
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                              'Personalizar',
                              style: 
                              TextStyle(fontSize: 15,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'montserrat',
                              color: Colors.black,
                              ),   
                              ),
                              SizedBox(height: 5),
                              Icon(Icons.person_sharp,
                                  size: 40,
                                  color: Colors.black,
                              ),  
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