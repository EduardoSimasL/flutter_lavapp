import 'package:flutter/material.dart';
import 'package:Lavapp/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget content;

  const CustomAppBar({
    Key? key,
    required this.content, // Widget flexível para personalizar a área da AppBar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white, // Cor da AppBar
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 4), // Sombra na parte de baixo
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: AppColors.white, // Deixa transparente
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: content), // O conteúdo flexível da AppBar
              SizedBox(
                height: 70,
                width: 70,
                child: CircleAvatar(
                  radius: 35, // Tamanho do avatar
                  backgroundImage:
                      const AssetImage('assets/image/generic_profile_img.png'), // Caminho da imagem genérica
                  backgroundColor: Colors.grey.shade200, // Cor de fundo, caso não haja imagem
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150.0); // Altura personalizada
}
