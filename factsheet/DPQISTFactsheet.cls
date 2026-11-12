%%% =========================================================================
%%  DPQISTfactsheet.cls
%%  Classe LaTeX para Factsheets — DPQ / IST
%%  Adaptada de DPQISTreport.cls (v1.2, Outubro 2026)
%%  Versão 1.2 (Novembro 2026)
%%% =========================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{DPQISTfactsheet}[2026/11/12 DPQ IST Factsheet Class v1.2]

\RequirePackage{iftex}
\RequirePackage{etoolbox}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt]{article}

%----------------------------------------------------------------------------------------
%	COMANDOS PERSONALIZADOS
%----------------------------------------------------------------------------------------

\newcommand{\factsheettitle}{}
\newcommand{\factsheetsubtitle}{}
\newcommand{\factsheetdate}{}
\newcommand{\rightheadercontent}{}
\newcommand{\docversion}{}
\newcommand{\factsheetcode}{} % código interno, ex.: FS-DPQ-001

\newcommand{\setfactsheettitle}[1]{\renewcommand{\factsheettitle}{#1}}
\newcommand{\setfactsheetsubtitle}[1]{\renewcommand{\factsheetsubtitle}{#1}}
\newcommand{\setfactsheetdate}[1]{\renewcommand{\factsheetdate}{#1}}
\newcommand{\setrightheadercontent}[1]{\renewcommand{\rightheadercontent}{#1}}
\newcommand{\setdocversion}[1]{\renewcommand{\docversion}{#1}}
\newcommand{\setfactsheetcode}[1]{\renewcommand{\factsheetcode}{#1}}

% Logótipo IST no cabeçalho por defeito
\setrightheadercontent{\includegraphics[height=0.85cm]{Tecnico_ID_Principal_RBG-COR.png}}

%----------------------------------------------------------------------------------------
%	LINGUAGEM
%----------------------------------------------------------------------------------------

\RequirePackage{polyglossia}
\setdefaultlanguage{portuguese}
\setotherlanguage{english}

%----------------------------------------------------------------------------------------
%	ENCODING / GRÁFICOS / LAYOUT
%----------------------------------------------------------------------------------------

\ifPDFTeX
  \usepackage[utf8]{inputenc}
\fi

\usepackage{graphicx}
\graphicspath{{img/}{Images/}{./}}

\RequirePackage{pdflscape} % páginas landscape

\setlength{\parindent}{0pt}
\setlength{\parskip}{8pt}

\usepackage{lastpage}

%----------------------------------------------------------------------------------------
%	TIPOGRAFIA
%----------------------------------------------------------------------------------------

\ifPDFTeX
  \usepackage[T1]{fontenc}
\fi

\usepackage{fontspec}
\usepackage[default]{sourcesans}

\newcommand{\textsb}[1]{{\fontseries{sb}\selectfont #1}}

%----------------------------------------------------------------------------------------
%	CORES
%----------------------------------------------------------------------------------------

\RequirePackage[usenames, svgnames, table]{xcolor}

\definecolor{dpqtext}{HTML}{46555F}       % Cor do texto
\definecolor{dpqheader}{HTML}{009DE0}     % IST Blue — títulos
\definecolor{dpqtableheader}{HTML}{46555F}     % IST Ardósia — cabeçalhos de tabela
\definecolor{istblue}{HTML}{009DE0}
\definecolor{istgray}{HTML}{D2D3D4}
\definecolor{istdarkgray}{HTML}{46555F}
\definecolor{mylinkcolor}{HTML}{009DE0}
\definecolor{dpqtablerow}{HTML}{D2D3D4}   % Cinzento das linhas alternadas (relatórios)
\definecolor{dpqrowlight}{HTML}{EBEDEF}   % Variante mais clara para tabelas numéricas
\definecolor{istlightblue}{HTML}{DAF1FA}  % Azul IST muito claro (fallback sem transparência)
\colorlet{kmbg}{istblue!10!white}

\color{dpqtext}

%----------------------------------------------------------------------------------------
%	MARGENS
%----------------------------------------------------------------------------------------

\usepackage[
  top=2.5cm,
  bottom=2.2cm,
  left=1.8cm,
  right=1.8cm,
  footskip=1.2cm,
  headsep=0.8cm,
  headheight=1.2cm,
]{geometry}

%----------------------------------------------------------------------------------------
%	CABEÇALHO E RODAPÉ
%----------------------------------------------------------------------------------------

\usepackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0.5pt}

\fancyhf{}
\fancyhead[L]{\textsb{\factsheettitle}}
\fancyhead[C]{}
\fancyhead[R]{\rightheadercontent}

\fancyfoot[L]{\factsheetcode}
\fancyfoot[C]{Página \thepage\ de \pageref{LastPage}}
\fancyfoot[R]{\factsheetdate}

%----------------------------------------------------------------------------------------
%	TABELAS — pacotes e tipos de coluna
%----------------------------------------------------------------------------------------

\usepackage{booktabs}
\usepackage{array}
\usepackage{tabularx}
\usepackage{multirow}
\usepackage{adjustbox}

\renewcommand{\arraystretch}{1.3}

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
% Coluna S numerada alinhada pela vírgula decimal (siunitx)

\newcommand{\thead}[1]{\textbf{#1}}

% Célula de cabeçalho de tabela
% Uso: \theadS{Nome da coluna} em cada célula da primeira linha
\newcommand{\theadS}[1]{\cellcolor{dpqtableheader}\color{white}\textbf{#1}}

%----------------------------------------------------------------------------------------
%	SIUNITX (decimal português, agrupamento de milhares)
%----------------------------------------------------------------------------------------

\RequirePackage{siunitx}
\sisetup{
  output-decimal-marker = {,},
  group-digits = true,
  group-separator = {\,},
  group-minimum-digits = 4,
  detect-weight = true,
  detect-family = true
}

%----------------------------------------------------------------------------------------
%	TCOLORBOX — indicadores-chave e caixas institucionais
%----------------------------------------------------------------------------------------

\RequirePackage[most]{tcolorbox}
\RequirePackage{fontawesome5}

%----------------------------------------------------------------------
% INDICADORES-CHAVE (keymetricbox)
%
% IMPORTANTE: requer DUAS compilações. Na 1.ª passagem o tcolorbox
% mede a altura natural de cada caixa e guarda-a no .aux; na 2.ª
% passagem aplica a altura máxima a todas.
%
% Para linhas de métricas independentes (alturas distintas entre
% grelhas), use o argumento opcional:
%   \begin{keymetricbox}[kmg=B] ... \end{keymetricbox}
% Caixas com letras de grupo diferentes são igualadas apenas entre si.
%
% Opções de afinamento rápido:
%   \begin{keymetricbox}[arc=4pt]          — cantos mais arredondados
%   \begin{keymetricbox}[opacityback=0.05]  — fundo ainda mais ténue
%   \begin{keymetricbox}[colback=istlightblue, no opacity] — fundo sólido
%----------------------------------------------------------------------

\tcbset{
  keymetric/.style={
    enhanced,
    colback=kmbg,
    colframe=dpqheader,
    boxrule=0.6pt,
    arc=2pt,                    % cantos ligeiramente arredondados
    left=4mm, right=4mm, top=3mm, bottom=3mm,
    before skip=8pt, after skip=8pt,
    valign=top,                 % conteúdo alinhado ao topo na caixa esticada
    equal height group=kmetric, % altura uniforme dentro do grupo
  },
  keymetricB/.style={
    keymetric,
    equal height group=kmetricB,
  },
}

% Uso:
% \begin{keymetricbox}
%   \keylabel{Indicador} \keyvalue{\SI{42,3}{\percent}} \keynote{Nota}
% \end{keymetricbox}
\newenvironment{keymetricbox}[1][A]{%
  \ifstrequal{#1}{A}{%
    \begin{tcolorbox}[keymetric]%
  }{%
    \begin{tcolorbox}[keymetricB]%
  }%
}{%
  \end{tcolorbox}
}

\newcommand{\keylabel}[1]{{\small\color{istdarkgray}\textsb{#1}}\par\vspace{1mm}}
\newcommand{\keyvalue}[1]{{\fontsize{20pt}{22pt}\selectfont\bfseries\color{dpqheader}#1}\par}
\newcommand{\keynote}[1]{{\footnotesize\color{istdarkgray}#1}}

%----------------------------------------------------------------------
% CAIXAS INSTITUCIONAIS
%----------------------------------------------------------------------

\tcbset{
  istbox/.style={
    enhanced,
    colback=white,
    colframe=istdarkgray,
    boxrule=0.8pt,
    arc=2pt,                    % cantos ligeiramente arredondados
    left=6mm, right=6mm, top=4mm, bottom=4mm,
    before skip=10pt, after skip=10pt,
    % Header de largura total: fundo cinza-escuro, texto branco
    colbacktitle=istdarkgray,
    coltitle=white,
    fonttitle=\bfseries,
    titlerule=0pt,
    toptitle=2mm, bottomtitle=2mm,
  }
}

\newtcolorbox{istcaixa}[3][]{%
  istbox,
  title={\ifblank{#2}{}{#2\;\ }\textbf{#3}},
  #1
}

\newcommand{\blk}[1]{\textbf{\color{istblue}{#1}}}

%----------------------------------------------------------------------------------------
%	TÍTULOS (sem numeração por defeito)
%----------------------------------------------------------------------------------------

\setcounter{secnumdepth}{0}

\usepackage{titlesec}
\titleformat
  {\section}
  [block]
  {\raggedright\LARGE\bfseries\color{dpqheader}}
  {}
  {0pt}
  {}
\titlespacing*{\section}{0pt}{\baselineskip}{4pt}

\titleformat
  {\subsection}
  [block]
  {\raggedright\large\bfseries\color{dpqheader}}
  {}
  {0pt}
  {}
\titlespacing*{\subsection}{0pt}{0.75\baselineskip}{4pt}

%----------------------------------------------------------------------------------------
%	CAPTIONS / LISTAS / RODAPÉS
%----------------------------------------------------------------------------------------

\usepackage{caption}
\captionsetup{skip=6pt}
\captionsetup{font={bf,small}}
\captionsetup{justification=raggedright, singlelinecheck=false}

\usepackage{enumitem}
\setlist{itemsep=0pt, topsep=0pt}
\renewcommand{\labelenumi}{\arabic{enumi}.}
\renewcommand{\labelitemi}{\Large\raisebox{-1.5pt}{\textbullet}}
\renewcommand{\labelitemii}{\Large\raisebox{-1.5pt}{--}}

\usepackage[bottom, hang]{footmisc}
\setlength{\footnotemargin}{10pt}

\AtBeginEnvironment{quote}{\itshape\rmfamily}

%----------------------------------------------------------------------------------------
%	TIKZ
%----------------------------------------------------------------------------------------

\RequirePackage{tikz}
\usetikzlibrary{shapes.geometric, arrows.meta, positioning, fit, backgrounds}

%----------------------------------------------------------------------------------------
%	LINKS (no fim)
%----------------------------------------------------------------------------------------

\usepackage{hyperref}
\hypersetup{
  colorlinks=true,
  urlcolor=mylinkcolor,
  linkcolor=black,
  citecolor=black,
  pdftitle={\factsheettitle},
  pdfauthor={Direção de Planeamento e Qualidade — IST},
  pdfsubject={Factsheet},
  bookmarksnumbered=false
}

\endinput
