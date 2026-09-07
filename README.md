# Catálogo de Jogos — Desenvolvimento Mobile I (M1)

Catálogo pessoal local em Flutter para organizar jogos que você quer jogar,
está jogando ou já concluiu. Sem persistência, autenticação ou API — estado
mantido em memória, conforme escopo do M1.

## Como rodar

```bash
git clone <URL_DO_SEU_REPOSITORIO>
cd catalogo_jogos
flutter pub get
flutter analyze
flutter test
flutter run
```

## Gerar o APK

```bash
flutter build apk --release
```

O artefato fica em `build/app/outputs/flutter-apk/app-release.apk`.

## Estrutura

```
lib/
  models/game.dart          modelo de domínio
  theme/app_theme.dart      tema Material 3
  widgets/game_card.dart    card reutilizável da lista
  widgets/empty_state.dart  estado vazio reutilizável
  screens/game_list_screen.dart   lista + layout responsivo mestre-detalhe
  screens/game_detail_screen.dart detalhe do jogo
  screens/game_form_screen.dart   formulário de criação/edição com validação
test/widget_test.dart       teste de widget (estado vazio + criação válida)
```
