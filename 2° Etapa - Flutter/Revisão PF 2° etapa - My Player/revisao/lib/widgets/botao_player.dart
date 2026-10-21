import 'package:flutter/material.dart';

class BotaoPlayer extends StatelessWidget {
  final IconData icone;

  final VoidCallback aoClicar;

  final bool principal;

  const BotaoPlayer({
    super.key,
    required this.icone,
    required this.aoClicar,
    this.principal = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: aoClicar,
      iconSize: principal ? 42 : 30,
      padding: EdgeInsets.all(
        principal ? 18 : 12,
      ),
      icon: Icon(icone),
    );
  }
}
