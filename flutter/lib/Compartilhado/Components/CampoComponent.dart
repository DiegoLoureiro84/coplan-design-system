import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppIcons.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';

/// Campo padrão do Design System: rótulo acima, caixa de 44px com fundo da
/// aplicação, foco verde, erro vermelho (só quando impede seguir) e
/// mensagem abaixo.
///
/// Estados visuais:
/// - normal: borda #E0E0E1
/// - foco: borda e anel de 1px em #75C566
/// - erro: borda e anel de 1px em #F44336 + mensagem em #B91C1C
/// - válido: marca de confirmação verde escuro à direita
class CampoComponent extends StatefulWidget {
  const CampoComponent({
    super.key,
    required this.rotulo,
    this.controller,
    this.focusNode,
    this.icone,
    this.placeholder,
    this.obscureText = false,
    this.sufixo,
    this.erro,
    this.aviso,
    this.valido = false,
    this.keyboardType,
    this.inputFormatters,
    this.autofillHints,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
  });

  final String rotulo;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData? icone;
  final String? placeholder;
  final bool obscureText;
  final Widget? sufixo;
  final String? erro;
  final String? aviso;
  final bool valido;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<CampoComponent> createState() => _CampoComponentState();
}

class _CampoComponentState extends State<CampoComponent> {
  late final FocusNode _focus = widget.focusNode ?? FocusNode();
  bool _comFoco = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_aoMudarFoco);
  }

  void _aoMudarFoco() => setState(() => _comFoco = _focus.hasFocus);

  @override
  void dispose() {
    _focus.removeListener(_aoMudarFoco);
    if (widget.focusNode == null) _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temErro = widget.erro != null && widget.erro!.isNotEmpty;
    final corBorda = temErro
        ? AppColors.destructive
        : _comFoco
            ? AppColors.accent
            : AppColors.border;
    final anel = temErro || _comFoco;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.rotulo, style: AppText.label),
        const SizedBox(height: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: AppLayout.fieldHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: corBorda),
            // O protótipo usa box-shadow 0 0 0 1px: um anel extra de 1px.
            boxShadow: anel ? [BoxShadow(color: corBorda, spreadRadius: 1)] : null,
          ),
          child: Row(
            children: [
              if (widget.icone != null) ...[
                Icon(widget.icone, size: 18, color: AppColors.mutedForeground),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focus,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  autofillHints: widget.autofillHints,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  style: AppText.input,
                  decoration: InputDecoration.collapsed(
                    hintText: widget.placeholder,
                    hintStyle: AppText.input.copyWith(color: AppColors.mutedForeground),
                  ),
                ),
              ),
              if (widget.valido && !temErro) ...[
                const SizedBox(width: 10),
                const Icon(AppIcons.circleCheck, size: 18, color: AppColors.darkGreen),
              ],
              if (widget.sufixo != null) ...[
                const SizedBox(width: 6),
                widget.sufixo!,
              ],
            ],
          ),
        ),
        if (widget.aviso != null && widget.aviso!.isNotEmpty)
          MensagemCampo(texto: widget.aviso!, tipo: TipoMensagemCampo.aviso),
        if (temErro) MensagemCampo(texto: widget.erro!, tipo: TipoMensagemCampo.erro),
      ],
    );
  }
}

enum TipoMensagemCampo { erro, aviso }

/// Linha de mensagem abaixo do campo (12px, ícone de 14px).
class MensagemCampo extends StatelessWidget {
  const MensagemCampo({super.key, required this.texto, required this.tipo});

  final String texto;
  final TipoMensagemCampo tipo;

  @override
  Widget build(BuildContext context) {
    final erro = tipo == TipoMensagemCampo.erro;
    final cor = erro ? AppColors.destructiveStrong : AppColors.warning;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(erro ? AppIcons.circleAlert : AppIcons.triangleAlert, size: 14, color: cor),
          const SizedBox(width: 6),
          Expanded(child: Text(texto, style: AppText.hint.copyWith(color: cor))),
        ],
      ),
    );
  }
}
