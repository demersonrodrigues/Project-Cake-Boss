import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'ItemPedidoClasse.dart';

class NotaFiscal{
  int? idNotaFiscal;

  NotaFiscal({
    this.idNotaFiscal,
  });


  Future<File> gerarPDF(List<ItemPedido> itens) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Data: ${itens[0].pedido.dataPedido}   Horario: ${itens[0].pedido.horarioPedido}'),
                pw.Text('Delicias Da Joice', style: pw.TextStyle(fontSize: 25)),
                pw.SizedBox(height: 1),
                pw.Text('Whatsapp: (71)9 9948-8681', style: pw.TextStyle(fontSize: 8)),
                pw.SizedBox(height: 5),
                pw.Text('Cliente: ${itens[0].pedido.cliente}   Metodo de pagamento: ${itens[0].pedido.metodoPagamento}'),
                pw.SizedBox(height: 10),
                pw.Text('================================='),
                pw.Text('Descrição / Qtd X Unitario         Total'),
                pw.Text('================================='),
                for (var item in itens)
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('${item.produto.nome} ${item.produto.peso}g'),
                          pw.Text('${item.quantidade} x R\$${item.produto.valor}                                   R\$${item.quantidade * item.produto.valor}'),
                          pw.Text('---------------------------------------------------'),
                        ],
                      ),
                    ],
                  ),
                pw.SizedBox(height: 10),
                pw.Text('                        Total a pagar: R\$${itens[0].pedido.valorTotal}'),
              ],
            ),
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();

    final tempDir = await getTemporaryDirectory();
    final fileName = '${itens[0].idPedido}.pdf';
    final filePath = '${tempDir.path}/$fileName';

    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);

    print('PDF gerado e salvo em: $filePath');
    return file;
  }
}