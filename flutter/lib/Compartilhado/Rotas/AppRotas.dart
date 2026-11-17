import 'package:get/get.dart';

import 'package:central_web/Auth/Bindings/LoginBinding.dart';
import 'package:central_web/Auth/Pages/LoginPage.dart';
import 'package:central_web/Sistemas/Pages/SistemasPage.dart';

/// Rotas nomeadas. Com usePathUrlStrategy cada rota vira um endereço
/// próprio (ex.: /central/login), como nos portais web atuais.
/// A primeira página da lista é a rota inicial.
class AppRotas {
  AppRotas._();

  static const login = '/login';
  static const sistemas = '/sistemas';

  static final paginas = <GetPage<dynamic>>[
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: sistemas, page: () => const SistemasPage()),
  ];
}
