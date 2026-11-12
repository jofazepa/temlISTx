%%% =========================================================================
%%  DPQISTfactsheet.cls
%%  Classe LaTeX para Factsheets — DPQ / IST
%%  Adaptada de DPQISTreport.cls (v1.2, Outubro 2026)
%%  Versão 1.0 (Novembro 2026)
%%
%%  Características:
%%    - Sem capa nem contracapa (documento curto, 1–2 páginas)
%%    - Páginas em portrait ou landscape (\begin{landscape})
%%    - Cabeçalho/rodapé idênticos ao modelo de relatórios
%%    - Cores e tipografia DPQ/IST (Source Sans 3, IST Blue)
%%    - Números decimais com vírgula (siunitx)
%%    - Caixas de indicadores-chave (keymetricbox)
%%    - Tabelas: linhas alternadas + cabeçalho azul com texto branco
%%% =========================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{DPQISTfactsheet}[2026/11/12 DPQ IST Factsheet Class v1.0]

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
\definecolor{dpqheader}{HTML}{009DE0}     % IST Blue — títulos e cabeçalhos de tabela
\definecolor{istblue}{HTML}{009DE0}
\definecolor{istgray}{HTML}{D2D3D4}
\definecolor{istdarkgray}{HTML}{46555F}
\definecolor{mylinkcolor}{HTML}{009DE0}
\definecolor{dpqtablerow}{HTML}{D2D3D4}   % Cinzento das linhas alternadas (relatórios)
\definecolor{dpqrowlight}{HTML}{EBEDEF}   % Variante mais clara para tabelas numéricas

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

% Célula de cabeçalho de tabela: fundo azul IST, texto branco
% Uso: \theadS{Nome da coluna} em cada célula da primeira linha
\newcommand{\theadS}[1]{\cellcolor{dpqheader}\color{white}\textbf{#1}}

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

\tcbset{
  keymetric/.style={
    enhanced,
    colback=white,
    colframe=dpqheader,
    boxrule=0.6pt,
    arc=0pt,
    left=4mm, right=4mm, top=3mm, bottom=3mm,
    before skip=8pt, after skip=8pt,
  }
}

% Uso:
% \begin{keymetricbox}
%   \keylabel{Indicador} \keyvalue{\SI{42,3}{\percent}} \keynote{Nota}
% \end{keymetricbox}
% Disponha várias em linha com tabularx{...}{XXX}.
\newenvironment{keymetricbox}[1][]{
  \begin{tcolorbox}[keymetric, valign=top, #1]
}{%
  \end{tcolorbox}
}

\newcommand{\keylabel}[1]{{\small\color{istdarkgray}\textsb{#1}}\par\vspace{1mm}}
\newcommand{\keyvalue}[1]{{\fontsize{20pt}{22pt}\selectfont\bfseries\color{dpqheader}#1}\par}
\newcommand{\keynote}[1]{{\footnotesize\color{istdarkgray}#1}}

\tcbset{
  istbox/.style={
    enhanced,
    colback=white,
    colframe=istdarkgray,
    boxrule=0.8pt,
    left=6mm, right=6mm, top=4mm, bottom=4mm,
    before skip=10pt, after skip=10pt,
  }
}

\newtcolorbox{istobj}[1][]{
  istbox,
  title={\faBullseye\ \textbf{Missão}},
  #1
}

\newtcolorbox{istprin}[1][]{
  istbox,
  title={\faBalanceScale\ \textbf{Princípios orientadores}},
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
