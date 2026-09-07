import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catalogo_jogos/main.dart';

void main() {
  testWidgets('mostra estado vazio e permite adicionar um jogo válido',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CatalogoJogosApp());

    // 1) Estado vazio deve aparecer quando não há jogos.
    expect(find.text('Sua coleção está vazia.\nToque em + para adicionar um jogo.'),
        findsOneWidget);

    // 2) Abrir o formulário pelo FAB.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('Novo jogo'), findsOneWidget);

    // 3) Tentar salvar vazio deve mostrar erro de validação.
    await tester.tap(find.text('Adicionar jogo'));
    await tester.pump();
    expect(find.text('Informe o título do jogo.'), findsOneWidget);

    // 4) Preencher campos obrigatórios corretamente.
    await tester.enterText(find.widgetWithText(TextFormField, 'Título'), 'Hollow Knight');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Nota (0 a 10)'), '9.5');
    await tester.tap(find.text('Adicionar jogo'));
    await tester.pumpAndSettle();

    // 5) O item deve aparecer na lista e o estado vazio deve sumir.
    expect(find.text('Hollow Knight'), findsOneWidget);
    expect(find.text('Sua coleção está vazia.\nToque em + para adicionar um jogo.'),
        findsNothing);
  });
}
