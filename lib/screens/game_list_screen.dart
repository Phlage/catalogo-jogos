import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import '../widgets/empty_state.dart';
import 'game_detail_screen.dart';
import 'game_form_screen.dart';

/// Tela principal: mantém a coleção em estado local (List<Game> em memória,
/// sem persistência, conforme escopo do M1).
///
/// Responsividade: em telas largas (>= 700 logical px) mostra lista + detalhe
/// lado a lado (mestre-detalhe). Em telas estreitas, navega para uma tela de
/// detalhe separada com Navigator.push. Isso evita overflow tanto em telas
/// pequenas (celular) quanto no uso do mesmo conteúdo em telas largas (tablet/web).
class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  final List<Game> _games = [];
  Game? _selected;

  static const double _wideBreakpoint = 700;

  void _addOrUpdate(Game game) {
    setState(() {
      final index = _games.indexWhere((g) => g.id == game.id);
      if (index >= 0) {
        _games[index] = game;
        if (_selected?.id == game.id) _selected = game;
      } else {
        _games.add(game);
      }
    });
  }

  void _delete(Game game) {
    setState(() {
      _games.removeWhere((g) => g.id == game.id);
      if (_selected?.id == game.id) _selected = null;
    });
  }

  void _openForm({Game? existing}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameFormScreen(existing: existing, onSave: _addOrUpdate),
      ),
    );
  }

  void _openDetailNarrow(Game game) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameDetailScreen(
          game: game,
          onEdit: () => _openForm(existing: game),
          onDelete: () {
            _delete(game);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildList(bool wide) {
    if (_games.isEmpty) {
      return const EmptyState();
    }
    return ListView.builder(
      itemCount: _games.length,
      itemBuilder: (context, index) {
        final game = _games[index];
        return GameCard(
          game: game,
          onTap: () {
            if (wide) {
              setState(() => _selected = game);
            } else {
              _openDetailNarrow(game);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Jogos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        tooltip: 'Adicionar jogo',
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= _wideBreakpoint;

          if (!wide) {
            // Espaço estreito: só a lista; detalhe abre em outra tela.
            return _buildList(false);
          }

          // Espaço largo: lista + detalhe lado a lado, sem overflow porque
          // cada painel tem sua própria largura fixa via Expanded/flex.
          return Row(
            children: [
              SizedBox(
                width: 320,
                child: _buildList(true),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: _selected == null
                    ? const Center(child: Text('Selecione um jogo na lista.'))
                    : GameDetailScreen(
                        key: ValueKey(_selected!.id),
                        game: _selected!,
                        onEdit: () => _openForm(existing: _selected),
                        onDelete: () => _delete(_selected!),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
