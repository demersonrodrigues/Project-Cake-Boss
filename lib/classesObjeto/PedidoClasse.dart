import 'package:flutterapp/classesObjeto/ClienteClasse.dart';

class Pedido{
  int? idPedido;
  Cliente? cliente;
  DateTime dataPedido;
  double valorTotal;
  
  Pedido({
    this.idPedido,
    this.cliente,
    required this.dataPedido,
    required this.valorTotal
  });
}