import 'package:flutterapp/classesObjeto/ItemPedidoClasse.dart';
import 'package:flutterapp/classesObjeto/PedidoClasse.dart';

class NotaFiscal{
  int? idNotaFiscal;
  Pedido pedido;
  ItemPedido itens;

  NotaFiscal({
    this.idNotaFiscal,
    required this.pedido,
    required this.itens
  });

  void imprimirNotaFiscal(){
    print('Nota fiscal Nº $idNotaFiscal');
    print(pedido.dataPedido);
    print(pedido.valorTotal);
  }
}