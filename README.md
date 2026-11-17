# Coplan Design System 2.1

Padrão visual e de interação dos sistemas da Coplan, extraído do novo Central.

- Design system: https://diegoloureiro84.github.io/coplan-design-system/
- Protótipo navegável (fonte da verdade): https://diegoloureiro84.github.io/prototipo-central/
- Kit Flutter: https://diegoloureiro84.github.io/coplan-design-system/#flutter (código na pasta `flutter/` deste repositório)

Os componentes da página são os componentes reais do protótipo, renderizados com o mesmo CSS. Quando houver divergência, o protótipo vale.

## Princípios

| Princípio | Na prática |
|---|---|
| Nada inventado | Todo rótulo, campo e valor existe no cadastro do sistema atual. Lacuna de dado vira pendência de produto. |
| Legível para todos | Todo texto com contraste mínimo de 4,5:1, verificado por varredura automática. |
| Cor tem significado | Azul conduz, verde confirma e seleciona, vermelho bloqueia. |
| Sem janelas modais | Confirmações e avisos ficam no próprio fluxo. |
| Um padrão por problema | Um seletor, um botão de limpar filtro, uma paginação, um estilo de item de menu. |
| Ação imediata | Filtros aplicam ao mudar, sem botão Aplicar. |
| O sistema se localiza sozinho | Breadcrumb, título da aba, unidade gestora e exercício sempre visíveis. |

## Regras obrigatórias

1. Vermelho só para o que bloqueia. `#F44336` em borda, barra e ícone; `#B91C1C` em texto e em fundo com texto branco. Alerta que não bloqueia usa a família âmbar.
2. O texto nunca assume a cor do componente.
3. Nenhuma janela modal. Confirmação é inline; fluxos secundários aparecem no lugar do conteúdo; ação reversível, como Sair, não pede confirmação.
4. Pílulas de classificação são cinza neutro. Só status tem cor.
5. Dentro dos sistemas não há título nem subtítulo de página, apenas breadcrumb.
6. Menu lateral aberto sem ícones e com um único estilo de texto (15px, peso 400).
7. Selecionado: verde claro `#E6F8F0` com texto escuro e marca. Hover: verde `#75C566` com texto escuro `#0A1A2E`. Texto branco sobre verde só no `#01814E`.
8. Todo seletor usa o seletor padrão; acima de 7 opções, com busca.
9. "Limpar filtro" é sempre o mesmo botão, no fim da linha de filtros, visível só com filtro ativo.
10. Dados exibidos exatamente como estão no cadastro do Central.
11. Nomenclatura: NAD e natureza da despesa.
12. Toda tela tem deep link. Título da aba: `Tela · Sistema · Coplan`.
13. Todo texto passa de 4,5:1 de contraste (3:1 a partir de 24px, ou 18,7px em negrito).

## Tokens

```css
:root{
  --primary:#1F4993; --accent:#75C566; --dark-green:#01814E; --blue:#032861;
  --bg:#F8F9FE; --card:#FFFFFF; --fg:#0A1A2E; --black:#01060B;
  --border:#E0E0E1; --secondary:#F5F5F6; --secondary-fg:#57575A;
  --muted:#E6E6E7; --muted-fg:#6B6B6E; --inactive:#6B6B6E;
  --readonly:#EEF1FA; --light-green:#E6F8F0; --row-hover:#EAF7EE;
  --destructive:#F44336; --danger-strong:#B91C1C; --destructive-bg:#FEF2F2; --destructive-border:#FECACA;
  --warn-bg:#FEF3C7; --warn-fg:#78350F; --pend:#FCD34D; --star:#F5B301;
  --r-lg:12.8px; --r-md:10.8px; --r-sm:8.8px;
  --header:65px; --sidebar:280px; --sidebar-c:60px;
  --font:'Exo 2',system-ui,sans-serif;
}
```

Equivalentes em Flutter e Tailwind estão na seção Tokens da página.

## Tipografia

Exo 2, embutida no arquivo. Ícones Lucide.

| Uso | Tamanho / peso |
|---|---|
| Título do login | 36 / 800 |
| Título de seção do Início | 32 / 700 |
| Valor de indicador | 24 / 700 |
| Título de seção do formulário | 20 / 600 |
| Item de menu, valor de campo | 15 / 400 |
| Rótulo de campo, cabeçalho de tabela | 14 / 600 |
| Botão | 14 / 500 |
| Célula de tabela | 14 / 400 |
| Pílula | 12 / 600 |

## Conteúdo da página

- Fundamentos: cores, tipografia, espaçamento, raio, sombra, ícones, marca.
- Estrutura: cabeçalho, unidade gestora e exercício, troca de sistema, menu lateral aberto, recolhido e flutuante.
- Componentes: botões, limpar filtro, campos, switch como campo, número com reservas, seletor padrão, pílulas, prioridade, avisos, toasts, confirmação inline, abas, estado vazio.
- Padrões de tela: lista, indicadores com painel de foco, formulário com resumo, cadastro com hierarquia, detalhe com linha do tempo e extrato, escolha de sistema e início.
- Estados: toast (8 s), carregando, erro de rede, desabilitado e somente leitura.
- Kit Flutter para baixar, com a tela de login modelo.
- Telas de referência com deep link para o protótipo.

## Descontinuado

Fonte Coplan Display, janela modal de confirmação, laranja e tons fora da paleta, chips pastel, ícone ☰ e ícones no menu aberto, seletor de competência, cabeçalho de tabela em caixa alta, título de página dentro dos sistemas, fundo `#F5F7FC`, paginação ativa azul, ponto de notificação vermelho, termo "requisição", janelas modais (Sair, Recuperar senha, Gerar cópia), texto branco sobre `#75C566`, texto em `#8A8A8D`, vermelho base `#EF4444` (agora `#F44336`, o dos portais), aviso em `#B45309`, célula de tabela em 13,5px.

## Contato

Mantido por Diego Loureiro, Gerente de Inovação. diego.loureiro@coplan.srv.br
