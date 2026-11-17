# Kit Flutter do Coplan Design System: modelo da tela de login

Modelo de referência em Flutter web para o front do novo Central. Ele reproduz a tela de login do protótipo e serve de padrão para as demais telas.

- Protótipo (referência visual e de comportamento): https://diegoloureiro84.github.io/prototipo-central/#login
- Design System: https://diegoloureiro84.github.io/coplan-design-system/
- Especificação: https://github.com/DiegoLoureiro84/prototipo-central/blob/main/ESPECIFICACAO-FRONT.md

## Padrão adotado

É o mesmo dos portais web atuais (fornecedor, contribuinte e servidor):
- Flutter 3.35.7 via fvm, Dart `^3.8.1`;
- GetX 4.7.2, com `GetMaterialApp.router` e navegação por `Get.rootDelegate`;
- URL sem `#` (`usePathUrlStrategy`) e textos do sistema em pt-BR (`flutter_localizations`);
- `shared_preferences` com prefixo por projeto (`central_`);
- `ToastComponent.show(title:, message:, type:)` com a mesma assinatura dos portais;
- quebras de layout 600, 900, 1200 e 1600, as mesmas do `ResponsiveUtils`;
- módulos com `Bindings`, `Components`, `Controllers`, `Models`, `Pages` e `Services`, mais `Compartilhado`;
- arquivos em PascalCase.

```
lib/
  main.dart                     GetMaterialApp, tema e rotas
  Compartilhado/
    AppColors.dart              paleta do Design System (única fonte de cor)
    AppTheme.dart               tipografia, raios, medidas e ThemeData
    AppIcons.dart               ícones Lucide (mesmos do protótipo)
    Components/                 Campo, Botão, Link, Divisor, Toast
    Utils/DocumentoUtils.dart   máscara e validação de CPF/CNPJ
    Rotas/AppRotas.dart         rotas nomeadas
  Auth/
    Bindings/LoginBinding.dart  monta controller e services
    Controllers/LoginController.dart   estado e regras da tela
    Models/                     Municipio, ContaLembrada, Sessao
    Services/AuthService.dart   contrato com o backend
    Services/AuthServiceFake.dart      simulação igual ao protótipo
    Components/                 painel de marca, conta lembrada, seletor de município
    Pages/LoginPage.dart        só desenha, sem regra de negócio
  Sistemas/Pages/SistemasPage.dart     destino após o login (placeholder)
```

## Regras que este modelo estabelece para as próximas telas

1. **Cor só de `AppColors`, texto só de `AppText`, raio só de `AppRadius`.** Nenhum `Color(0x...)` solto nas páginas.
2. **A página não tem regra.** Validação, mensagens e chamadas ficam no Controller. A página lê o estado com `Obx`.
3. **O Controller depende de um contrato (`AuthService`), não da API.** Para ligar o backend, crie a implementação real e troque no `LoginBinding`. O controller e a página não mudam.
4. **Componentes do Design System em `Compartilhado/Components`.** Antes de criar um widget, veja se ele já existe ali.
5. **Sem janela modal.** Confirmações e fluxos secundários aparecem no lugar do conteúdo, como o "Recuperar senha".
6. **Textos iguais aos do protótipo**, inclusive mensagens de erro e toasts.
7. **Título da aba** com o widget `Title`, no formato `Tela · Sistema · Coplan`.

## Como rodar

O projeto não traz a pasta `web/`. Ela é gerada pelo próprio Flutter:

```
fvm install
fvm flutter create . --platforms web --project-name central_web
fvm flutter pub get
fvm flutter run -d chrome
```

Testes de CPF e CNPJ: `fvm flutter test`.

Build para publicar num subcaminho, como os portais: `fvm flutter build web --base-href /central/`. O nginx precisa devolver o `index.html` para qualquer caminho dentro de `/central/`.

Para testar a tela, use o CPF `529.982.247-25` e qualquer senha com 4 ou mais caracteres. Senha menor que 4 simula senha recusada.

## Fontes e ícones

- **Exo 2**, em `assets/fonts`, pesos 400 a 800. Licença OFL. É embutida, sem Google Fonts em tempo de execução.
- **Lucide**, versão 1.70.0, a mesma do protótipo, como fonte de ícones (`assets/fonts/Lucide.ttf`). Licença ISC.
  - Para adicionar um ícone, pegue o codepoint em `font/codepoints.json` do pacote `lucide-static` e crie a constante em `AppIcons`.
  - No build de release, o Flutter remove da fonte os ícones não usados.

## Pendências conhecidas

- `AuthServiceFake` simula o backend. Os endpoints reais do login unificado ainda não estão definidos.
- `ContaLembradaStorage` grava só nome e documento. O atalho "conta lembrada" aparece a partir do segundo acesso de quem marcou "Lembrar este dispositivo".
- Certificado digital e gov.br só mostram o aviso de redirecionamento, como no protótipo.
- O brasão vem de `Municipio.brasaoUrl`. Sem URL, usa o brasão de exemplo dos assets.
- "Recuperar senha" é inline, porque o Design System não usa janela modal (o protótipo foi corrigido da mesma forma).
- Cores conforme o Design System 2.1: todo texto com contraste mínimo de 4,5:1. Hover em verde `#75C566` com texto escuro, texto branco sobre verde só em `#01814E`, texto vermelho em `#B91C1C`.
