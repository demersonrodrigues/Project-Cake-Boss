import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/generated/CabecalhoWidget.dart';
import 'package:flutterapp/classesDAO/ProdutoDAO.dart';
import 'package:flutterapp/classesObjeto/ProdutoClasse.dart';
import 'package:flutterapp/telasApp/TelaInicial.dart';

class TelaCadastrarProduto extends StatefulWidget {
  @override
  _CadastrarProdutoState createState() => _CadastrarProdutoState();
}

class _CadastrarProdutoState extends State<TelaCadastrarProduto> {

//variaveis de controle das textField
  TextEditingController nomeProdutoController = TextEditingController();
  TextEditingController precoProdutoController = TextEditingController();
  TextEditingController quantidadeProdutoController = TextEditingController();
  TextEditingController pesoProdutoController = TextEditingController();
  TextEditingController categoriaProdutoController = TextEditingController();
  TextEditingController descricaoProdutoController = TextEditingController();

  //variavel da categoria
  String? categoriaSelecionada;

  //lista de categorias, quando for implementado o BD a lista sera importada do banco
  List<DropdownMenuItem<String>> categorias = [
    DropdownMenuItem(
      value: 'Salgado',
      child: Text('Salgado'),
    ),
    DropdownMenuItem(
      value: 'Doce',
      child: Text('Doce'),
    ),
  ];

  @override
  void dispose(){
    super.dispose();
    nomeProdutoController.dispose();
    precoProdutoController.dispose();
    quantidadeProdutoController.dispose();
    pesoProdutoController.dispose();
    categoriaProdutoController.dispose();
    descricaoProdutoController.dispose();
  }

  Widget build(BuildContext context){
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
              controller: nomeProdutoController,
              decoration: InputDecoration(
                labelText: 'Insira o nome do produto',
                hintText: 'Ex: Coxinha; Pastel; Kibe...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              children: [
                Expanded(child: 
                  TextField(
                    controller: precoProdutoController,
                    decoration: InputDecoration(
                    labelText: 'Preço',
                    hintText: 'Ex: 1, 1.50...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter> [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                )
              ),
              SizedBox(width: 16.0),
              Expanded(child: 
                TextField(
                  controller: quantidadeProdutoController,
                  decoration: InputDecoration(
                  labelText: 'Quantidade',
                  hintText: 'Ex: 1; 50; 150...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter> [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
              ),
              ),
              SizedBox(height: 80.0),
              ],             
            ),
            Row(
              children: [
                Expanded(child: 
                  TextField(
                    controller: pesoProdutoController,
                    decoration: InputDecoration(
                    labelText: 'Peso(G)',
                    hintText: 'Ex: 20; 25; 20.5...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: categoriaSelecionada,
                    items: categorias,
                  onChanged: (novaCategoria) {
                    setState(() {
                      categoriaSelecionada = novaCategoria!;
                },
              );
                },
                decoration: InputDecoration(
                  labelText: 'Categorias',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(child: 
                  TextField(
                    controller: descricaoProdutoController,
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    labelText: 'Descrição/Observações',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
              onPressed: () {
                //Cria as variaveis pegando o valor digitado pelo usuario
                String nomeProduto = nomeProdutoController.text;
                double precoProduto = double.parse(precoProdutoController.text);
                int quantidadeProduto = int.parse(quantidadeProdutoController.text);
                double pesoProduto = double.parse(pesoProdutoController.text);
                String descricaoProduto = descricaoProdutoController.text;

                //Cria o objeto produto
                Produto produto = Produto(
                  nome: nomeProduto,
                  peso: pesoProduto,
                  valor: precoProduto,
                  quantidadeEstoque: quantidadeProduto,
                  descricao: descricaoProduto
                );
                
                ProdutoDAO().cadastrarProduto(produto);

                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('Produto Cadastrado com sucesso'),
                    actions: [
                      TextButton(
                        child: Text('ok'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }
                );
                

              //printar informações no console
              print('Nome: ' + produto.nome);
              print('Preço: R\$${produto.valor}');
              print('Quantidade: ${produto.quantidadeEstoque}');
              print('Descrição: ' + produto.descricao);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(252, 255, 114, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                            ),
                            elevation: 10,
                minimumSize: Size(200, 50)
              ),
              child: Text('Cadastrar',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            ),
            Padding(padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaInicialWidget()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(200, 50),
                  ),
              child: Text('Cancelar',
                style: TextStyle(fontSize: 20, color: Colors.red),
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