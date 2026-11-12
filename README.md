# Modelos LaTeX DPQ/IST

Modelos LaTeX construidos para a Direção de Planeamento e Qualidade (DPQ) do Instituto Superior Técnico, para produção de **relatórios** e **factsheets** com a identidade visual padronizada.

---

## Conteúdo

| Ficheiro | Descrição |
|---|---|
| `DPQISTreport.cls` | Classe LaTeX para relatórios DPQ/IST |
| `DPQISTReport_template.tex` | Modelo de relatório (capa, contracapa, registo de alterações, exemplos) |
| `DPQISTfactsheet.cls` | Classe LaTeX para factsheets DPQ/IST |
| `DPQISTfactsheet_template.tex` | Modelo de factsheet (1–2 páginas, sem capa) |

---

## Requisitos

- **Compilador:** XeLaTeX ou LuaLaTeX (obrigatório — as classes usam `fontspec` e `polyglossia`)
- **Bibliografia:** BibLaTeX com backend `biber`
- **Imagens:** logótipo `Tecnico_ID_Principal_RBG-COR.png` em `img/` (ou ajustar `\graphicspath`)

---

## Relatório (`DPQISTreport`)

Documento longo com capa, ficha técnica, registo de elaboração/aprovação, mapa de alterações e índice.

### Compilação

```bash
xelatex relatorio.tex
xelatex relatorio.tex        # 2.ª passagem para índice e referências
biber relatorio              # se houver bibliografia
xelatex relatorio.tex
```

### Definições no preâmbulo

```latex
\setreporttitle{Título do Documento}
\setreportsubtitle{Subtítulo do Documento}
\setreportdate{\today}
\setdocversion{v1.00}
```

### Elementos principais

- **Tabelas** — `tabularx` com tipos de coluna `L{}`, `C{}`, `R{}` e linhas alternadas automáticas (branco / `#D2D3D4`); `\thead{}` para cabeçalhos
- **Números** — colunas `S` do `siunitx` (decimal com vírgula, agrupamento de milhares)
- **Caixas institucionais** — ambientes `istobj` (Missão) e `istprin` (Princípios orientadores)
- **Notas laterais** — `\sidenote{}`, `\nonumsidenote{}`
- **Citações laterais** — `\sidecite{chave}` / `\fullsidecite{chave}`
- **Secções sem numeração** — opção `unnumberedsections`: `\documentclass[unnumberedsections]{DPQISTreport}`

---

## Factsheet (`DPQISTfactsheet`)

Documento curto, sem capa nem registo de alterações, com suporte para páginas landscape e tabelas numéricas grandes.

### Compilação

```bash
xelatex factsheet.tex
xelatex factsheet.tex        # 2.ª passagem — obrigatória (alturas das métricas)
```

### Definições no preâmbulo

```latex
\setfactsheettitle{Título}
\setfactsheetsubtitle{Subtítulo}
\setfactsheetcode{FS-DPQ-001}     % código interno (rodapé)
\setfactsheetdate{\today}
\setdocversion{v1.00}
```

### Indicadores-chave (keymetricbox)

Caixas de destaque com **altura uniforme**:

```latex
\begin{tabularx}{\textwidth}{XXX}
    \begin{keymetricbox}
        \keylabel{Indicador 1}
        \keyvalue{\SI{42,3}{\percent}}
        \keynote{Variação de +2,1 p.p. face a 2025}
    \end{keymetricbox}
    &
    \begin{keymetricbox} ... \end{keymetricbox}
    &
    \begin{keymetricbox} ... \end{keymetricbox}
\end{tabularx}
```

Grupos independentes (alturas igualadas só dentro do grupo): `\begin{keymetricbox}[B]`.

### Caixas institucionais (istcaixa)

Ícone [fontawsome](https://fontawesome.com/) e título definidos no documento:

```latex
\begin{istcaixa}{\faBullseye}{Missão}
Conteúdo da caixa...
\end{istcaixa}
```

- `{}` como primeiro argumento → caixa sem ícone
- Opções tcolorbox adicionais: `\begin{istcaixa}[colframe=dpqheader]{\faChartLine}{Indicadores}`

### Tabelas numéricas

- `\theadS{...}` — célula de cabeçalho com fundo azul IST e texto branco
- `\rowcolors{2}{dpqrowlight}{white}` — linhas alternadas (variante clara para grades grandes)
- Colunas `S[table-format=X.Y]` — alinhamento pela vírgula decimal
- `\resizebox{\linewidth}{!}{...}` — compressão automática em tabelas largas
- `\addlinespace` + `\textbf{}` — linha de total destacada

### Páginas landscape

```latex
\begin{landscape}
... tabela grande ...
\end{landscape}
```

O cabeçalho e rodapé acompanham a rotação.

---

## Créditos e licença

Classe original adaptada do *Sullivan Business Report* (LaTeXTemplates.com, autor: Vel), com licença **CC BY-NC-SA 4.0** — https://creativecommons.org/licenses/by-nc-sa/4.0/

Adaptação e manutenção: João Patrício.
