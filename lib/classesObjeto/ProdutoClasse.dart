import 'package:flutterapp/classesObjeto/CategoriaClasse.dart';

class Produto{
  int? idProduto;
  Categoria? categoria;
  String nome;
  double valor;
  double peso;
  int quantidadeEstoque;
  String descricao;


  Produto({
    this.idProduto,
    this.categoria,
    required this.nome,
    required this.valor,
    required this.peso,
    required this.quantidadeEstoque,
    required this.descricao
  });
}