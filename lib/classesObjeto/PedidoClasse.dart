import 'package:flutterapp/classesObjeto/ClienteClasse.dart';

class Pedido{
  int? idPedido;
  Cliente? cliente;
  String? dataPedido;
  String? horarioPedido;
  double valorTotal;
  
  Pedido({
    this.idPedido,
    this.cliente,
    this.dataPedido,
    this.horarioPedido,
    required this.valorTotal
  });
}