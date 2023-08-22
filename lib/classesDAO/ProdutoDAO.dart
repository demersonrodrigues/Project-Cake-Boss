import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classesObjeto/ProdutoClasse.dart';


class ProdutoDAO {
  final CollectionReference produtosCollection =
      FirebaseFirestore.instance.collection('Produto_Test');

  Future<void> cadastrarProduto(Produto produto) async {
    try {
      await produtosCollection.add({
        'nome': produto.nome,
        'descricao': produto.descricao,
        'peso': produto.peso,
        'valor': produto.valor,
        'quantidadeEstoque': produto.quantidadeEstoque,
        'categoria': produto.categoria
      });
      print('Produto cadastrado com sucesso!');
    } catch (erro) {
      print('Erro ao cadastrar o produto: $erro');
    }
  }

  Future<List<Produto>> listarProdutos() async {
    List<Produto> produtos = [];

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Produto_Test').get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> documentos = snapshot
          .docs
          .map((doc) => doc as QueryDocumentSnapshot<Map<String, dynamic>>)
          .toList();

      for (var documento in documentos) {
        Map<String, dynamic> dados = documento.data();

        String nome = dados['nome'];
        double valor = (dados['valor'] as num).toDouble();
        double peso = (dados['peso'] as num).toDouble();
        int quantidadeEstoque = dados['quantidadeEstoque'];
        String descricao = dados['descricao'];

        Produto produto = Produto(
          nome: nome,
          valor: valor,
          peso: peso,
          quantidadeEstoque: quantidadeEstoque,
          descricao: descricao,
        );

        produtos.add(produto);
      }

      for (var produto in produtos) {
        print('Nome: ${produto.nome}');
        print('Valor: ${produto.valor}');
        print('Peso: ${produto.peso}');
        print('Quantidade em Estoque: ${produto.quantidadeEstoque}');
        print('Descrição: ${produto.descricao}');
        print('------------------------');
      }
    } catch (error) {
      print('Erro ao recuperar produtos do Firestore: $error');
    }

    return produtos;
  }

  Future<void> deletarProduto(String nomeProduto) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Produto_Test')
        .where('nome', isEqualTo: nomeProduto)
        .get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> adicionarAoEstoque(
      String nomeProduto, int quantidadeAdicionar) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Produto_Test')
          .where('nome', isEqualTo: nomeProduto)
          .get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        int quantidadeEstoqueAtual = doc['quantidadeEstoque'];
        int novaQuantidadeEstoque =
            quantidadeEstoqueAtual + quantidadeAdicionar;

        await doc.reference
            .update({'quantidadeEstoque': novaQuantidadeEstoque});
        print('Novo estoque: $novaQuantidadeEstoque');
      }
    } catch (error) {
      print('Erro ao adicionar ao estoque: $error');
    }
  }

  Future<void> removerDoEstoque(
      String nomeProduto, int quantidadeRemover, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Produto_Test')
          .where('nome', isEqualTo: nomeProduto)
          .get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        int quantidadeEstoqueAtual = doc['quantidadeEstoque'];

        if (quantidadeRemover <= quantidadeEstoqueAtual) {
          int novaQuantidadeEstoque =
              quantidadeEstoqueAtual - quantidadeRemover;
          await doc.reference
              .update({'quantidadeEstoque': novaQuantidadeEstoque});
          

          print('Novo estoque: $novaQuantidadeEstoque');
        } else {         
          print('Quantidade a remover maior do que o estoque atual');
        }
      }
    } catch (error) {
      print('Erro ao remover ao estoque: $error');
    }
  }
}
