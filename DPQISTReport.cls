%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DPQIST Report
% LaTeX Class — Adapted from Sullivan Business Report
% Version 1.1 (August 2026)
%
% Original class originates from:
% https://www.LaTeXTemplates.com
% Author: Vel (vel@latextemplates.com)
%
% Adapted for: Direção de Planeamento e Qualidade — IST
% Colour scheme updated per DPQ branding guidelines
%
% License:
% CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{DPQISTreport}[2026/08/26 DPQ IST Report Class v1.1 — Adapted from CSSullivanBusinessReport]

\RequirePackage{iftex}

\RequirePackage[strict]{changepage} % Required for adjustwidth environments (strict needed by sidenotes)

\usepackage{etoolbox} % Required for conditional logic and easily changing commands

\newtoggle{unnumberedsections} % Create toggle for a class option
\settoggle{unnumberedsections}{false} % Default value for the class option
\DeclareOption{unnumberedsections}{\settoggle{unnumberedsections}{true}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article} % Load the base class

%----------------------------------------------------------------------------------------
%	CUSTOM COMMANDS (must be defined before hyperref and fancyhdr use them)
%----------------------------------------------------------------------------------------

\newcommand{\reporttitle}{}
\newcommand{\reportsubtitle}{}
\newcommand{\reportauthors}{}
\newcommand{\reportdate}{}
\newcommand{\rightheadercontent}{}
\newcommand{\docversion}{}

