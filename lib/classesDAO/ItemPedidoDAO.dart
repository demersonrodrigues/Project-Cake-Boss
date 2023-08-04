import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/classesObjeto/ProdutoClasse.dart';

import '../classesObjeto/ItemPedidoClasse.dart';

class ItemPedidoDAO {
  final CollectionReference itensPedidoCollection =
      FirebaseFirestore.instance.collection('Item_pedido');

  Future<void> cadastrarItens(ItemPedido itensPedido) async {
    try {
      await itensPedidoCollection.add({
        'idPedido': itensPedido.idPedido,
        'produto': itensPedido.produto.nome,
        'quantidade': itensPedido.quantidade,
      });
      print('Produto cadastrado com sucesso!');
    } catch (erro) {
      print('Erro ao cadastrar o produto: $erro');
    }
  }
      
      }