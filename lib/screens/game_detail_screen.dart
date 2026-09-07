import 'package:flutter/material.dart';
import '../models/game.dart';

/// Tela de detalhe de um jogo selecionado.
/// Recebe o objeto Game e callbacks para editar/excluir, sem conhecer
/// como a lista é armazenada (mantém a tela desacoplada do estado global).
class GameDetailScreen extends StatelessWidget {
  final Game game;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GameDetailScreen({
    super.key,
    required this.game,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar jogo',
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir jogo',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Excluir jogo'),
                  content: Text('Remover "${game.title}" da coleção?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Excluir'),
                    ),
                  ],
                ),
              );
              if (confirm == true) onDelete();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: const Icon(Icons.videogame_asset, size: 18),
                  label: Text(game.platform),
                ),
                Chip(
                  avatar: const Icon(Icons.flag_outlined, size: 18),
                  label: Text(game.status),
                  backgroundColor: scheme.secondaryContainer,
                ),
                Chip(
                  avatar: const Icon(Icons.star, size: 18),
                  label: Text('Nota: ${game.rating.toStringAsFixed(1)}'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Notas', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              game.notes.isEmpty ? 'Sem notas adicionadas.' : game.notes,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
