import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppIcons.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';

/// Mesmo contrato do ToastComponent dos portais web (show/title/message/type).
enum ToastType { success, error, info }

/// Toast do Design System: canto superior direito, 380px, some em 8 segundos
/// ou no X. Nunca é modal.
///
/// Uso: ToastComponent.show(title: 'Não foi possível entrar', message: 'Revise os campos destacados.', type: ToastType.error);
class ToastComponent {
  ToastComponent._();

  static OverlayEntry? _camada;
  static final List<_DadosToast> _toasts = [];

  static void show({required String title, required String message, ToastType type = ToastType.info}) {
    final overlay = Get.key.currentState?.overlay;
    if (overlay == null) return;

    final dados = _DadosToast(type, title, message);
    _toasts.add(dados);
    Timer(const Duration(seconds: 8), () => _fechar(dados));

    if (_camada == null) {
      _camada = OverlayEntry(
        builder: (_) => Positioned(
          top: 90,
          right: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final t in _toasts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _Toast(tipo: t.tipo, titulo: t.titulo, mensagem: t.mensagem, onFechar: () => _fechar(t)),
                ),
            ],
          ),
        ),
      );
      overlay.insert(_camada!);
    } else {
      _camada!.markNeedsBuild();
    }
  }

  static void _fechar(_DadosToast dados) {
    if (!_toasts.remove(dados)) return;
    if (_toasts.isEmpty) {
      _camada?.remove();
      _camada = null;
    } else {
      _camada?.markNeedsBuild();
    }
  }
}

class _DadosToast {
  _DadosToast(this.tipo, this.titulo, this.mensagem);
  final ToastType tipo;
  final String titulo;
  final String mensagem;
}

class _Toast extends StatelessWidget {
  const _Toast({required this.tipo, required this.titulo, required this.mensagem, required this.onFechar});

  final ToastType tipo;
  final String titulo;
  final String mensagem;
  final VoidCallback onFechar;

  @override
  Widget build(BuildContext context) {
    final (cor, icone) = switch (tipo) {
      ToastType.success => (AppColors.darkGreen, AppIcons.circleCheck),
      ToastType.error => (AppColors.destructiveStrong, AppIcons.circleAlert),
      ToastType.info => (AppColors.primary, AppIcons.info),
    };

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 380,
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width - 32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(icone, size: 24, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo,
                      style: const TextStyle(
                          fontFamily: AppText.family, fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text(mensagem,
                      style: const TextStyle(fontFamily: AppText.family, fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            InkWell(
              onTap: onFechar,
              child: const Icon(AppIcons.x, size: 18, color: Color(0xD9FFFFFF)),
            ),
          ],
        ),
      ),
    );
  }
}
