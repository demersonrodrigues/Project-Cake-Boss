import 'package:flutterapp/classesObjeto/ClienteClasse.dart';

class Pedido{
  int? idPedido;
  String? cliente;
  String? dataPedido;
  String? horarioPedido;
  double valorTotal;
  String? metodoPagamento;

  Pedido({
    this.idPedido,
    this.cliente,
    this.dataPedido,
    this.horarioPedido,
    this.metodoPagamento,
    required this.valorTotal
  });
}