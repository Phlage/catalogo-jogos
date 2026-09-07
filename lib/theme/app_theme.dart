import 'package:flutter/material.dart';

/// Tema central do app. Mantido em um único lugar para que cor, tipografia
/// e área de toque sejam consistentes em todas as telas.
class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3454D1),
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Contraste: texto principal sempre sobre containers com cor de fundo
      // do próprio colorScheme, para respeitar o contraste calculado pelo M3.
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        centerTitle: false,
      ),
      // Área de toque mínima recomendada (48x48) para botões e itens de lista.
      listTileTheme: const ListTileThemeData(
        minVerticalPadding: 12,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        isDense: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: Typography.material2021(platform: TargetPlatform.android)
          .black
          .apply(fontSizeFactor: 1.0),
    );
  }
}
