import 'package:flutter/material.dart';

import 'package:central_web/Auth/Models/Municipio.dart';
import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppIcons.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';

/// Seletor de município no padrão do Design System:
/// botão com aparência de campo, lista abaixo com busca,
/// hover em verde sólido com texto escuro e "selecionado" no item atual.
class SeletorMunicipioComponent extends StatefulWidget {
  const SeletorMunicipioComponent({
    super.key,
    required this.municipios,
    required this.selecionado,
    required this.onSelecionar,
  });

  final List<Municipio> municipios;
  final Municipio? selecionado;
  final ValueChanged<Municipio> onSelecionar;

  @override
  State<SeletorMunicipioComponent> createState() => _SeletorMunicipioComponentState();
}

class _SeletorMunicipioComponentState extends State<SeletorMunicipioComponent> {
  final _portal = OverlayPortalController();
  final _link = LayerLink();
  final _busca = TextEditingController();
  final _buscaFocus = FocusNode();
  final _grupo = Object();
  double _largura = 0;

  void _abrir() {
    _busca.clear();
    _portal.show();
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) => _buscaFocus.requestFocus());
  }

  void _fechar() {
    if (!_portal.isShowing) return;
    _portal.hide();
    setState(() {});
  }

  void _escolher(Municipio m) {
    widget.onSelecionar(m);
    _fechar();
  }

  @override
  void dispose() {
    _busca.dispose();
    _buscaFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aberto = _portal.isShowing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Município', style: AppText.label),
        const SizedBox(height: 10),
        LayoutBuilder(builder: (context, c) {
          _largura = c.maxWidth;
          return TapRegion(
            groupId: _grupo,
            onTapOutside: (_) => _fechar(),
            child: CompositedTransformTarget(
              link: _link,
              child: OverlayPortal(
                controller: _portal,
                overlayChildBuilder: (_) => _lista(),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: aberto ? _fechar : _abrir,
                    child: Container(
                      height: AppLayout.fieldHeight,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: aberto ? AppColors.accent : AppColors.border),
                        boxShadow: aberto ? const [BoxShadow(color: AppColors.accent, spreadRadius: 1)] : null,
                      ),
                      child: Row(
                        children: [
                          const Icon(AppIcons.mapPin, size: 18, color: AppColors.mutedForeground),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(widget.selecionado?.nomeCurto ?? 'Selecione', style: AppText.input),
                          ),
                          const Icon(AppIcons.chevronsUpDown, size: 18, color: AppColors.mutedForeground),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _lista() {
    final termo = _busca.text.trim().toLowerCase();
    final itens = widget.municipios.where((m) => m.nomeCurto.toLowerCase().contains(termo)).toList();

    return CompositedTransformFollower(
      link: _link,
      targetAnchor: Alignment.bottomLeft,
      offset: const Offset(0, 6),
      child: Align(
        alignment: Alignment.topLeft,
        child: TapRegion(
          groupId: _grupo,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: _largura,
              constraints: const BoxConstraints(maxHeight: 320),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
                boxShadow: const [BoxShadow(color: Color(0x1F0A1A2E), blurRadius: 30, offset: Offset(0, 10))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 38,
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(AppIcons.search, size: 18, color: AppColors.mutedForeground),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _busca,
                            focusNode: _buscaFocus,
                            style: AppText.input,
                            onChanged: (_) => setState(() {}),
                            onSubmitted: (_) {
                              if (itens.isNotEmpty) _escolher(itens.first);
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Buscar município',
                              hintStyle: AppText.input.copyWith(color: AppColors.mutedForeground),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (itens.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Nenhum município encontrado', style: AppText.hint),
                    )
                  else
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final m in itens)
                            _ItemMunicipio(
                              municipio: m,
                              selecionado: m.id == widget.selecionado?.id,
                              onTap: () => _escolher(m),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemMunicipio extends StatefulWidget {
  const _ItemMunicipio({required this.municipio, required this.selecionado, required this.onTap});

  final Municipio municipio;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  State<_ItemMunicipio> createState() => _ItemMunicipioState();
}

class _ItemMunicipioState extends State<_ItemMunicipio> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    // Hover: verde de destaque com texto escuro (contraste 8,3:1).
    const corTexto = AppColors.foreground;
    final corApoio = _hover ? AppColors.foreground : AppColors.mutedForeground;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: _hover ? AppColors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(AppIcons.mapPin, size: 18, color: corApoio),
              const SizedBox(width: 10),
              Expanded(child: Text(widget.municipio.nomeCurto, style: AppText.body.copyWith(color: corTexto))),
              if (widget.selecionado)
                Text('selecionado', style: AppText.hint.copyWith(color: corApoio)),
            ],
          ),
        ),
      ),
    );
  }
}
