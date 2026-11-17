import 'package:flutter/material.dart';

import 'package:central_web/Compartilhado/AppColors.dart';

/// Raios do Design System.
class AppRadius {
  AppRadius._();

  static const lg = 12.8; // cartão, menu suspenso
  static const md = 10.8; // campo, botão
  static const sm = 8.8; // item
}

/// Medidas fixas da estrutura.
class AppLayout {
  AppLayout._();

  static const header = 65.0;
  static const sidebar = 280.0;
  static const sidebarCollapsed = 60.0;

  /// Quebras de layout do protótipo.
  static const bpPhone = 599.0;
  static const bpTablet = 899.0;
  static const bpDesktop = 1199.0;
  static const bpWide = 1599.0;

  static const fieldHeight = 44.0;
  static const buttonHeight = 40.0;
}

/// Escala tipográfica medida no protótipo renderizado (Exo 2).
class AppText {
  AppText._();

  static const family = 'Exo2';

  static const loginTitle = TextStyle(
    fontFamily: family,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1.15,
    color: AppColors.primary,
  );

  static const brandTitle = TextStyle(
    fontFamily: family,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1.15,
    color: Colors.white,
  );

  static const subtitle = TextStyle(
    fontFamily: family,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryForeground,
  );

  static const label = TextStyle(
    fontFamily: family,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.foreground,
  );

  static const input = TextStyle(
    fontFamily: family,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.foreground,
  );

  static const body = TextStyle(
    fontFamily: family,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.foreground,
  );

  static const button = TextStyle(
    fontFamily: family,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const hint = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedForeground,
  );

  static const caption = TextStyle(
    fontFamily: family,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedForeground,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        fontFamily: AppText.family,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          error: AppColors.destructive,
          surface: AppColors.card,
          onSurface: AppColors.foreground,
        ),
        // Seleção de texto e cursor no verde do DS.
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.foreground,
          selectionColor: AppColors.accent.withValues(alpha: 0.35),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? AppColors.primary : Colors.white,
          ),
          side: const BorderSide(color: AppColors.border, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        splashFactory: NoSplash.splashFactory,
      );
}
