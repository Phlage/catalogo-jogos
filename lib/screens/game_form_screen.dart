import 'package:flutter/material.dart';
import '../models/game.dart';

/// Formulário único usado tanto para criação quanto para edição.
/// Se [existing] for nulo, é criação; caso contrário, edição.
class GameFormScreen extends StatefulWidget {
  final Game? existing;
  final void Function(Game game) onSave;

  const GameFormScreen({super.key, this.existing, required this.onSave});

  @override
  State<GameFormScreen> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _ratingController;
  late TextEditingController _notesController;
  late String _platform;
  late String _status;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final g = widget.existing;
    _titleController = TextEditingController(text: g?.title ?? '');
    _ratingController =
        TextEditingController(text: g != null ? g.rating.toStringAsFixed(1) : '');
    _notesController = TextEditingController(text: g?.notes ?? '');
    _platform = g?.platform ?? kPlatforms.first;
    _status = g?.status ?? kStatuses.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ratingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o título do jogo.';
    }
    if (value.trim().length < 2) {
      return 'Título muito curto.';
    }
    return null;
  }

  String? _validateRating(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe uma nota de 0 a 10.';
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null) {
      return 'Use um número válido (ex: 8.5).';
    }
    if (parsed < 0 || parsed > 10) {
      return 'A nota deve estar entre 0 e 10.';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      // Feedback adicional visível além dos erros de campo.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Corrija os campos destacados.')),
      );
      return;
    }

    final rating = double.parse(_ratingController.text.replaceAll(',', '.'));
    final game = Game(
      id: widget.existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      platform: _platform,
      rating: rating,
      status: _status,
      notes: _notesController.text.trim(),
    );
    widget.onSave(game);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar jogo' : 'Novo jogo'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                helperText: 'Nome do jogo',
              ),
              validator: _validateTitle,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _platform,
              decoration: const InputDecoration(labelText: 'Plataforma'),
              items: kPlatforms
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (value) => setState(() => _platform = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: kStatuses
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (value) => setState(() => _status = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Nota (0 a 10)',
                helperText: 'Ex: 8.5',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: _validateRating,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notas (opcional)',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.save),
              label: Text(_isEditing ? 'Salvar alterações' : 'Adicionar jogo'),
            ),
          ],
        ),
      ),
    );
  }
}
