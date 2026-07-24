# Coplan — Design System (Referência de Implementação)

> Este documento é a fonte de verdade de design da plataforma Coplan. Qualquer código de interface gerado para produtos Coplan (web ou mobile) deve seguir exatamente os valores e padrões abaixo. Não invente cores, espaçamentos, tipografia ou variações de componente que não estejam aqui. Onde houver dúvida, siga o token mais próximo já definido em vez de criar um novo.

Mantido por Diego Loureiro, Líder de Inovação, Coplan Tecnologia. Contato: diego.loureiro@coplan.srv.br

---

## 1. Cores

Paleta única em toda a plataforma (Administrativo, Central, Contábil, Educação, Ouvidoria, Planejamento, Portal da Transparência, RH, Tributário, Gestão de Protocolos).

| Token | Hex | Uso |
|---|---|---|
| `primary` | `#1F4993` | Marca, sidebar, links, títulos de página, texto de destaque |
| `accent` | `#75C566` | Hover e estado ativo de navegação/seleção, botão primário de ação positiva |
| `background` | `#F5F7FC` | Fundo geral da página |
| `card` | `#FFFFFF` | Superfície de card, modais, dropdowns |
| `foreground` | `#0A1A2E` | Texto principal |
| `border` / `input` | `#E0E0E1` | Bordas, divisores, contorno de input |
| `secondary` | `#F5F5F6` | Fundo secundário sutil |
| `muted` | `#E6E6E7` | Fundo neutro (chips, badges) |
| `muted-foreground` | `#8A8A8D` | Texto secundário/legenda |
| `destructive` | `#EF4444` | Erro, ação destrutiva (cor funcional, não é da identidade de marca) |
| chart 1–4 | `#F97316` `#14B8A6` `#1E3A5F` `#FCD34D` | Gráficos e visualizações |

Cores oficiais adicionais da marca (Manual de Marca Coplan), disponíveis mas sem aplicação obrigatória em componente específico:
- Azul marinho `#01203F`
- Verde escuro `#01814E`
- Roxo `#482E99` (representa "leveza e proximidade"; sem uso funcional definido ainda, não forçar aplicação sem necessidade real)
- Verde-claro/creme `#F6F8ED`

**Modo escuro:** fora de escopo desta versão. Não existe decisão aprovada de dark mode. Não gerar variante escura por conta própria.

---

## 2. Tipografia

Fonte única: **Exo 2** (Google Fonts), pesos 300–800. Escala em rem, base 16px.

| Token | rem | px | Uso |
|---|---|---|---|
| Display/H1 | 2.25rem | 36px | Título principal (peso 800) |
| H2 | 1.875rem | 30px | Título de seção (peso 700) |
| H3 | 1.5rem | 24px | Subtítulo (peso 600) |
| H4 | 1.25rem | 20px | Cabeçalho de card (peso 600) |
| H5/AppBar | 1.125rem | 18px | Título de barra superior (peso 600) |
| Body Large | 1rem | 16px | Texto padrão, parágrafos, formulários |
| Body Medium | 0.875rem | 14px | Tabela, botão, item de lista |
| Body Small | 0.75rem | 12px | Legenda, texto auxiliar |
| Label | 0.875rem | 14px | Rótulo de campo (peso 500) |

```css
font-family: { sans: ['"Exo 2"', 'ui-sans-serif', 'system-ui'] }
```

---

## 3. Espaçamento, radius e breakpoints

| Token | Valor | Uso |
|---|---|---|
| radius-lg | 12.8px | Botões, cards, inputs, modais (padrão) |
| radius-md | 10.8px | Botões secundários/pequenos |
| radius-sm | 8.8px | Chips, badges |

Elevação: **0 por padrão em tudo** (cards, botões). Contraste vem da borda de 1px, nunca de sombra. Modais são a única exceção (sombra suave).

| Breakpoint | Largura |
|---|---|
| mobile | < 600px |
| tablet | 600–899px |
| desktop | 900–1199px |
| large desktop | 1200–1599px |
| tv/wide | ≥ 1920px |

---

## 4. Componentes

### 4.1 Botões