\newcommand{\setreporttitle}[1]{\renewcommand{\reporttitle}{#1}}
\newcommand{\setreportsubtitle}[1]{\renewcommand{\reportsubtitle}{#1}}
\newcommand{\setreportauthors}[1]{\renewcommand{\reportauthors}{#1}}
\newcommand{\setreportdate}[1]{\renewcommand{\reportdate}{#1}}
\newcommand{\setrightheadercontent}[1]{\renewcommand{\rightheadercontent}{#1}}
\newcommand{\setdocversion}[1]{\renewcommand{\docversion}{#1}}

% Default header content: IST logo
\setrightheadercontent{\includegraphics[height=0.85cm]{Tecnico_ID_Principal_RBG-COR.png}}

%----------------------------------------------------------------------------------------
%	LANGUAGE
%----------------------------------------------------------------------------------------

\RequirePackage{polyglossia}
\setdefaultlanguage{portuguese}
\setotherlanguage{english}

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

\ifPDFTeX
  \usepackage[utf8]{inputenc} % Only needed for pdfLaTeX
\fi

\usepackage{graphicx} % Required for including images
\graphicspath{{img/}{Images/}{./}}

\setlength{\parindent}{0pt}
\setlength{\parskip}{10pt}

\usepackage[bottom, hang]{footmisc}
\setlength{\footnotemargin}{10pt}

\usepackage{lastpage}

\AtBeginEnvironment{quote}{\itshape\rmfamily}

\usepackage{appendix}

\usepackage{float}

\usepackage{sidenotes} % Required for sidenotes, sidecite, etc.

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\usepackage[
	top=3cm,
	bottom=3cm,
	left=2cm,
	right=2cm,
	footskip=1.5cm,
	headsep=1.5cm,
	headheight=1.2cm,
]{geometry}

\newenvironment{fullwidth}{
	\begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}
}{
	\end{adjustwidth}
}

\newenvironment{twothirdswidth}{
	\begin{adjustwidth}{}{\dimexpr-0.5\marginparwidth-0.5\marginparsep\relax}
}{
	\end{adjustwidth}
}

\newlength{\marginoffset}

\newcommand{\nonumsidenote}[2][]{\sidenote[\hspace{0pt}][#1]{#2}}
\newcommand{\sidenotequote}[2][]{\sidenote[\hspace{0pt}][#1]{\rmfamily\itshape#2}}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\usepackage[T1]{fontenc}
\usepackage{fontspec}

\usepackage{mathpazo}
\usepackage{sourcesanspro}

\setmainfont{Source Sans Pro}

\newcommand{\textel}[1]{{\fontseries{el}\selectfont #1}}
\newcommand{\textl}[1]{{\fontseries{l}\selectfont #1}}
\newcommand{\textsb}[1]{{\fontseries{sb}\selectfont #1}}

%----------------------------------------------------------------------------------------
%	COLOURS
%----------------------------------------------------------------------------------------

\usepackage[usenames, svgnames, table]{xcolor}

% DPQ IST Branding Colours
\definecolor{dpqtext}{HTML}{46555F}       % Main text colour
\definecolor{dpqheader}{HTML}{009DE0}     % Section level 1 colour
\definecolor{istblue}{HTML}{009DE0}       % IST Blue
\definecolor{istgray}{HTML}{D2D3D4}       % IST Light Grey
\definecolor{istdarkgray}{HTML}{46555F}   % IST Dark Grey
\definecolor{mylinkcolor}{HTML}{009DE0}   % Link colour
\definecolor{dpqtablerow}{HTML}{D2D3D4}   % Alternating table row colour

% Apply text colour globally
\color{dpqtext}

% Automatic alternating row colours for all tabular/tabularx environments
% Row 1 (header) stays uncoloured; row 2 onwards alternates white / #D2D3D4
\AtBeginEnvironment{tabular}{\rowcolors{2}{dpqtablerow}{white}}
\AtBeginEnvironment{tabularx}{\rowcolors{2}{dpqtablerow}{white}}

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\usepackage{fancyhdr}
\pagestyle{fancy}

\renewcommand{\headrulewidth}{0.5pt}

\fancyhf{}

\fancyhead[L]{\reporttitle}
\fancyhead[C]{}
\fancyhead[R]{\rightheadercontent}

\fancyfoot[L]{\docversion}
\fancyfoot[C]{Página \thepage\ de \pageref{LastPage}}
\fancyfoot[R]{\reportdate}

%----------------------------------------------------------------------------------------
%	SECTIONS
%----------------------------------------------------------------------------------------

\usepackage{titlesec}

\iftoggle{unnumberedsections}{
	\setcounter{secnumdepth}{0}
}{
	\setcounter{secnumdepth}{3}
}

\titleformat
	{\section}
	[block]
	{\raggedright\LARGE\bfseries\color{dpqheader}}
	{\thesection.}
	{5pt}
	{}
	[]

\titlespacing*{\section}{0pt}{\baselineskip}{4pt}

\titleformat
	{\subsection}
	[block]
	{\raggedright\large\bfseries\color{dpqheader}}
	{\thesubsection.}
	{5pt}
	{}
	[]

\titlespacing*{\subsection}{0pt}{0.75\baselineskip}{4pt}

\titleformat
	{\subsubsection}
	[block]
	{\raggedright\bfseries\normalsize\color{dpqheader}}
	{\thesubsubsection.}
	{5pt}
	{}
	[]

\titlespacing*{\subsubsection}{0pt}{0.5\baselineskip}{0pt}

\titleformat
	{\paragraph}
	[runin]
	{\bfseries}
	{}
	{0pt}
	{}
	[~~~~]

\titlespacing*{\paragraph}{0pt}{0pt}{0pt}

%----------------------------------------------------------------------------------------
%	TABLE OF CONTENTS
%----------------------------------------------------------------------------------------

\usepackage{titletoc}

\setcounter{tocdepth}{2}

\renewcommand{\contentsname}{Índice}

\titlecontents{section}
	[0pt]
	{\vspace{-2pt}}
	{\textsb{\thecontentslabel}~~\textsb}
	{\textsb}
	{\titlerule*[6pt]{.}\textsb{\contentspage}}
	[\vspace{2pt}]

\titlecontents{subsection}
	[0.5cm]
	{\vspace{-8pt}}
	{\textsb{\thecontentslabel}~~}
	{}
	{\titlerule*[6pt]{.}\contentspage}
	[]

\titlecontents{subsubsection}
	[1.35cm]
	{\vspace{-4pt}}
	{\textsb{\thecontentslabel}~~}
	{}
	{\titlerule*[6pt]{.}\contentspage}
	[]

%----------------------------------------------------------------------------------------
%	BIBLIOGRAPHY
%----------------------------------------------------------------------------------------

\usepackage[
	backend=biber,
	citestyle=numeric,
	bibstyle=numeric,
]{biblatex}

\newcommand{\sidecite}[2][0pt]{\sidenote[][#1]{\textcite{#2}}}
\newcommand{\fullsidecite}[2][0pt]{\sidenote[][#1]{\fullcite{#2}}}

%----------------------------------------------------------------------------------------
%	TABLES
%----------------------------------------------------------------------------------------

\usepackage{booktabs}
\usepackage{array}
\usepackage{tabularx}
\usepackage{multirow}
\usepackage{adjustbox}

\renewcommand{\arraystretch}{1.25}

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}

\newcommand{\thead}[1]{\textbf{#1}}

%----------------------------------------------------------------------------------------
%	SIUNITX (Portuguese decimal configuration)
%----------------------------------------------------------------------------------------

\RequirePackage{siunitx}
\sisetup{
	output-decimal-marker = {,},
	group-digits = false
}

%----------------------------------------------------------------------------------------
%	CAPTIONS
%----------------------------------------------------------------------------------------

\usepackage{caption}

\captionsetup{skip=6pt}
\captionsetup{font={bf,small}}
\captionsetup{justification=raggedright, singlelinecheck=false}

\DeclareCaptionStyle{widetable}{font={bf, footnotesize}, justification=raggedright, singlelinecheck=false}
\DeclareCaptionStyle{widefigure}{font={bf, footnotesize}, justification=raggedright, singlelinecheck=false}
\DeclareCaptionStyle{marginfigure}{font={bf, scriptsize}, justification=raggedright, singlelinecheck=false}
\DeclareCaptionStyle{margintable}{font={bf, scriptsize}, justification=raggedright, singlelinecheck=false}

%----------------------------------------------------------------------------------------
%	LISTS
%----------------------------------------------------------------------------------------

\usepackage{enumitem}

\setlist{itemsep=0pt, topsep=0pt}

\renewcommand{\labelenumi}{\arabic{enumi}.}
\renewcommand{\labelenumii}{\alph{enumii}.}
\renewcommand{\labelenumiii}{\roman{enumiii}.}

\renewcommand{\labelitemi}{\Large\raisebox{-1.5pt}{\textbullet}}
\renewcommand{\labelitemii}{\Large\raisebox{-1.5pt}{--}}
\renewcommand{\labelitemiii}{\Large\raisebox{-1.5pt}{-}}

%----------------------------------------------------------------------------------------
%	TCOLORBOX (Institutional styles)
%----------------------------------------------------------------------------------------

\RequirePackage[most]{tcolorbox}

\tcbset{
	istbox/.style={
		enhanced,
		colback=istgray,
		colframe=istdarkgray,
		boxrule=0.8pt,
		left=6mm,
		right=6mm,
		top=4mm,
		bottom=4mm,
		arc=2mm,
		before skip=10pt,
		after skip=10pt,
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
%	FONT AWESOME
%----------------------------------------------------------------------------------------

\RequirePackage{fontawesome5}

%----------------------------------------------------------------------------------------
%	TIKZ
%----------------------------------------------------------------------------------------

\RequirePackage{tikz}
\usetikzlibrary{shapes.geometric, arrows.meta, positioning, fit, backgrounds}

%----------------------------------------------------------------------------------------
%	MISC PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage{multicol}
\RequirePackage{pdflscape}
\RequirePackage{wrapfig}
\RequirePackage{framed}
\RequirePackage{soul}
\RequirePackage{csquotes}
\RequirePackage{eurosym}

%----------------------------------------------------------------------------------------
%	LINKS
%----------------------------------------------------------------------------------------

\usepackage{hyperref} % Must be near the end

\hypersetup{
	colorlinks=true,
	urlcolor=mylinkcolor,
	linkcolor=black,
	citecolor=black,
	pdftitle={\reporttitle},
	pdfauthor={Direção de Planeamento e Qualidade — IST},
	pdfsubject={Document},
	bookmarksnumbered=true
}

%----------------------------------------------------------------------------------------
%	CODE LISTINGS
%----------------------------------------------------------------------------------------

\usepackage{listings}

\lstset{
	numbers=left,
	numbersep=6pt,
	numberstyle=\tiny\it,
	frame=single,
	basicstyle=\tt\scriptsize,
	breaklines=true,
	aboveskip=1.5\baselineskip,
	tabsize=3,
}