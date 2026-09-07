import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/game_list_screen.dart';

void main() {
  runApp(const CatalogoJogosApp());
}

class CatalogoJogosApp extends StatelessWidget {
  const CatalogoJogosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Jogos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const GameListScreen(),
    );
  }
}