- **Primário**: fundo `primary` ou `accent` conforme contexto, texto branco, altura 40px, radius 12.8px, fonte 14px/500. Hover escurece 15%. Disabled: opacidade 50%.
- **Sempre com ícone junto do label.** Nunca só texto (confirmado no código real: `PrimaryButtonComponent` sempre recebe `icon:`).
- **Outline/Cancelar**: fundo transparente, borda 1px cinza (`border`), texto cinza (`#57575A`). Nunca vermelho.
- **Fantasma (ghost)**: usado em links de ação leve ("Voltar ao Início", "Esqueceu senha", "Primeiro Acesso"). Sem borda, texto `#57575A`, transparente até o hover; hover preenche `accent` sólido, texto branco, leve zoom (scale 1.05).
- **Ícone de exclusão isolado**: cinza por padrão, preenche `destructive` sólido no hover, ícone branco. Sem confirmação prévia quando a ação é reversível (ex: remover linha antes de salvar).

### 4.2 Campos de formulário

- **Input editável**: borda 1px `border`; foco: borda `accent` 2px; erro: borda `destructive`. Suporta prefixo/sufixo com ícone.
- **Campo somente leitura ("formulário sem interação")**: mesmo layout do input (label acima, caixa abaixo), mas a caixa é uma `div`, não um `input`. Fundo `#EEF1FA` (lilás claro), texto em negrito, radius 12.8px, sem estado de foco. Usado em telas de consulta de cadastro (servidor, contribuinte).
- **Linha expansível dentro de formulário** (dependente, anexo): mesmo fundo lilás, clique expande detalhe inline (accordion).

### 4.3 Cards

Fundo `card`, borda 1px `border`, radius 12.8px, sem elevação. Padding adaptativo (8px abaixo de 350px, 16px padrão).

### 4.4 Abas (tabs)

Segmentos de largura igual (`flex:1` cada), sem trilha visível por trás. Aba ativa preenche o segmento inteiro em `accent` sólido, texto branco, radius pill (999px). Abas ficam **fora** do card de conteúdo, nunca dentro dele.

### 4.5 Tabelas

- Header: fundo branco (nunca a cor de fundo da página), 48px de altura, texto uppercase 11.5px cor `muted-foreground`.
- Linha: 56px (100px em modo formulário). Hover: verde suave (`rgba(117,197,102,.1)`), nunca o mesmo tom sólido do hover de navegação.
- Seleção de linha: fundo azul suave (`rgba(31,73,146,.1)` aprox.), checkbox por linha, barra de ações em massa aparece animada ao selecionar.
- Linha expansível: clique expande detalhe sem navegar (contratos, ATAs, protocolos).

**Paginação, duas variantes conforme contexto:**
1. **Simples** (poucas páginas, telas de listagem direta): botões de texto "« Primeira", "‹ Anterior", "Próxima ›", "Última »". Primeira/Anterior em outline; Próxima/Última sólidos na cor primária. Confirmado no código real (`PaginationControlsComponent`).
2. **Longa** (listas extensas): números de página clicáveis + seletor de "registros por página" (10/25/50). Página ativa: fundo cinza claro `rgba(245,245,246,.75)`, borda 1px `border`, **texto escuro, nunca branco, nunca fundo azul**. Confirmado no código real (`HomePage.dart`, Papel Zero). Botões de seta (primeira/anterior/próxima/última): fundo branco, borda, radius 10.

### 4.6 Ícones

