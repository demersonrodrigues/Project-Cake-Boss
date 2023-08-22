import 'PedidoClasse.dart';
import 'ProdutoClasse.dart';

class ItemPedido{
  int? idItemPedido;
  Pedido pedido;
  String idPedido;
  Produto produto;
  int quantidade;

  ItemPedido({
    this.idItemPedido,
    required this.pedido,
    required this.idPedido,
    required this.produto,
    required this.quantidade
  });
}