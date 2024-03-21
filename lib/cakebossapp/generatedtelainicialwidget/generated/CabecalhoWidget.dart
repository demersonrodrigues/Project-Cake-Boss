import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'CakeBossWidget.dart';
import 'LogoWidget.dart';
import 'TituloPaginaWidget.dart';

class CabecalhoWidget extends StatelessWidget implements PreferredSizeWidget {

  final String textoTitulo;

  const CabecalhoWidget({required this.textoTitulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //const SizedBox(height: 8),
            //CakeBossWidget(),
            //const SizedBox(height: 8),
            LogoWidget(),
            const SizedBox(height: 8),
            TituloPaginaWidget(texto: textoTitulo),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 254, 165, 0),
      elevation: kIsWeb ? 0 : 5,
      automaticallyImplyLeading: true, // Remover o botão de voltar
      toolbarHeight: 160.0, // Altura do AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160.0);
}
