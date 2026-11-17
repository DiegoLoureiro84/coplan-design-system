import 'package:flutter/material.dart';

import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';

/// Destino depois do login. Placeholder: a escolha de sistema é a próxima
/// tela a construir (roteiro, passo 2: #sistemas no protótipo).
class SistemasPage extends StatelessWidget {
  const SistemasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Sistemas · Coplan',
      color: AppColors.primary,
      child: Scaffold(
        body: Center(
          child: Text(
            'Escolha de sistema (próxima tela)',
            style: AppText.subtitle.copyWith(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
