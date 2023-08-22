import 'package:CakeBoss/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutter/material.dart';

class TelaCreditosWidget extends StatelessWidget {
  final membrosEquipe = ['CAIO ÍTALO DE OLIVEIRA SANTOS',
                          'DEMERSON ARAUJO RODRIGUES',
                          'ERICK DANTAS FERREIRA',
                          'GEORGE LUCAS SANCHES BRANDÃO',
                          'LUIZ VITOR SOARES SOUZA'
                          ];
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
                  child: CabecalhoWidget(textoTitulo: 'Creditos'),
                ),
              );
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Este app foi desenvolvido por:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: ListView.builder(
                  itemCount: membrosEquipe.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          membrosEquipe[index],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}