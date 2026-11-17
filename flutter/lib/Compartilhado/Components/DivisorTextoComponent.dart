import 'package:flutter/material.dart';

import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';

/// Linha com texto no meio: "ou entre com outra conta".
class DivisorTextoComponent extends StatelessWidget {
  const DivisorTextoComponent({super.key, required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    const linha = Expanded(child: Divider(height: 1, thickness: 1, color: AppColors.border));
    return Row(
      children: [
        linha,
        const SizedBox(width: 12),
        Text(texto, style: AppText.caption),
        const SizedBox(width: 12),
        linha,
      ],
    );
  }
}
