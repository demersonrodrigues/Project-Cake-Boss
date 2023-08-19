import 'package:flutter/material.dart';
import 'package:flutterapp/classesObjeto/IngredienteClasse.dart';
import 'package:flutterapp/classesObjeto/ReceitaClassse.dart';
import '../cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'TelaPrecificar.dart';



class TelaPrecoSugerido extends StatefulWidget {
  late final double custototal;
  late final double precosugerido;
  late final Receita receita;
  late final List<Ingrediente> ingredientes;
  TelaPrecoSugerido({required this.ingredientes, required this.receita, required this.custototal, required this.precosugerido});

  @override
  PrecoSugeridoState createState() => PrecoSugeridoState();
  
}

class PrecoSugeridoState extends State<TelaPrecoSugerido> {

  
  //for(Ingrediente ingrediente in widget.ingredientes){}
  double precosugeridoreceita = 5;
  @override
  
  void dispose() {
    super.dispose();
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
                  child: CabecalhoWidget(textoTitulo: 'Preço Sugerido'),
                ),
              );
            },
          ),
        ),
        body:
        
        SingleChildScrollView(
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
                        'Ingrediente',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Preço',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Quantidade\n  Utilizada',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Custo',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              


              ListView.separated(
                
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.ingredientes.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  Ingrediente ingrediente = widget.ingredientes[index];

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
                              Text('${ingrediente.nome}'),
                              Spacer(flex: 2),
                              Text(
                                  'R\$${ingrediente.valor?.toStringAsFixed(2).replaceAll('.', ',')}'),
                              Spacer(flex: 1),

                              Text(
                                  '${ingrediente.quantidade}'),
                              Spacer(flex: 1),
                              
                              Text(
                                  'R\$${ingrediente.custo}'),
                              Spacer(flex: 1),
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
      bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.receita.nome}:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    
                    'O custo total foi de: R\$${widget.custototal.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  Text(
                    
                    'O preço sugerido é: R\$${widget.precosugerido.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, color: Colors.red),
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
      