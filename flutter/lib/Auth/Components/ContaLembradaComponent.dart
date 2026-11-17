import 'package:flutter/material.dart';

import 'package:central_web/Auth/Models/ContaLembrada.dart';
import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppIcons.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';
import 'package:central_web/Compartilhado/Utils/DocumentoUtils.dart';

/// Atalho da conta usada neste dispositivo. Ao clicar, preenche o CPF e
/// leva o foco para a senha.
class ContaLembradaComponent extends StatefulWidget {
  const ContaLembradaComponent({super.key, required this.conta, required this.onTap});

  final ContaLembrada conta;
  final VoidCallback onTap;

  @override
  State<ContaLembradaComponent> createState() => _ContaLembradaComponentState();
}

class _ContaLembradaComponentState extends State<ContaLembradaComponent> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _hover ? AppColors.rowHover : Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: _hover ? AppColors.accent : AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: Text(
                  widget.conta.iniciais,
                  style: const TextStyle(
                      fontFamily: AppText.family, fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.conta.nome, style: AppText.body.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(
                      'CPF ${DocumentoUtils.ocultarCpf(widget.conta.documento)} · usado neste dispositivo',
                      style: AppText.hint,
                    ),
                  ],
                ),
              ),
              const Icon(AppIcons.chevronRight, size: 18, color: AppColors.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}
