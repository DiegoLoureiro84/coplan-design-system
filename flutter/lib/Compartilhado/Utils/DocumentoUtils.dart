import 'package:flutter/services.dart';

/// Máscara e validação de CPF e CNPJ, iguais às do protótipo.
class DocumentoUtils {
  DocumentoUtils._();

  static String somenteDigitos(String v) => v.replaceAll(RegExp(r'\D'), '');

  /// 000.000.000-00 até 11 dígitos; 00.000.000/0000-00 a partir de 12.
  static String mascarar(String valor) {
    final d = somenteDigitos(valor);
    final v = d.length > 14 ? d.substring(0, 14) : d;
    final b = StringBuffer();
    if (v.length <= 11) {
      for (var i = 0; i < v.length; i++) {
        if (i == 3 || i == 6) b.write('.');
        if (i == 9) b.write('-');
        b.write(v[i]);
      }
    } else {
      for (var i = 0; i < v.length; i++) {
        if (i == 2 || i == 5) b.write('.');
        if (i == 8) b.write('/');
        if (i == 12) b.write('-');
        b.write(v[i]);
      }
    }
    return b.toString();
  }

  static bool cpfValido(String valor) {
    final c = somenteDigitos(valor);
    if (c.length != 11 || RegExp(r'^(\d)\1+$').hasMatch(c)) return false;
    int dv(int n) {
      var s = 0;
      for (var i = 0; i < n; i++) {
        s += int.parse(c[i]) * (n + 1 - i);
      }
      return (s * 10) % 11 % 10;
    }

    return dv(9) == int.parse(c[9]) && dv(10) == int.parse(c[10]);
  }

  static bool cnpjValido(String valor) {
    final c = somenteDigitos(valor);
    if (c.length != 14 || RegExp(r'^(\d)\1+$').hasMatch(c)) return false;
    int dv(int n) {
      var peso = n - 7;
      var s = 0;
      for (var i = 0; i < n; i++) {
        s += int.parse(c[i]) * peso--;
        if (peso < 2) peso = 9;
      }
      final r = s % 11;
      return r < 2 ? 0 : 11 - r;
    }

    return dv(12) == int.parse(c[12]) && dv(13) == int.parse(c[13]);
  }

  static bool documentoValido(String valor) {
    final d = somenteDigitos(valor);
    if (d.length == 11) return cpfValido(d);
    if (d.length == 14) return cnpjValido(d);
    return false;
  }

  /// Mostra só parte do CPF: ***.982.247-**
  static String ocultarCpf(String valor) {
    final m = mascarar(valor);
    if (m.length != 14) return m;
    return '***${m.substring(3, 12)}**';
  }
}

/// Aplica a máscara de CPF/CNPJ enquanto o usuário digita ou cola.
/// Colar "529.982.247-25" ou "52998224725" dá o mesmo resultado.
class DocumentoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final texto = DocumentoUtils.mascarar(newValue.text);
    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}
