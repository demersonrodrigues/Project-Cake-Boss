import 'package:cloud_firestore/cloud_firestore.dart';
import '../classesObjeto/ItemPedidoClasse.dart';

//t
class ItemPedidoDAO {
  final CollectionReference itensPedidoCollection =
      FirebaseFirestore.instance.collection('ItemPedido_Test');

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

  Future<List<Map<String, dynamic>>> buscarItensPorIdPedido(String idPedido) async {
    List<Map<String, dynamic>> itens = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ItemPedido_Test')
          .where('idPedido', isEqualTo: idPedido)
          .get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> dados = doc.data() as Map<String, dynamic>;
        String nomeProduto = dados['produto'];
        int quantidade = dados['quantidade'];

        itens.add({
          'nomeProduto': nomeProduto,
          'quantidade': quantidade,
        });
      });
    } catch (e) {
      print("Erro ao buscar itens: $e");
    }

    return itens;
  }
}