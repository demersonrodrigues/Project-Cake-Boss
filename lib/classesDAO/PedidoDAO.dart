import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/classesObjeto/ItemPedidoClasse.dart';
import 'package:flutterapp/classesObjeto/ProdutoClasse.dart';

import '../classesObjeto/PedidoClasse.dart';

class PedidoDAO {
  final CollectionReference pedidoCollection =
      FirebaseFirestore.instance.collection('Pedido');

  Future<DocumentReference<Object?>?> cadastrarPedido(Pedido pedido) async {
    try {
      DocumentReference idPedido = await pedidoCollection.add({
        'cliente': pedido.cliente,
        'dataPedido': pedido.dataPedido,
        'horarioPedido': pedido.horarioPedido,
        'valorTotal': pedido.valorTotal,
      });
      print('Pedido cadastrado com sucesso!');
      return idPedido;
    } catch (erro) {
      print('Erro ao cadastrar o pedido: $erro');
      return null;
    }
  }

Future<void> nomeMetodoPagamento(String idPedido, Pedido pedido) async {
    try {
      DocumentReference pedidoRef = pedidoCollection.doc(idPedido);

      await pedidoRef.update({
        'cliente': pedido.cliente,
        'metodoPagamento': pedido.metodoPagamento,
      });

      print('Atualizou');
    } catch (erro) {
      print('Erro ao atualizar: $erro');
    }
  }
}