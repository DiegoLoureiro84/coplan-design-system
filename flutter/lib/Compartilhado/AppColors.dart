import 'package:flutter/material.dart';

/// Paleta oficial do Design System 2.1 (contraste mínimo 4,5:1 para texto).
/// Fonte: https://diegoloureiro84.github.io/coplan-design-system/#cores
/// Nenhuma cor fora desta classe deve ser usada nas telas.
class AppColors {
  AppColors._();

  static const primary = Color(0xFF1F4993);
  static const primaryHover = Color(0xFF1A3E7D); // primary com brilho 0.85, igual ao hover do protótipo

  /// Verde de destaque: hover e seleção, sempre com texto [foreground] (8,3:1).
  /// Texto branco sobre verde só em [darkGreen] (4,9:1).
  static const accent = Color(0xFF75C566);
  static const darkGreen = Color(0xFF01814E);
  static const navy = Color(0xFF032861);

  static const background = Color(0xFFF8F9FE);
  static const card = Color(0xFFFFFFFF);
  static const foreground = Color(0xFF0A1A2E);
  static const black = Color(0xFF01060B);

  static const border = Color(0xFFE0E0E1);
  static const secondary = Color(0xFFF5F5F6);
  static const secondaryForeground = Color(0xFF57575A);
  static const muted = Color(0xFFE6E6E7);
  static const mutedForeground = Color(0xFF6B6B6E); // 5,3:1 sobre branco

  static const readonly = Color(0xFFEEF1FA);
  static const lightGreen = Color(0xFFE6F8F0);
  static const rowHover = Color(0xFFEAF7EE);

  /// Somente para bloqueio e erro que impede a ação.
  /// #EF4444: borda, barra e ícone. Texto vermelho e fundo com texto branco: [destructiveStrong].
  static const destructive = Color(0xFFEF4444);
  static const destructiveStrong = Color(0xFFB91C1C); // 6,5:1 sobre branco
  static const destructiveBackground = Color(0xFFFEF2F2);
  static const destructiveBorder = Color(0xFFFECACA);

  /// Família de aviso, para o que não bloqueia (ex.: Caps Lock, certidão a vencer).
  static const warning = Color(0xFF78350F); // texto de aviso
  static const warningBackground = Color(0xFFFEF3C7);
  static const pending = Color(0xFFFCD34D); // pílula "pendente", com texto [foreground]
  static const star = Color(0xFFF5B301); // estrela de favorito

  static const logoOnDark = Color(0xFFF6F8ED);
}
