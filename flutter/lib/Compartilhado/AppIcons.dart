import 'package:flutter/widgets.dart';

/// Ícones Lucide (mesmos nomes do protótipo), via a fonte assets/fonts/Lucide.ttf.
/// Codepoints do pacote lucide-static 1.70.0 (mesma versão do protótipo). Para adicionar um ícone, pegue o código
/// em font/codepoints.json do lucide-static e crie a constante aqui.
class AppIcons {
  AppIcons._();

  static const _f = 'Lucide';

  static const mapPin = IconData(0xE111, fontFamily: _f); // map-pin
  static const chevronsUpDown = IconData(0xE211, fontFamily: _f); // chevrons-up-down
  static const search = IconData(0xE151, fontFamily: _f); // search
  static const user = IconData(0xE19F, fontFamily: _f); // user
  static const circleCheck = IconData(0xE226, fontFamily: _f); // circle-check
  static const lock = IconData(0xE10B, fontFamily: _f); // lock
  static const eye = IconData(0xE0BA, fontFamily: _f); // eye
  static const eyeOff = IconData(0xE0BB, fontFamily: _f); // eye-off
  static const triangleAlert = IconData(0xE193, fontFamily: _f); // triangle-alert
  static const circleAlert = IconData(0xE077, fontFamily: _f); // circle-alert
  static const logIn = IconData(0xE10D, fontFamily: _f); // log-in
  static const usb = IconData(0xE356, fontFamily: _f); // usb
  static const landmark = IconData(0xE23A, fontFamily: _f); // landmark
  static const chevronRight = IconData(0xE06F, fontFamily: _f); // chevron-right
  static const shieldCheck = IconData(0xE1FF, fontFamily: _f); // shield-check
  static const building2 = IconData(0xE290, fontFamily: _f); // building-2
  static const info = IconData(0xE0F9, fontFamily: _f); // info
  static const x = IconData(0xE1B2, fontFamily: _f); // x
  static const check = IconData(0xE06C, fontFamily: _f); // check
  static const keyRound = IconData(0xE4A3, fontFamily: _f); // key-round
  static const send = IconData(0xE152, fontFamily: _f); // send
  static const arrowLeft = IconData(0xE048, fontFamily: _f); // arrow-left
  static const layoutGrid = IconData(0xE0FF, fontFamily: _f); // layout-grid
}
