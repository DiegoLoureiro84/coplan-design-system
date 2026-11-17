import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:central_web/Auth/Models/Municipio.dart';
import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppIcons.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';

/// Painel esquerdo do login: brasão e nome do município, mensagem,
/// três destaques e o logo Coplan claro. Abaixo de 899px fica só o topo.
class PainelMarcaComponent extends StatelessWidget {
  const PainelMarcaComponent({super.key, required this.municipio, this.compacto = false});

  final Municipio? municipio;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // linear-gradient(135deg, #01814E 0%, #032861 100%)
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.darkGreen, AppColors.navy],
        ),
      ),
      child: Stack(
        children: [
          // radial-gradient(1200px 600px at -10% -10%, rgba(117,197,102,.35) 0%, transparent 60%)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-1.2, -1.2),
                  radius: 1.1,
                  colors: [AppColors.accent.withValues(alpha: 0.35), AppColors.accent.withValues(alpha: 0)],
                  stops: const [0, 0.6],
                ),
              ),
            ),
          ),
          // Trama de pontos (22px), mais visível embaixo.
          const Positioned.fill(child: _TramaDePontos()),
          Padding(
            padding: compacto ? const EdgeInsets.all(24) : const EdgeInsets.symmetric(horizontal: 56, vertical: 48),
            child: compacto
                ? _Topo(municipio: municipio)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Topo(municipio: municipio),
                      const _Mensagem(),
                      SvgPicture.asset('assets/images/coplan_logo_claro.svg', width: 200),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _Topo extends StatelessWidget {
  const _Topo({required this.municipio});

  final Municipio? municipio;

  @override
  Widget build(BuildContext context) {
    final url = municipio?.brasaoUrl;
    final brasao = url != null && url.isNotEmpty
        ? Image.network(url, fit: BoxFit.contain)
        : Image.asset('assets/images/brasao_exemplo.png', fit: BoxFit.contain);

    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: brasao,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                municipio?.nome ?? '',
                style: const TextStyle(
                    fontFamily: AppText.family, fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Text(
                'Acesso aos sistemas do município',
                style: TextStyle(
                    fontFamily: AppText.family, fontSize: 13, color: Colors.white.withValues(alpha: 0.8)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Mensagem extends StatelessWidget {
  const _Mensagem();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: const Text('Todos os sistemas da gestão em um único acesso.', style: AppText.brandTitle),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Text(
            'Entre uma vez e alterne entre Central, Contábil, Tributos, Servidor e os demais sistemas sem logar de novo.',
            style: TextStyle(
                fontFamily: AppText.family, fontSize: 16, height: 1.5, color: Colors.white.withValues(alpha: 0.85)),
          ),
        ),
        const SizedBox(height: 32),
        const _Destaque(icone: AppIcons.shieldCheck, texto: 'Login com senha, certificado digital ou gov.br'),
        const SizedBox(height: 12),
        const _Destaque(icone: AppIcons.building2, texto: 'Troque de unidade gestora a qualquer momento'),
        const SizedBox(height: 12),
        const _Destaque(icone: AppIcons.search, texto: 'Encontre qualquer tela com', atalho: 'Ctrl K'),
      ],
    );
  }
}

class _Destaque extends StatelessWidget {
  const _Destaque({required this.icone, required this.texto, this.atalho});

  final IconData icone;
  final String texto;
  final String? atalho;

  @override
  Widget build(BuildContext context) {
    const estilo = TextStyle(fontFamily: AppText.family, fontSize: 15, color: Colors.white);
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icone, size: 18, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Flexible(child: Text(texto, style: estilo)),
        if (atalho != null) ...[
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(atalho!, style: estilo.copyWith(fontSize: 11)),
          ),
        ],
      ],
    );
  }
}

class _TramaDePontos extends StatelessWidget {
  const _TramaDePontos();

  @override
  Widget build(BuildContext context) {
    // mask-image: linear-gradient(to bottom, transparent, #000 70%)
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (r) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Colors.black],
        stops: [0, 0.7],
      ).createShader(r),
      child: CustomPaint(painter: _PontosPainter()),
    );
  }
}

class _PontosPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withValues(alpha: 0.08);
    for (double y = 11; y < size.height; y += 22) {
      for (double x = 11; x < size.width; x += 22) {
        canvas.drawCircle(Offset(x, y), 1, p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
