import 'package:get/get.dart';

import 'package:central_web/Auth/Controllers/LoginController.dart';
import 'package:central_web/Auth/Services/AuthService.dart';
import 'package:central_web/Auth/Services/AuthServiceFake.dart';
import 'package:central_web/Auth/Services/ContaLembradaStorage.dart';

/// Monta as dependências da tela de login.
/// Para usar a API real, trocar AuthServiceFake pela implementação real aqui.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthServiceFake(), fenix: true);
    Get.lazyPut<ContaLembradaStorage>(() => ContaLembradaStorage(), fenix: true);
    Get.lazyPut<LoginController>(
      () => LoginController(service: Get.find<AuthService>(), storage: Get.find<ContaLembradaStorage>()),
    );
  }
}
