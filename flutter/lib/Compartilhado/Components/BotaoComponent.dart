import 'package:flutter/material.dart';

import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';

enum VarianteBotao {
  /// Ação principal da área. Fundo #1F4993, texto branco.
  primario,

  /// Ação secundária com contorno. Fundo branco, borda #E0E0E1, texto primário.
  contorno,

  /// Secundário neutro. Fundo branco, borda #E0E0E1, texto #57575A.
  cinza,
}

/// Botão padrão: 40px de altura, ícone de 16px à esquerda, texto 14/500.
/// Não existe botão vermelho no sistema.
class BotaoComponent extends StatefulWidget {
  const BotaoComponent({
    super.key,
    required this.texto,
    required this.onPressed,
    this.icone,
    this.variante = VarianteBotao.primario,
    this.carregando = false,
    this.textoCarregando,
    this.larguraTotal = false,
    this.raio = AppRadius.md,
  });

  final String texto;
  final VoidCallback? onPressed;
  final IconData? icone;
  final VarianteBotao variante;
  final bool carregando;
  final String? textoCarregando;
  final bool larguraTotal;

  /// O protótipo usa 6px nos botões de "outras formas de acesso" do login.
  final double raio;

  @override
  State<BotaoComponent> createState() => _BotaoComponentState();
}

class _BotaoComponentState extends State<BotaoComponent> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final desabilitado = widget.onPressed == null || widget.carregando;

    late Color fundo;
    late Color texto;
    Color? borda;
    switch (widget.variante) {
      case VarianteBotao.primario:
        fundo = _hover && !desabilitado ? AppColors.primaryHover : AppColors.primary;
        texto = Colors.white;
      case VarianteBotao.contorno:
        fundo = _hover && !desabilitado ? AppColors.secondary : Colors.white;
        texto = AppColors.primary;
        borda = AppColors.border;
      case VarianteBotao.cinza:
        fundo = _hover && !desabilitado ? AppColors.secondary : Colors.white;
        texto = AppColors.secondaryForeground;
        borda = AppColors.border;
    }

    final rotulo = Text(
      widget.carregando ? (widget.textoCarregando ?? widget.texto) : widget.texto,
      style: AppText.button.copyWith(color: texto),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    final conteudo = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.carregando)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: texto,
              backgroundColor: texto.withValues(alpha: 0.4),
            ),
          )
        else if (widget.icone != null)
          Icon(widget.icone, size: 16, color: texto),
        if (widget.carregando || widget.icone != null) const SizedBox(width: 8),
        // Com largura total o texto pode encolher (reticências) em telas estreitas.
        // Sem largura total o botão cresce com o texto, então não usa Flexible
        // (Flexible com largura livre quebra o layout dentro de uma Row).
        if (widget.larguraTotal) Flexible(child: rotulo) else rotulo,
      ],
    );

    return MouseRegion(
      cursor: desabilitado ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: desabilitado ? null : widget.onPressed,
        child: Opacity(
          opacity: widget.onPressed == null ? 0.5 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: AppLayout.buttonHeight,
            width: widget.larguraTotal ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: fundo,
              borderRadius: BorderRadius.circular(widget.raio),
              border: borda == null ? null : Border.all(color: borda),
            ),
            child: conteudo,
          ),
        ),
      ),
    );
  }
}

/// Link de texto: primário 14/500, sublinhado no hover.
class LinkComponent extends StatefulWidget {
  const LinkComponent({super.key, required this.texto, required this.onPressed, this.tamanho = 14});

  final String texto;
  final VoidCallback onPressed;
  final double tamanho;

  @override
  State<LinkComponent> createState() => _LinkComponentState();
}

class _LinkComponentState extends State<LinkComponent> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Text(
          widget.texto,
          style: AppText.button.copyWith(
            fontSize: widget.tamanho,
            color: AppColors.primary,
            decoration: _hover ? TextDecoration.underline : TextDecoration.none,
            decorationColor: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
