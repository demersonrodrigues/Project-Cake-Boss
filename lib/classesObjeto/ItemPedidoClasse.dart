import 'package:flutterapp/classesObjeto/PedidoClasse.dart';

import 'ProdutoClasse.dart';

class ItemPedido{
  int? idItemPedido;
  Pedido pedido;
  Produto produto;
  int quantidade;

  ItemPedido({
    this.idItemPedido,
    required this.pedido,
    required this.produto,
    required this.quantidade
  });
}