class Pedido{
  int? idPedido;
  String? docRef;
  String? cliente;
  String? dataPedido;
  String? horarioPedido;
  double valorTotal;
  String? metodoPagamento;

  Pedido({
    this.docRef,
    this.idPedido,
    this.cliente,
    this.dataPedido,
    this.horarioPedido,
    this.metodoPagamento,
    required this.valorTotal
  });
}