Todos os ícones da plataforma são **[Lucide](https://lucide.dev/)**. Nunca redesenhar um ícone; usar o nome exato e importar de `lucide-react` (ou pacote Lucide equivalente na stack usada).

Convenção de nomenclatura: arquivos Flutter usam `snake_case` (`dollar_sign.svg`); o nome Lucide oficial usa `kebab-case` (`dollar-sign`). É o mesmo ícone.

**Menu principal (referência exata, confirmada no código-fonte):**

| Item | Ícone Lucide |
|---|---|
| Início | `house` |
| Meus Dados | `user` |
| Financeiro | `dollar-sign` |
| Férias | `calendar-check` |
| Licença Prêmio | `award` |
| Ponto | `clock` |
| Afastamento | `user-x` |
| Atestado | `clipboard-paste` |
| Diárias | `car` |
| Adiantamento | `briefcase` |

**Ícones de ação comuns:** `search`, `bell`, `x`, `panel-left`, `pencil`, `trash-2`, `upload`, `plus`, `eye` / `eye-off`, `chevron-left` / `chevron-right`, `chevrons-left` / `chevrons-right`.

**Ícones de feedback:** `check-circle` (sucesso), `circle-alert` (erro), `info` (informativo).

### 4.7 Navegação / Sidebar

- Largura expandida: 280px. Largura recolhida: 60px (ícone apenas, com tooltip mostrando o label ao passar o mouse).
- Transição: 360ms, `cubic-bezier(.65,0,.35,1)`.
- Fundo: branco (`card`), borda direita 1px, sombra sutil (`2px 0 4px rgba(0,0,0,.05)`).
- Item ativo/hover: fundo `accent` sólido, texto e ícone brancos, radius 8px. **Hover reage de verdade ao mouse**, não só ao item marcado como ativo.
- Cabeçalho fixo acima do conteúdo: logo + nome do produto (encolhe com a sidebar), busca com atalho `⌘K`, seletor de unidade gestora/competência, sino de ocorrências, avatar de usuário, seletor de sistemas.
- Rodapé institucional fixo: copyright + links (Política de Privacidade, Termos de Uso, Sobre) + selos de loja de app. Padrão em todos os produtos, mesmo os sem app mobile.

### 4.8 Feedback & Status

**Chips de status** (dados de negócio, ex: nota fiscal, guia):
- Ativo/Em dia: fundo `#E6F8F0`, texto `#01814E`.
- Pendente: fundo `#FFF3D6`, texto `#8A6100`.
- Vencido/erro: fundo `#FEE2E2`, texto `#B91C1C`.

**Status de fluxo de assinatura/autorização** (contexto diferente do chip de negócio acima, não confundir):
- Pendente: fundo branco, borda 1px `border`, texto `muted-foreground`, ícone de relógio. **Nunca vermelho.**
- Assinado/Aprovado: fundo `accent` sólido, texto branco, ícone de check.

**Toast**: canto superior direito, slide da direita + fade, 3 tipos: `success` (`accent`), `error` (`destructive`), `info` (`primary`). Título 16px negrito branco, mensagem 13px/600 branca, botão fechar (✕) branco. Auto-dispensa após alguns segundos.

### 4.9 Confirmação (Cancelar/Confirmar)

Modal usado antes de ação destrutiva/irreversível. Overlay preto 50% cobrindo a tela. Card max-width 420px, radius 12px. Ícone opcional em círculo (fundo da cor a 10% de opacidade). Título 20px negrito, mensagem 15px cinza. Botão Cancelar: outline cinza, 100px. Botão Confirmar: `accent` sólido, 100px.

### 4.10 Componentes de domínio (fora do escopo visual)

Estes carregam regra de negócio específica e precisam de especificação funcional própria, não apenas visual:

| Módulo | Componentes |
|---|---|
| Contratos | detalhe, itens, NADs, anexos, status, lista expansível |
| ATA de Registro de Preço | detalhe, itens, resumo, lista expansível |
| Certidões/Tributário | geração de certidão, detalhe, lista, perfil do contribuinte |
| NFS-e/Débitos | detalhe de nota, débitos em aberto, histórico de pagamento |
| RH/Ponto | registro de ponto, ajuste (com accordion de batidas + botão de exclusão por linha + aviso de "número de registros ímpar"), período aquisitivo, diárias, afastamento |
| Protocolo/Orçamento | nova apresentação, resposta de cotação, filtro de documento |

---

## 5. Padrões de tela

### 5.1 Login

Cabeçalho de página (título "Acesso ao Portal" + subtítulo + botão fantasma "Voltar") acima de card central: identidade do sistema (foto/nome), campo CPF, campo Senha (com alternância de visibilidade), checkbox "Lembrar-me" + link fantasma "Esqueceu seu Login e Senha?", botão primário "Continuar", botão fantasma "Primeiro Acesso?".

### 5.2 Recuperar senha / Primeiro acesso

Fluxo idêntico de 5 etapas, em modal com botão de fechar: CPF/CNPJ → canal de envio do código → validar código → definir senha → sucesso. "Primeiro acesso" reaproveita a mesma estrutura; não é cadastro livre, valida identidade de quem já existe na base.

### 5.3 Erro / Sessão expirada

Sessão inválida ou rota inexistente limpa a sessão local e redireciona ao login. Variante para usuário autenticado e não autenticado.

### 5.4 Padrão de página interna

Componente real: `HeaderPageComponent`, usado em todo módulo (Financeiro, Afastamento, Licença Prêmio, Diárias, Ponto, Configurações). Título grande cor `primary` à esquerda, subtítulo opcional cinza abaixo, botão fantasma "‹ Voltar ao Início" à direita. Conteúdo do módulo dentro de um card abaixo do cabeçalho.

### 5.5 Cabeçalho global (topbar)

Elementos, da esquerda para a direita:
1. Botão de recolher sidebar.
2. Busca (`⌘K`), abre painel listando/filtrando as seções disponíveis.
3. Seletor de Unidade Gestora + Competência (mês/ano): mostra brasão do município (ícone placeholder até receber o arquivo real de cada cliente) + nome em `primary` negrito + competência atual em texto secundário. Dropdown com seleção customizada (não usar `<select>` nativo do navegador, estilizar como lista de opções com hover `accent`).
4. Ícone de suporte via WhatsApp: forma oficial do ícone, mas nas cores do design system (nunca o verde oficial do WhatsApp), abre link de atendimento em nova aba.
5. Ícone ClienteMAIS: ícone de headset (suporte ao usuário), abre o portal de suporte em nova aba.
6. Sino de Ocorrências: painel com "Limpar tudo" no topo e dispensa individual (✕) por item. Conteúdo são interações pendentes vindas de outros módulos: fluxo de Empenho/Liquidação/Pagamento, Documentos para assinar, NAD para autorizar, Diárias e Adiantamentos, Férias e Ajuste de Ponto. Itens de decisão simples (NAD, Diárias, Férias) têm botões "Deferir"/"Indeferir" diretos no painel; itens que exigem abrir o documento (assinatura, fluxo completo) só têm "Ver no sistema". Todo item, com ou sem ação rápida, sempre oferece "Ver no sistema" para o usuário ver o contexto completo se quiser.
7. Avatar do usuário: ícone de pessoa (nunca vazio/genérico sem forma). Dropdown: Dados do Usuário, Alterar Senha, Últimas Atualizações, Sair (em vermelho, único item destrutivo do menu).
8. Seletor de Sistemas: ícone de menu (☰), lista os produtos da plataforma (Administrativo, Central, Contábil, Educação, Ouvidoria, Planejamento, Portal da Transparência, RH, Tributário, Gestão de Protocolos).

---

## 6. Tokens prontos para uso

```js
// tailwind.config.js
colors: {
  background: '#F5F7FC',
  foreground: '#0A1A2E',
  card: { DEFAULT: '#FFFFFF', foreground: '#0A1A2E' },
  primary: { DEFAULT: '#1F4993', foreground: '#FFFFFF' },
  secondary: { DEFAULT: '#F5F5F6', foreground: '#57575A' },
  muted: { DEFAULT: '#E6E6E7', foreground: '#8A8A8D' },
  accent: { DEFAULT: '#75C566', foreground: '#FFFFFF' },
  destructive: { DEFAULT: '#EF4444', foreground: '#FAFAFA' },
  border: '#E0E0E1',
  input: '#E0E0E1',
  ring: '#75C566',
  chart: { 1: '#F97316', 2: '#14B8A6', 3: '#1E3A5F', 4: '#FCD34D', 5: '#F97316' }
},
borderRadius: { lg: '12.8px', md: '10.8px', sm: '8.8px' },
fontFamily: { sans: ['"Exo 2"', 'ui-sans-serif', 'system-ui'] }
```

---

## 7. Regras diretas para geração de código

1. Sempre usar os tokens de cor listados acima pelo nome/hex exato. Nunca inventar uma cor nova, nem "aproximar" para um tom parecido.
2. Todo botão tem ícone junto do label. Nunca gerar botão só com texto.
3. Botão de cancelar é sempre cinza/outline. Nunca vermelho.
4. Elevação zero é o padrão. Não adicionar `box-shadow` decorativo em card, botão ou input sem necessidade (modais são a exceção).
5. Hover de navegação/seleção (sidebar, dropdown, seletor) é sempre `accent` sólido com texto branco. Hover de linha de tabela é sempre um verde suave translúcido, nunca o mesmo tom sólido.
6. Status "Pendente" (fluxo de assinatura/autorização) nunca é vermelho; é neutro (branco/borda/texto cinza) com ícone de relógio. Vermelho é reservado para erro/destrutivo.
7. Ícones são sempre Lucide, sempre com nome exato verificável em lucide.dev. Nunca redesenhar um ícone à mão.
8. Abas (tabs) ficam fora do card de conteúdo; o card contém só o conteúdo da aba selecionada.
9. Paginação: usar a variante "simples" (texto) para poucas páginas, "longa" (números) para listas extensas com seletor de registros por página. Página ativa nunca é azul sólido.
10. Campos somente leitura usam o fundo lilás claro (`#EEF1FA`), nunca o mesmo estilo de input editável com borda.
11. Modo escuro está fora de escopo. Não gerar variante dark por conta própria.
12. Regras de negócio de módulos específicos (contratos, NFS-e, ponto, RH) não estão definidas aqui; pedir especificação funcional antes de implementar tela desses módulos.
