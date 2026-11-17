import 'package:flutter_test/flutter_test.dart';

import 'package:central_web/Compartilhado/Utils/DocumentoUtils.dart';

void main() {
  group('DocumentoUtils', () {
    test('valida o CPF de teste do protótipo', () {
      expect(DocumentoUtils.cpfValido('529.982.247-25'), isTrue);
      expect(DocumentoUtils.cpfValido('529.982.247-24'), isFalse);
      expect(DocumentoUtils.cpfValido('111.111.111-11'), isFalse);
    });

    test('valida CNPJ', () {
      expect(DocumentoUtils.cnpjValido('11.222.333/0001-81'), isTrue);
      expect(DocumentoUtils.cnpjValido('11.222.333/0001-80'), isFalse);
    });

    test('aplica a máscara de CPF e de CNPJ', () {
      expect(DocumentoUtils.mascarar('52998224725'), '529.982.247-25');
      expect(DocumentoUtils.mascarar('11222333000181'), '11.222.333/0001-81');
    });

    test('oculta o CPF da conta lembrada', () {
      expect(DocumentoUtils.ocultarCpf('52998224725'), '***.982.247-**');
    });
  });
}
