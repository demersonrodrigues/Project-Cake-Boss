import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/classesObjeto/ItemPedidoClasse.dart';
import 'package:flutterapp/classesObjeto/ProdutoClasse.dart';

import '../classesObjeto/PedidoClasse.dart';

class PedidoDAO {
  final CollectionReference pedidoCollection =
      FirebaseFirestore.instance.collection('Pedido');

  Future<DocumentReference<Object?>?> cadastrarPedido(Pedido pedido) async {
    try {
      DocumentReference docRef = await pedidoCollection.add({
        'cliente': pedido.cliente,
        'dataPedido': pedido.dataPedido,
        'horarioPedido': pedido.horarioPedido,
        'valorTotal': pedido.valorTotal,
      });

      print('Pedido cadastrado com sucesso! ${pedido.docRef}');
      return docRef;
    } catch (erro) {
      print('Erro ao cadastrar o pedido: $erro');
      return null;
    }
  }

Future<void> nomeMetodoPagamento(String idPedido, Pedido pedido,) async {
    try {
      DocumentReference idPedidoRef = pedidoCollection.doc(idPedido);

      await idPedidoRef.update({
        'cliente': pedido.cliente,
        'metodoPagamento': pedido.metodoPagamento,
      });

      print('Atualizou');
    } catch (erro) {
      print('Erro ao atualizar: $erro');
    }
  }

  Future<void> adicionarID(String idPedido, Pedido pedido,) async {
    try {
      DocumentReference idPedidoRef = pedidoCollection.doc(idPedido);

      await idPedidoRef.update({
        'idPedido': idPedido,
      });


      print('Atualizou');
    } catch (erro) {
      print('Erro ao atualizar: $erro');
    }
  }

  Future<void> deletarPedido(String idPedido) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Pedido')
        .where('idPedido', isEqualTo: idPedido)
        .get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    print('deletou $idPedido');
  }

  static Future<double> calcularValorTotal() async {
    double total = 0;
    
    QuerySnapshot pedidosSnapshot = await FirebaseFirestore.instance.collection('Pedido').get();

    for (QueryDocumentSnapshot pedidoDoc in pedidosSnapshot.docs) {
      double valorPedido = pedidoDoc['valorTotal'];
      total += valorPedido;
    }

    return total;
  }

  Future<List<Pedido>> listarPedidos() async {
  List<Pedido> pedidos = [];

  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Pedido').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documentos = snapshot.docs.map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>).toList();
     int index = 1;
    for (var documento in documentos) {
      Map<String, dynamic> dados = documento.data();

      String cliente = dados['Cliente'] ?? '';
      String dataPedido = dados['dataPedido'] ?? '';
      String horarioPedido = dados['horarioPedido'] ?? '';
      String metodoPagamento = dados['metodoPagamento'] ?? '';
      double valorTotal = dados['valorTotal'] ?? '';
      String docRef = dados['idPedido'] ?? '';

      Pedido pedido = Pedido(
        docRef: docRef,
        valorTotal: valorTotal,
        cliente: cliente,
        dataPedido: dataPedido,
        horarioPedido: horarioPedido,
        metodoPagamento: metodoPagamento,
        idPedido: index,
      );

      pedidos.add(pedido);
      index++;
    }

    for (var pedido in pedidos) {
      print('Pedido numero: ${pedido.idPedido}');
      print('Nome Cliente: ${pedido.cliente}');
      print('Valor total: ${pedido.valorTotal}');
      print('Data: ${pedido.dataPedido}');
      print('Horario: ${pedido.horarioPedido}');
      print('Metodo de pagamento: ${pedido.metodoPagamento}');
      print('------------------------');
    }
  } catch (error) {
    print('Erro ao recuperar pedidos do Firestore: $error');
  }

  return pedidos;
}



}