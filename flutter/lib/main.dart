import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';

import 'package:central_web/Compartilhado/AppTheme.dart';
import 'package:central_web/Compartilhado/Rotas/AppRotas.dart';

void main() {
  // URL sem "#", igual aos portais web atuais. O servidor precisa devolver o
  // index.html para qualquer caminho (mesma regra de nginx dos portais).
  usePathUrlStrategy();
  runApp(const CentralApp());
}

class CentralApp extends StatelessWidget {
  const CentralApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mesmo arranjo dos portais web: GetMaterialApp.router + Get.rootDelegate.
    // Sem parser customizado: a URL "/" cai na primeira rota da lista (login).
    return GetMaterialApp.router(
      title: 'Coplan',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt'), Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      getPages: AppRotas.paginas,
      routerDelegate: Get.rootDelegate,
    );
  }
}
