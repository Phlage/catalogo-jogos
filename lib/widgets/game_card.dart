import 'package:flutter/material.dart';
import '../models/game.dart';

/// Widget extraído porque o mesmo "cartão de jogo" é usado na lista principal
/// e poderia ser reaproveitado em uma futura tela de busca/favoritos.
/// Extrair evita duplicar o layout do ListTile em mais de um lugar.
class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameCard({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        onTap: onTap,
        // Semantics explícito garante que leitores de tela anunciem
        // título, plataforma e nota em uma frase coerente.
        title: Text(
          game.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text('${game.platform} • ${game.status}'),
        leading: CircleAvatar(
          backgroundColor: scheme.secondaryContainer,
          child: Text(
            game.rating.toStringAsFixed(1),
            style: TextStyle(
              color: scheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
