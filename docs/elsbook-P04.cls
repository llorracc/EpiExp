%% Elseiver Document Class for Books/Series -- version 0.2 (03-Feb-2017)
%% Elseiver global LaTeX2e support for books
%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{elsbook}[03/02/2017 v0.2]% A class file for Elsevier books/series
\edef\ELSVER{03/02/2017 v0.2}

\newif\if@openright   \@openrighttrue
\newif\if@mainmatter  \@mainmattertrue
\newif\if@numberedchap\@numberedchapfalse
\newif\if@bwf         \@bwffalse
\newif\if@spellout    \@spelloutfalse
\newif\if@final       \@finalfalse%
\newif\if@APAcite     \@APAcitefalse
\newif\if@altmathv     \@altmathvfalse
\gdef\@stageid{printer}

\DeclareOption{book}{\global\@bwftrue}
\DeclareOption{series}{\global\@bwffalse}

\DeclareOption{proof}{\gdef\@stageid{proof}}
\DeclareOption{revises}{\gdef\@stageid{revises}}
\DeclareOption{final}{\gdef\@stageid{final}}

\DeclareOption{authoryear}{\xdef\@biboptions{round,authoryear}}
\DeclareOption{number}{\xdef\@biboptions{numbers}}
\DeclareOption{numbers}{\xdef\@biboptions{numbers}}
\DeclareOption{super}{\xdef\@biboptions{numbers,super}}
\DeclareOption{apacite}{\global\@APAcitetrue}
\DeclareOption{altmathv}{\global\@altmathvtrue}

\ExecuteOptions{a4paper,10pt,twoside,book}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}

\@ifundefined{@biboptions}{\xdef\@biboptions{numbers}}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% MAIN ELEMENTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\newif\if@frontmatter\@frontmatterfalse
\newif\if@mainmatter \@mainmatterfalse
\newif\if@backmatter \@backmatterfalse

\newcommand\Frontmatter{\cleardoublepage\pagestyle{fmbmheadings}
            \@frontmattertrue\@mainmatterfalse\@backmatterfalse\pagenumbering{roman}}
%
\newcommand\Mainmatter{\addtocontents{toc}{\vskip\tocfmsep}\cleardoublepage\pagestyle{headings}
       \@frontmatterfalse\@mainmattertrue\@backmatterfalse\pagenumbering{arabic}}
%
\newcommand\Backmatter{\addtocontents{toc}{\vskip\tocbmsep}\cleardoublepage\@frontmatterfalse\@mainmatterfalse\@backmattertrue}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OPENERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
\newcommand*{\@noindent@fpara}{%
  \everypar{{\setbox\z@\lastbox}\everypar{}}}
%
\newenvironment{partfrontmatter}{\let\quote\openerquote\let\endquote\endopenerquote}{\gdef\elsauthors{}\gdef\elsaddress{}\gdef\@partsubtitle{}\aftergroup\@noindent@fpara}
\newenvironment{sectionfrontmatter}{\let\quote\openerquote\let\endquote\endopenerquote}{\gdef\elsauthors{}\gdef\elsaddress{}\gdef\@Sectsubtitle{}\ \aftergroup\@noindent@fpara\par\addvspace{\baselineskip}}
\newenvironment{frontmatter}{\let\quote\openerquote\let\endquote\endopenerquote}{\gdef\elsauthors{}\gdef\elsaddress{}\gdef\@subtitle{}\aftergroup\@noindent@fpara}%\par\addvspace{2\baselineskip}
%
\newcounter {chapter}
\@addtoreset{section}{chapter}
\@addtoreset{subsection}{section}
\@addtoreset{subsubsection}{subsection}
\@addtoreset{paragraph}{subsubsection}
\@addtoreset{subparagraph}{paragraph}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% PART %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\elsauthors{}
\def\elsaddress{}
\newif\if@numberedpart\global\@numberedparttrue
\def\@parttitle{}

\newenvironment{parttext}{\par
    \let\frontmatter\partfrontmatter
    \let\endfrontmatter\endpartfrontmatter
    \renewcommand\thepart {\@arabic\c@part}
    \renewcommand\thesection {\thepart.\@arabic\c@section}
    \renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
    \renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
    \renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
    \renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
    %
    \let\subtitle\partsubtitle%
    \let\author\partauthor%
    \let\section\partouthd
    \fontfamily{\sfdefault}\selectfont\itshape%
    %
}{\par\vfill\noindent\gdef\elsauthors{}\global\@partoutheadfalse\relax}

\renewcommand\part{%
   \if@noskipsec \leavevmode \fi
   \par
   \addvspace{4ex}%
   \@afterindentfalse
   \thispagestyle{empty}%
   \secdef{\global\@numberedparttrue\@part}{\global\@numberedpartfalse\@spart}}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\protect\numberline{\thepart}#1}%
    \else%
      \addcontentsline{toc}{part}{#1}%
    \fi%
\gdef\@parttitle{#2}}
%
\def\@spart#1{\gdef\@parttitle{#1}}

\def\partnamefont{\fontfamily{\sfdefault}\fontsize{22}{22}\selectfont}
\def\parttitlefont{\fontfamily{\sfdefault}\fontsize{32}{34}\selectfont\bfseries\selectfont}
\def\partsubtitlefont{\fontfamily{\sfdefault}\fontsize{22}{24}\selectfont}
\def\partauthorfont{\fontfamily{\sfdefault}\fontsize{10}{12}\bfseries\selectfont}

\def\partopnrule#1{\hbox to 0pt{\hspace*{-84pt}\rule{421.11pt}{0.75pt}\hspace*{-59pt}%
\fboxsep0pt\fboxrule\z@\fcolorbox{black}{black}{\vbox to 36pt{\vskip12pt\hbox to 180pt{%
\hskip15pt\textcolor{white}{\fontfamily{\sfdefault}\fontsize{18}{18}\selectfont\bfseries #1}\hfill}\vfill}}}}
%
\def\@makeparthead#1{%
    {\parindent \z@ \raggedright
      \vglue136.5pt
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
        \vskip4pt
        \partopnrule{\MakeUppercase{\partname}}\par%
        \raisebox{-8.5pt}[0pt][0pt]{\vbox to 0pt{\hfill\reset@font\fontsize{115}{115}\selectfont\space\thepart}}% 
       \par\vskip-2pt\nobreak%
     \fi
     {\parttitlefont #1\par}%
     \markboth{#1}{#1}%
    \ifx\@partsubtitle\@empty\else
    \vskip6pt
    {\partsubtitlefont \@partsubtitle\par}
    \fi
    \global\punctcount\aucount
    \ifx\elsauthors\@empty\else
    \vskip 9\p@
    {\partauthorfont \elsauthors\par}
    \fi\vskip78pt%
    \@afterheading}}

\def\@makesparthead#1{%
    {\parindent \z@ \raggedright
      \vglue135pt
     \interlinepenalty \@M
     \normalfont
     {\huge \bfseries #1\par}%
     \ifx\@partsubtitle\@empty\else\vskip20pt\noindent{\large\@partsubtitle\par}\fi
    \vskip 20\p@
    \global\punctcount\aucount
    \ifx\elsauthors\@empty\else
    \normalsize\elsauthors\par\vskip10pt
    \footnotesize\itshape\elsaddress\par
    \fi
    \nobreak
     \vskip 3ex
     \@afterheading}}

\newcommand\makeparttitle{%
                \if@numberedpart
                    \if@twocolumn
                      \@topnewpage[\@makeparthead{\@parttitle}]%
                    \else
                      \@makeparthead{\@parttitle}%
                    \fi\@afterheading
                \else
                     \if@twocolumn
                       \@topnewpage[\@makesparthead{\@parttitle}]%
                     \else
                       \@makesparthead{\@parttitle}%
                     \fi\@afterheading
                \fi
                }


%%%%%%%%%%%%%%%% Part Subtitle

\def\@partsubtitle{}
\def\partsubtitle#1{\gdef\@partsubtitle{#1}}


%% Article Author(s)
\let\ausep\@empty%
\let\authorsep\@empty%
\newcount\aucount%
\def\partauthor{\advance\aucount by 1\@ifstar\@@corrpartauthor\@@partauthor}%
\def\au@and{\nobreak, }%
\newif\if@auemail%
\newcommand{\@@partauthor}[2][]{\g@addto@macro\elsauthors{%
    \ifnum\aucount=1%
    \global\@auemailtrue%
    \else%
    \global\@auemailfalse%
    \fi%
    \def\baselinestretch{1}%
    \authorsep{#2}\unskip\ifx#1\empty\else\textsuperscript{\smash{{%
      \@for\@@affmark:=#1\do{\edef\affnum{\@ifundefined{X@\@@affmark}{1}{\jmkRef{\@@affmark}}}%
    }}}}\fi%\unskip\ausep\affnum\let\ausep=,
    \def\authorsep{\au@and}%%%
    \global\let\ausep\@empty\global\let\@corref\@empty%
}}%

\newcommand{\@@corrpartauthor}[2][]{\g@addto@macro\elsauthors{%
    \global\@auemailtrue%
    \partauthorfont%
    \def\baselinestretch{1}%
    \authorsep{#2}\unskip\ifx#1\empty\else\textsuperscript{\smash{{%
      \@for\@@affmark:=#1\do{\edef\affnum{\@ifundefined{X@\@@affmark}{1}{\jmkRef{\@@affmark}}}%
    }}}}\fi%\unskip\ausep\affnum\let\ausep=,
    \def\authorsep{\au@and}%%%
    \global\let\ausep\@empty\global\let\@corref\@empty%
}}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHAPTER Opener %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\newcommand\@chapapp{\chaptername}
%
\global\@twosidetrue
\def\cleardoublepage{\clearpage\if@twoside  \ifodd\c@page\else
    \thispagestyle{empty}\hbox{}\newpage\if@twocolumn\thispagestyle{empty}\hbox{}\newpage\fi\fi\fi}%
%
\def\@chaptertitle{}
%
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi%
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef{\global\@numberedchaptrue\@chapter}{\global\@numberedchapfalse\@schapter}}

\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                    \if@mainmatter
                        \refstepcounter{chapter}%
                        \typeout{\@chapapp\space\thechapter.}%
                        \addcontentsline{toc}{chapter}%
                        {\protect\numberline{\thechapter}#1}%
                    \else
                         \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \gdef\@chaptertitle{#2}}

\def\@schapter#1{\gdef\@chaptertitle{#1}}

\RequirePackage{color}
\definecolor{graysixty}{cmyk}{0,0,0,0.6}
\definecolor{grayfifty}{cmyk}{0,0,0,0.5}
\definecolor{graytwenty}{cmyk}{0,0,0,0.2}
\def\chapternamefont{\fontfamily{\rmdefault}\fontsize{84}{84}\selectfont}
\def\chaptertitlefont{\fontfamily{\sfdefault}\fontsize{22}{24}\selectfont}
\def\chaptersubtitlefont{\fontfamily{\sfdefault}\fontsize{16}{18}\selectfont}
\def\chapterauthorfont{\fontfamily{\sfdefault}\fontsize{10}{12}\bfseries\selectfont\leftskip0pt plus1fill}
\def\chapteraffilfont{\fontfamily{\rmdefault}\fontsize{8}{12}\selectfont\itshape\leftskip0pt plus1fill}
%
\def\chapopnrule#1{\rule{\textwidth}{0.5pt}\hspace*{-64pt}\fboxsep0pt\fboxrule\z@\fcolorbox{black}{black}{%
\vbox to 31pt{\vskip13pt\hbox to 185pt{\hbox to 61.8pt{\hfill\textcolor{white}{\fontfamily{\sfdefault}\bfseries\fontsize{12}{12}\selectfont#1}}\hfill}\vfill}}}
%
\def\@makechapterhead#1{%
  {\vspace*{-28pt}\parindent \z@ \raggedright
  \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \vskip-12pt%
        \chapopnrule{{\MakeUppercase{\chaptername}}}\par\vskip-6pt%
        \raisebox{-8.5pt}[0pt][0pt]{\vbox to 0pt{\hbox to \textwidth{\hfill\space\chapternamefont\thechapter}}}% 
      \fi
    \fi
    \@dochapfootnote%
    \interlinepenalty\@M
    \vskip3\p@
    {\chaptertitlefont\rightskip6pc#1\par\nobreak}
    \ifx\@subtitle\@empty\vskip24pt\else
    \vskip6pt
    {\chaptersubtitlefont\@subtitle\par}
    \fi
    \global\punctcount\aucount
    \@doaufootnote%
    \ifx\elsauthors\@empty\else
    \vskip33.5\p@
    {\chapterauthorfont\elsauthors\par}
    \vskip0pt%
    {\chapteraffilfont\elsaddress\par}
    \fi
    \vspace*{40\p@}%
    \if@mtocfile\orgminitoc\vspace{14pt}\fi\global\@mtocfilefalse%
  }}


\newdimen\@adjstline

\def\@makeschapterhead#1{\protect\phantomsection%
  {\parindent \z@ \raggedright
    \normalfont
    \@dochapfootnote%
        \interlinepenalty\@M
    \null\vskip-35pt%
    {\chaptertitlefont{{#1}\par}}
    \xdef\contentcheck{#1}%
    \thispagestyle{fmbmplain}%
    \pagestyle{fmbmheadings}%
    \markboth{#1}{#1}%
    \ifx\contentcheck\contentsname\else\addcontentsline{toc}{fmbmchapter}{#1}\fi% For toc entry
    \ifx\@subtitle\@empty\else\vskip20pt{\large\@subtitle\par}\fi
    \global\punctcount\aucount
    \ifx\elsauthors\@empty\else
    %\vskip10pt%
    \normalsize\elsauthors\par
    \footnotesize\itshape\elsaddress\par
    \fi\vskip34pt%
}}


\newcommand\makechaptertitle{\xdef\@insertpag##1##2{##2}\@afterindentfalse%
                \if@numberedchap
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{\@chaptertitle}]%
                    \else
                      \@makechapterhead{\@chaptertitle}%
                    \fi\@afterheading
                \else
                     \if@twocolumn
                       \@topnewpage[\@makeschapterhead{\@chaptertitle}]%
                     \else
                       \@makeschapterhead{\@chaptertitle}%
                     \fi\@afterheading
                \fi
                \setcounter{footnote}{0}%
                \gdef\thefootnote{\arabic{footnote}}%
                \@afterheading}


%%%%%%%%%%%%%%%% Subtitle

\def\@subtitle{}
\def\subtitle#1{\gdef\@subtitle{#1}}


%%%%%%%%%%%%%%%% Authors & Affiliations

\newif\ifcorrauthor\global\corrauthorfalse

%% Cross Link for Author & Address
\def\jmkLabel#1{\@bsphack\protected@write\@auxout{}{\string\Newlabel{#1}{\@currentlabel}}\@esphack}
\def\Newlabel#1#2{\expandafter\xdef\csname X@#1\endcsname{#2}}
\def\jmkRef#1{\@ifundefined{X@#1}{0}{\csname X@#1\endcsname}}

%% Article Author(s)
\let\ausep\@empty%
\let\authorsep\@empty%
\newcount\aucount%
\def\author{\advance\aucount by 1\@ifstar{\protect\g@addto@macro\elsauthors{\protect\global\corrauthortrue}\@@corrauthor}{\protect\g@addto@macro\elsauthors{\protect\global\corrauthorfalse}\@@author}}%
\newcount\punctcount%
\def\au@and{\ifnum\punctcount=2\ and \else\unskip, \advance\punctcount by -1 \fi}%
\newif\if@auemail%

\def\affilnumbering#1{%
  \gdef\theaulink{\csname @#1\endcsname\c@aulink}% for author number
  \gdef\theafflink{\csname @#1\endcsname\c@afflink}% for address number
   }

\def\@dochapfootnote{}
\def\chapfootnotenumbering#1{%
  \gdef\@dochapfootnote{\setcounter{footnote}{0}\def\thefootnote{\csname @#1\endcsname\c@footnote}% for author number
   }}

\def\@doaufootnote{}
\def\aufootnotenumbering#1{%
  \gdef\@doaufootnote{%
  \let\oldfootnote\footnote%
  \def\footnote{\gdef\@authfoot{yes}\oldfootnote}%
  \setcounter{footnote}{0}\def\thefootnote{\csname @#1\endcsname\c@footnote}% for author number
   }}

\def\@currauthornumbering{}
\def\currauthornumbering#1{%
\gdef\@currauthornumbering{\csname @#1\endcsname}%
}%

\newcounter{aulink}
\affilnumbering{arabic}

\newcommand{\@@author}[2][]{\g@addto@macro\elsauthors{%
    \ifnum\aucount=1%
    \global\@auemailtrue%
    \else%
    \global\@auemailfalse%
    \fi%
    \def\baselinestretch{1}%
    \authorsep{#2}\ifx\@authfoot\@empty\else\textsuperscript{,}\def\@authfoot{}\fi\unskip\ifx#1\empty\else\textsuperscript{\smash{{%
      \@for\@@affmark:=#1\do{\edef\affnum{\@ifundefined{X@\@@affmark}{1}{\jmkRef{\@@affmark}}}%
    \unskip\ausep\setcounter{aulink}{\affnum}\theaulink\let\ausep=,}}}}\fi%
    \def\authorsep{\au@and}%%%
    \global\let\ausep\@empty\global\let\@corref\@empty%
}}%

\newcommand{\@@corrauthor}[2][]{\g@addto@macro\elsauthors{%
    \global\@auemailtrue%
    \def\baselinestretch{1}%
    \authorsep{#2}\ifx\@authfoot\@empty\else\textsuperscript{,}\def\@authfoot{}\fi\textsuperscript{\@currauthornumbering{1},}\unskip\ifx#1\empty\else\textsuperscript{\smash{{%
      \@for\@@affmark:=#1\do{\edef\affnum{\@ifundefined{X@\@@affmark}{1}{\jmkRef{\@@affmark}}}%
    \unskip\ausep\setcounter{aulink}{\affnum}\theaulink\let\ausep=,}}}}\fi%
    \def\authorsep{\au@and}%%%
    \global\let\ausep\@empty\global\let\@corref\@empty%
}}%

\long\def\@mpfootnotetext#1{%
  \global\setbox\@mpfootins\vbox{%
    \unvbox\@mpfootins
    \reset@font\footnotesize
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel
         {\csname p@mpfootnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces%
        \renewcommand{\source}[1]{##1}%
        #1\@finalstrut\strutbox}%
    \color@endgroup}}

\def\@corthanks{}
\def\auaddress{}

\newcounter{affn}
\renewcommand\theaffn{\arabic{affn}}
\def\address{\@ifstar\@@coraddress\@@address}
\newcount\addcount% To check the count of address

\newcounter{afflink}
\newcommand{\@@address}[2][]{%
%\advance\addcount by 1%
     \stepcounter{affn}%
     \setcounter{afflink}{#1}%
     \xdef\@currentlabel{\theaffn}%
     \jmkLabel{\theaffn}%
\protected@xdef\elsaddress{%
\elsaddress{{%
     \ifx#1\@empty\else\textsuperscript{\theafflink}\fi\noindent #2}}
}}%

\newcommand{\@@coraddress}[2][]{%
{%
     \stepcounter{affn}%
     \setcounter{afflink}{#1}%
     \xdef\@currentlabel{\theaffn}%
     \jmkLabel{\theaffn}%
    \protected@xdef\elsaddress{%
    \elsaddress\protect\par{%
    \ifx#1\@empty\else\textsuperscript{\@currauthornumbering{1}}\fi\noindent #2}}
}}%

\def\orgdiv#1{#1}%
\def\orgname#1{#1}%
\def\orgaddress#1{#1}%

\gdef\email#1{\texttt{#1}}

%%%%%%%%%%%%%%%% Abstract and Keyword for web (non-print)

\def\abstractfont{\fontfamily{\rmdefault}\fontsize{9}{11}\leftskip0pt\selectfont}
\def\abstractheadfont{\sffamily\fontsize{9}{11}\leftskip0pt\selectfont}
\renewenvironment{abstract}[1][\abstractname:]{%
\def\abstracthead##1{\noindent{\bf{\MakeUppercase{##1}}}}%
\par\noindent\rule{\hsize}{0.5pt}\par%
\abstracthead{\abstractheadfont#1}\par
%\vskip5.5pt%
\abstractfont\parindent0pt}
 {\par\vskip-4.5pt\noindent\rule{\hsize}{0.5pt}\par\addvspace{\baselineskip}}
%
\newenvironment{keywords}[1][\keywordname:]{%
\def\keywordhead##1{\noindent\textbf{##1 }}
\def\sep{\unskip, }%
\par\addvspace{\baselineskip}%
\abstractfont\raggedright\keywordhead{\abstractheadfont#1}}{\par\addvspace{\baselineskip}}

%%%%%%%%%%%%%%% Quote

\def\openerquotefont{\fontfamily{\rmdefault}\fontsize{10.5}{13.5}\itshape\selectfont\raggedright}
\newenvironment{openerquote}[1][]%
               {
               \def\quotehead##1{\noindent\textbf{##1 }}
               %
               \list{}{\leftmargin15pt\rightmargin0pt\topsep=13.5pt\partopsep=0pt\parsep=0pt\itemsep=0pt}%
               \ifx#1\empty\else\item[]\quotehead{#1}\vspace*{-.5\baselineskip}\fi%
                \item\relax\openerquotefont}
               {\endlist}

\newcommand{\source}[1]{\par \hfill\textbf{\textit{#1}}\par}

%%%%%%%%%%%%%%% Display Quote

\def\quotefnt{\reset@font\fontsize{9.5bp}{12}\selectfont\itshape}
\def\quoteauth#1{\par{\reset@font\normalcolor\fontsize{9}{12}\selectfont\raggedleft#1\par}}
\renewenvironment{quote}
               {\bgroup%
               \parskip\z@\let\source\quoteauth%%
                \list{}{\leftmargin=14\p@\topsep6\p@\partopsep0pt%
                \rightmargin14\p@%
                \parsep\z@\labelwidth=0pt%\parsep=5\p@
                \quotefnt}%
                   \item\relax}
               {\endlist\egroup}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Minitoc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\RequirePackage{multicol}
\RequirePackage[nohints]{minitoc}
\global\mtcindent=\p@
\mtcsettitle{minitoc}{\Chapterminicontentsname\vskip0pt}
\mtcsetrules{minitoc}{off}
\def\beforeminitoc{\vskip3pt}


\def\minitoc@[#1]{\vspace*{9pt}%
\global\@minitoc@used@true
\if@mtc@longext@
   \def\@tocfile{mtc\The@mtc}%
\else
   \def\@tocfile{M\The@mtc}%
\fi
        \mtc@CkFile{\jobname.\@tocfile}
        \if@mtc@FE
        \mtcPackageInfo[I0006]{minitoc}%
           {\jobname.\@tocfile\space is empty}
        \@mtc@empty@minitoc@true
        \else
        \thispageminitocstyle
%%        \mtc@markboth{\MakeUppercase{\mtctitle}}{\MakeUppercase{\mtctitle}}%
        \beforeminitoc
        \relax\begin{samepage}%
        \if #1e\let\do@mtitc\e@mti
         \else\if #1n\let\do@mtitc\n@mti
         \else\if #1c\let\do@mtitc\c@mti
         \else\if #1l\let\do@mtitc\l@mti
         \else\if #1r\let\do@mtitc\r@mti
         \else\if #1d\let\do@mtitc\df@mtitc
        \fi\fi\fi\fi\fi\fi
        \mtc@CkStr{\mtctitle}\if@mtc@FE \let\do@mtitc\e@mti\relax\fi
        \raggedright
        \parskip=\z@%
        \reset@font\mtcfont%
        \parindent=\z@%
        \nopagebreak[4]%
        \kern-0.8\baselineskip\nopagebreak[4]%
        \par\noindent %%
        \ifx\mtc@rule\relax
         \begin{tabular}{@{}p{\columnwidth}@{}}
         \reset@font\mtifont\do@mtitc{\mtc@v\MakeUppercase\mtctitle}\\[-10pt]\hline
         \end{tabular}%
        \else
         \begin{tabular}{@{}p{\columnwidth}@{}}
         \reset@font\mtifont\do@mtitc{\mtc@v\mtctitle}\\\hline
         \end{tabular}%
        \fi
        \nopagebreak[4]\null\leavevmode\mtc@zrule\\\mtc@BBR
        \leftmargin\mtcindent \rightmargin\mtcindent
        \itemindent=\z@\labelwidth=\z@%
        \labelsep=\z@\listparindent=\z@%
        \begin{mtc@verse}{\mtcoffset}%
        \c@tocdepth=\c@minitocdepth
        \leavevmode\\\mtc@BBR\vskip -.5\baselineskip
\begingroup
  \makeatletter
  \@ifundefined{mtc@pgno}%
  {\let\@dottedtocline\@undottedtocline}{}
  \@fileswfalse\mtc@hook@beforeinputfile
  \mtc@setform%
  \openminitoc \global\inminitoctrue\vspace*{6pt}%
  \@input{\jobname.\@tocfile}% 
  \global\inminitocfalse\closeminitoc
  \vspace{-1ex} \vspace{-\baselineskip}
  \leavevmode\mtc@strut
  \global\@nobreakfalse\endgroup
        \end{mtc@verse}%
        \kernafterminitoc
        \nopagebreak[4]\mtc@bottom@rule\null\leavevmode\\%
        \vskip-1.0\baselineskip\mtc@zrule\end{samepage}%
        \par\pagebreak[1]\vspace*{-1ex}\afterminitoc\fi}

\newif\if@mtocfile\@mtocfilefalse

\let\orgminitoc\minitoc

\def\minitoc{\global\@mtocfiletrue}


\mtcsettitlefont{minitoc}{\fontfamily{\sfdefault}\fontsize{9}{11}\selectfont\bfseries}
\newcommand{\mtcsecfont}{\reset@font\fontfamily{\sfdefault}\fontsize{9}{11}\selectfont\bfseries}
\newcommand{\mtcsbsecfont}{\reset@font\fontfamily{\sfdefault}\fontsize{9}{11}\selectfont}
\newcommand{\mtcsbsbsecfont}{\reset@font\fontfamily{\sfdefault}\fontsize{8}{11}\selectfont}

\newdimen\mtcsecnumskip
\newdimen\mtcsbsecnumskip
\newdimen\mtcsbsbsecnumskip
\newdimen\mtcseclabelwidth
\newdimen\mtcsbseclabelwidth
\newdimen\mtcsbsbseclabelwidth

\gdef\MaxmMiniTocnum#1#2#3{%
\setbox\@tempboxa\hbox{#1.\hskip6\p@}\global\mtcsecnumskip=\wd\@tempboxa%
\setbox\@tempboxa\hbox{#2.\hskip6\p@}\global\mtcsbsecnumskip=\wd\@tempboxa%
\setbox\@tempboxa\hbox{#3.\hskip6\p@}\global\mtcsbsbsecnumskip=\wd\@tempboxa%
\global\mtcseclabelwidth=\mtcindent%
\global\mtcsbseclabelwidth=\mtcsecnumskip
\global\mtcsbsbseclabelwidth=\mtcsbseclabelwidth\advance\mtcsbsbseclabelwidth by \mtcsbsecnumskip}

\renewcommand*\l@section{\mtcsecfont\def\numberline##1{\hb@xt@\@tempdima{\hfil##1.\hskip6\p@}}\@mtcdottedtocline{2}{\mtcseclabelwidth}{\mtcsecnumskip}}
\renewcommand*\l@subsection{\mtcsbsecfont\def\numberline##1{\hb@xt@\@tempdima{\hfil##1.\hskip6\p@}}\@mtcdottedtocline{3}{\mtcsbseclabelwidth}{\mtcsbsecnumskip}}
\renewcommand*\l@subsubsection{\mtcsbsbsecfont\def\numberline##1{\hb@xt@\@tempdima{\hfil##1.\hskip6\p@}}\@mtcdottedtocline{4}{\mtcsbsbseclabelwidth}{\mtcsbsbsecnumskip}}

\def\@mtcdottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \nointerlineskip
    \vskip2pt
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4} 
     \nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil{\reset@font\reset@font\fontfamily{\sfdefault}\fontsize{9}{9}\selectfont#5}}%
     \par}%
  \fi}

\MaxmMiniTocnum{A.1}{3.1}{3.3.3}

\AtBeginDocument{
\dominitoc}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Chapter Points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\def\chapterpointfont{\fontfamily{\sfdefault}\fontsize{8.5}{11}\selectfont}
\def\chapterpointheadfont{\sffamily\fontsize{10}{11}\selectfont\bfseries}
\newenvironment{points}[2][\pointshead]%
{\ifx#1\empty\else\subsection*{\chapterpointheadfont#1}\fi\par\vspace*{-3pt}
\def\itemargs{\leftmargini=0pt\itemsep=0pt\labelsep10pt\partopsep=0pt\parsep=0pt}
\chapterpointfont#2%
}
{\par}%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LISTS



\def\listfont{}%

\def\enumargs{%
   \listfont%
   \leftmargini0pt%
   \leftmarginii2pt%
   \leftmarginiii-1pt%
   \ifnum\@enumdepth=1\topsep6pt\else\topsep0pt\fi%
   \partopsep     \z@%
   \itemsep       \z@%
   \parsep        \z@%
   \ifnum\@enumdepth=3\labelsep10pt\else\labelsep6pt\fi%
   \rightmargin   \z@%
   %\raggedright%
   \listparindent \parindent%
   \itemindent    \z@}%

\def\enumerate{%
    \@ifnextchar[{\@numerate}{\@numerate[0.]}}

\def\@numerate[#1]{\par%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \enumargs%
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{\sffamily{\textbf{##1}}}}}%
     \fi
   }
\let\endenumerate\endlist

%%Unnumbered list%%
\def\unenumargs{%
   \listfont%
   \leftmargini14pt%
   \leftmarginii14pt%
   \leftmarginiii14pt%
   \ifnum\@enumdepth=1\topsep6pt\else\topsep0pt\fi%
   \partopsep     \z@%
   \itemsep       \z@%
   \parsep        \z@%
   \labelsep      0em%
   \rightmargin   \z@%
   %\raggedright%
   \listparindent \parindent%
   \itemindent    0pt}%

\def\unenumerate{%
    \@ifnextchar[{\@unenumerate}{\@unenumerate[]}}

\def\@unenumerate[#1]{\par%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{}{%
       \unenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{##1}}}%
     \fi
   }%
\let\endunenumerate\endlist%
%
\def\itemargs{%
   \listfont%
   \leftmargini-.25pt%
   \leftmarginii-.25pt%
   \leftmarginiii.5pt%
   \ifnum\@itemdepth=1\topsep6pt\else\topsep0pt\fi%
   \partopsep     \z@%
   \itemsep       \z@%
   \parsep        \z@%
   \labelsep      10pt%
   \rightmargin   \z@%
   %\raggedright%
   \listparindent \parindent%
   \itemindent    \z@}%
%
\AtBeginDocument{\def\textbullet{{\ifnum\@itemdepth=2\color{grayfifty}\else\fi$\bullet$}}}%
%
\def\itemize{%
   \@ifnextchar[{\@itemize}{\@itemize[\textbullet]}}
%
\def\@itemize[#1]{\par%
     \ifnum \@itemdepth >3 \@toodeep\else
     \advance\@itemdepth \@ne
     \edef\@itemctr{item\romannumeral\the\@itemdepth}
     \list{\csname label\@itemctr\endcsname}{%
       \itemargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@itemdepth\endcsname}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss \llap{##1}}}%
     \fi
   }%
\let\enditemize\endlist

\renewenvironment{description}
               {\list{}{\leftmargin\parindent\labelwidth\z@ \itemindent-\leftmargin
                        \itemsep=0pt%
                        \partopsep=0pt%
                        \parsep=0pt%
                        \topsep=0pt%
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\renewcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries#1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE & TABLES

%\RequirePackage{array}%
\RequirePackage{threeparttable}
%\RequirePackage{floatpag}
\RequirePackage{float}
%\RequirePackage{stfloats}
\RequirePackage{booktabs}
%%\RequirePackage[figuresright]{rotating}
\RequirePackage{url}


\def\FIG#1#2{\centering#1#2}
\newenvironment{FIG*}{\centering}{}

\def\captionnumfont{\fontfamily{\sfdefault}\fontsize{9.75bp}{11.5}\bfseries\selectfont}
\def\captionfont{\fontfamily{\sfdefault}\fontsize{9.75bp}{11.5}\selectfont}

\setlength\abovecaptionskip{3\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
\gdef\title##1{\gdef\@title{\captionfont\textbf{{##1}}}}%
\def\source##1{\textit{Source: ##1}}%
  \vskip\abovecaptionskip%
  \sbox\@tempboxa{\captionfont#1\hskip1em#2}%
  \ifdim \wd\@tempboxa >\hsize%
    {\captionnumfont \MakeUppercase{#1}}\quad\@title\par\vskip-6pt\rule{\textwidth}{0.35pt}\par\nointerlineskip\vskip4pt%
    {\captionfont#2\par}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\box\@tempboxa\hfill}%
  \fi
  \vskip\belowcaptionskip}


\def\tablecaptionnumfont{\fontfamily{\sfdefault}\fontsize{9}{12}\bfseries\selectfont}
\def\tablecaptionfont{\fontfamily{\sfdefault}\fontsize{9}{12}\selectfont}


\def\TPTtagStyle{\textit}
\def\tablebodyfont{\fontfamily{\sfdefault}\fontsize{8.5}{10}\selectfont}
\def\TCHfont{\reset@font\fontfamily{\sfdefault}\fontsize{8.5}{10}\selectfont\bfseries}
\def\TSHfont{\reset@font\fontfamily{\sfdefault}\fontsize{8.5}{10}\selectfont\bfseries\itshape}
\def\tablefootfont{\fontfamily{\sfdefault}\fontsize{7.5}{8.5}\raggedright\selectfont\itshape}

\long\def\TBL#1#2#3{\let\hline\tablehrule%
\def\CT@@do@color{%
  \global\let\CT@do@color\relax
        \@tempdima\wd\z@
        \advance\@tempdima\@tempdimb
        \advance\@tempdima\@tempdimc
        \advance\@tempdimb-0.04218pt
        \kern-\@tempdimb
        \leaders\vrule
%%^^A                     \@height\p@\@depth\p@
                \hskip\@tempdima\@plus  1fill
        \kern-\@tempdimc
        \hskip-\wd\z@ \@plus -1fill }
%
\def\@classz{\@classx
   \@tempcnta \count@
   \prepnext@tok
\expandafter\CT@extract\the\toks\@tempcnta\columncolor!\@nil
   \@addtopreamble{%\kern-0.039pt%
    \setbox\z@\hbox\bgroup\bgroup
      \ifcase \@chnum
      \hskip\stretch{.5}\kern\z@
      \d@llarbegin
      \insert@column
      \d@llarend\hskip\stretch{.5}\or
      \hskip4pt\hskip-\col@sep\d@llarbegin \insert@column \d@llarend \hfill \or
      \hfill\kern\z@ \d@llarbegin \insert@column \d@llarend \or
   $\vcenter
   \@startpbox{\@nextchar}\insert@column \@endpbox $\or
   \vtop \@startpbox{\@nextchar}\insert@column \@endpbox \or
   \vbox \@startpbox{\@nextchar}\insert@column \@endpbox
  \fi
 \egroup\egroup
\begingroup
  \CT@setup
  \CT@column@color
  \CT@row@color
  \CT@cell@color
  \CT@do@color
\endgroup
        \@tempdima\ht\z@
        \advance\@tempdima\minrowclearance
        \vrule\@height\@tempdima\@width\z@
        \unhbox\z@}%
  \prepnext@tok}
\long\def\@makecaption##1##2{%
\gdef\title####1{\textbf{{####1}}}
\def\source####1{\textit{Source: ####1}}
  \sbox\@tempboxa{{\tablecaptionnumfont{##1}}{\tablecaptionfont\hskip.5em##2}}%
  \ifdim \wd\@tempboxa >\hsize
    {\tablecaptionnumfont{##1}}{\tablecaptionfont\leftskip4pt\rightskip4pt\hskip.5em##2\par}
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip%
}%
\let\footnotemark\tnote%
\renewcommand\footnotetext[2][]{\tablefootfont\leftskip-8pt\labelsep=0pt\ifx##1\empty\item[]##2\else\item[]\textsuperscript{##1}##2\fi}
\renewcommand{\source}[1]{\textit{Source: ##1}}%
\fboxsep8pt\fboxrule\z@%
{\begin{threeparttable}\def\arraystretch{1.55}%
\tablebodyfont%
#1#2#3
\end{threeparttable}}}

\newenvironment{TBL*}{%
\let\footnotemark\tnote%
\renewcommand\footnotetext[2][]{\tablefootfont\ifx##1\empty\item[]##2\else\item[##1]##2\fi}%
\renewcommand{\source}[1]{\textit{Source: ##1}}%
\begin{threeparttable}\tablebodyfont}{\end{threeparttable}}

\newcommand{\TCH}[1]{{\cellcolor{graytwenty}\TCHfont#1}}%
\newcommand{\TSH}[1]{{\cellcolor{graytwenty}\TSHfont#1}}%

\heavyrulewidth=1.5pt
\lightrulewidth=.5pt
\cmidrulewidth=.5pt
\abovetopsep=0pt
\aboverulesep=0pt
\belowrulesep=0pt
\belowbottomsep=0pt
%
\def\toprule{\\[-17pt]}
%
\def\colrule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=0pt
  \global\@belowrulesep=\belowrulesep
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[\lightrulewidth]}}
\def\botrule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=\aboverulesep
  \global\@belowrulesep=\belowbottomsep
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[\lightrulewidth]}}
%
\def\colhdrule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=0.11pt
  \global\@belowrulesep=0pt %global cos for use in the next noalign
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[1pt]}}
%
\def\colhdendrule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=0pt
  \global\@belowrulesep=0pt %global cos for use in the next noalign
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[1.2pt]}}
%
\def\tablehrule{\noalign{\ifnum0=`}\fi
  \@aboverulesep=0pt
  \global\@belowrulesep=0pt %global cos for use in the next noalign
  \global\@thisruleclass=\@ne
  \@ifnextchar[{\@BTrule}{\@BTrule[0.5pt]}}
%
\def\@@@cmidrule[#1-#2]#3#4{\global\@cmidla#1\relax
    \global\advance\@cmidla\m@ne
    \ifnum\@cmidla>0\global\let\@gtempa\@cmidrulea\else
    \global\let\@gtempa\@cmidruleb\fi
    \global\@cmidlb#2\relax
    \global\advance\@cmidlb-\@cmidla
    \global\@thisrulewidth=#3
    \@setrulekerning{#4}
    \ifnum\@lastruleclass=\z@\vskip \aboverulesep\fi
    \ifnum0=`{\fi}\@gtempa
    \noalign{\ifnum0=`}\fi\futurenonspacelet\@tempa\@xcmidrule}
%
\def\@cmidrulea{%
   \multispan\@cmidla&\multispan\@cmidlb
   \unskip\hskip\cmrkern@l%
  {\color{white}\CT@arc@\leaders\hrule \@height\@thisrulewidth\hfill}%
   \hskip\cmrkern@r\cr}%
\def\@cmidruleb{%
    \multispan\@cmidlb
    \unskip\hskip \cmrkern@l%
   {\color{white}\CT@arc@\leaders\hrule \@height\@thisrulewidth\hfill}%
    \hskip\cmrkern@r\cr}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BOXES

\def\BoxTypeAfont{\fontfamily{\rmdefault}\fontsize{8}{10}\selectfont\parskip=0pt}
\newenvironment{BoxTypeA}[2][]
{\par\addvspace{12pt plus2pt}\parindent12pt%
\def\@xfloat##1[{\@ifnextchar{H}{\@float@HH{##1}[}{\@float@Hx{##1}[}}%% reinstate float.sty macro (over floatpag)
\gdef\@envopt{#1}%
\BoxTypeAfont%
\def\boxsectionfont{\fontfamily{\sfdefault}\fontsize{9bp}{10}\bfseries\selectfont}
\def\boxsubsectionfont{\fontfamily{\sfdefault}\fontsize{8.5bp}{10}\itshape\selectfont}
\def\boxsubsubsectionfont{\fontfamily{\sfdefault}\fontsize{8bp}{10}\bfseries\itshape\selectfont}
\def\boxsection{\@startsection {section}{1}{\z@}%
                                   {-6pt \@plus -2pt}%
                                   {0.001pt}%
                                   {\boxsectionfont}}
\def\boxsubsection{\@startsection{subsection}{2}{\z@}%
                                     {-3pt \@plus -2pt}%
                                     {0.001pt}%
                                     {\boxsubsectionfont}}
\def\boxsubsubsection{\@startsection{paragraph}{3}{\z@}%
                                    {0.001pt}%
                                    {-1em}%
                                    {\boxsubsubsectionfont}}
\def\boxparagraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\itshape}}
\let\section\boxsection
\let\subsection\boxsubsection
\let\subsubsection\boxsubsubsection
\let\paragraph\boxparagraph
\def\source##1{\par \hfill\fontsize{7bp}{9}\selectfont\textbf{{##1}}\par}
\ifx\@envopt\empty\begin{BoxA*}{#2}\else\begin{BoxA}[#1]{#2}\fi}
{\ifx\@envopt\empty\end{BoxA*}\else\end{BoxA}\fi\@endparenv}

\RequirePackage{framed}
\definecolor{shadecolor}{cmyk}{0,0,0,0.15}%
\newcounter{box}

\newenvironment{myshade}{%
    \def\FrameCommand{\fboxrule=1pt\fboxsep=\FrameSep\fcolorbox{black}{shadecolor}}%
    \MakeFramed {\advance\hsize-\width\FrameRestore\@setminipage}}%
   {\par\unskip\endMakeFramed}
%
\def\boxcaptionfont{\fontfamily{\sfdefault}\fontsize{11bp}{13}\bfseries\selectfont\raggedright}
\def\boxcaptionnumfont{\fontfamily{\sfdefault}\fontsize{11bp}{13}\bfseries\selectfont\raggedright}
%
\newenvironment{BoxA}[2][]%
       {\fboxsep=9pt\relax
        \begin{myshade}%
        \ifx#1\@empty\else\refstepcounter{box}\label{#1}\fi
        \ifx#2\@empty\else \noindent{\boxcaptionnumfont{\boxname~\thebox}\boxcaptionfont{\hskip.5em#2\par}}\unskip\fi
%        \list{}{\leftmargin0pt\rightmargin=\leftmargin\parskip=0pt\parsep=0pt\topsep=\z@\relax}%
%                                                  \expandafter\item%
%                                               \hskip-\listparindent
        }%
       {\end{myshade}}%\endlist

\@namedef{BoxA*}{\BoxA}
\@namedef{endBoxA*}{\endBoxA}


%%%%%%% TE Type A

\def\TETypeAfont{\fontfamily{\rmdefault}\fontsize{8}{10}\selectfont\leftskip10pt\rightskip10pt}
\newenvironment{TETypeA}[2][]{\par\parindent12pt%
\def\@xfloat##1[{\@ifnextchar{H}{\@float@HH{##1}[}{\@float@Hx{##1}[}}%% reinstate float.sty macro (over floatpag)
\gdef\@TEenvopt{#1}%
\TETypeAfont%
\def\boxsectionfont{\fontfamily{\sfdefault}\fontsize{9}{10}\bfseries\selectfont}
\def\boxsubsectionfont{\fontfamily{\sfdefault}\fontsize{8.5bp}{10}\itshape\selectfont}
\def\boxsubsubsectionfont{\fontfamily{\sfdefault}\fontsize{8bp}{10}\bfseries\itshape\selectfont}
\def\boxsection{\@startsection {section}{1}{\z@}%
                                   {-6pt \@plus -2pt}%
                                   {0.001pt}%
                                   {\boxsectionfont}}
\def\boxsubsection{\@startsection{subsection}{2}{\z@}%
                                     {-3pt \@plus -2pt}%
                                     {0.001pt}%
                                     {\boxsubsectionfont}}
\def\boxsubsubsection{\@startsection{paragraph}{3}{\z@}%
                                    {0.001pt}%
                                    {-0.5em}%
                                    {\boxsubsubsectionfont}}
\def\boxparagraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\itshape}}
\let\section\boxsection
\let\subsection\boxsubsection
\let\subsubsection\boxsubsubsection
\let\paragraph\boxparagraph
\def\source##1{\par \hfill\fontsize{7bp}{9}\selectfont\textbf{\textit{##1}}\par}
\ifx\@TEenvopt\empty\begin{TEXTTypeA*}{#2}\else\begin{TEXTTypeA}[#1]{#2}\fi}
{\ifx\@TEenvopt\empty\end{TEXTTypeA*}\else\end{TEXTTypeA}\fi}

\newcounter{textbox}
\def\textcaptionnumfont{\fontfamily{\sfdefault}\fontsize{11bp}{13pt}\bfseries\selectfont}
\def\textcaptionfont{\fontfamily{\sfdefault}\fontsize{11bp}{13pt}\bfseries\selectfont}

\newenvironment{TEXTTypeA}[2][]
{\par\addvspace{17pt plus2pt}%
\ifx#1\@empty\else\refstepcounter{textbox}\label{#1}\fi%
\noindent\ifx#2\@empty\else\subsection*{\raise17pt\hbox{\rlap{\hskip-10pt\rule{\hsize}{2pt}}}\reset@font\textcaptionnumfont{\thetextbox}\textcaptionfont{\hskip.5em\MakeUppercase{#2}}}\fi%
}%
{\par\vskip-4pt\nobreak\noindent%\hskip-10pt\rule{\hsize}{1pt}
\par\addvspace{18pt}}

\@namedef{TEXTTypeA*}{\TEXTTypeA}
\@namedef{endTEXTTypeA*}{\endTEXTTypeA}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Exercises

\def\theexenumi{\thechapter.\@arabic\c@enumi}
\def\theexenumii{\thechapter.\@alph\c@enumii}
\def\theexenumii{\thechapter.\@alph\c@enumiii}
\def\exlabelenumi{\theexenumi}
\def\exlabelenumii{\theexenumii}
\def\exlabelenumiii{\theexenumiii.}

\newenvironment{exercises}[1][\exercisename]{\par
\def\@exheadtest{#1}%
\ifx\@exheadtest\@empty\else\section*{#1}\fi
\let\theenumi\theexenumi
\let\theenumii\theexenumii
\let\theenumiii\theexenumiii
\def\labelenumi{\bf\theexenumi}
\let\labelenumii\exlabelenumii
\let\labelenumiii\exlabelenumiii
}{\par}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Additional macros

\RequirePackage{appendix}
\newenvironment{backmatter}{}{}

%%%%%%%%%%%% Glossary
\def\glossaryfont{\fontsize{8.5}{11}\selectfont}
\renewenvironment{glossary}[1][\glossaryhead]
               {\glossaryfont\ifx#1\empty\else\section*{#1}\fi\par%
               \list{}{\leftmargin=\parindent\labelwidth\z@ \itemindent-\leftmargin
                        %\def\glosslabel##1{##1}
                        \itemsep=0pt\partopsep=0pt\parsep=0pt%
                        %\let\makelabel\glosslabel
                        }}
               {\endlist}

\newcommand*\glosslabel[1]{\item{
                                \normalfont\bfseries #1\hskip.45em}}


%%%%%%%%%%%% Acknowledgement

\def\ackfont{\fontsize{8.5}{11}\selectfont}
\newenvironment{ack}[2][\acknowledgmenthead]%
{\ackfont\ifx#1\empty\else\section*{#1}\fi\par}
{\par}


%%%%%%%%%%%% Addresses

\newenvironment{addresses}%
{\par\def\address##1{\par\noindent ##1\par\addvspace{12pt}}}
{\par}

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Biography %%%%%%%%%%%%%%%%%%%%%%%%%
%

\newenvironment{biography}[2]{\par
#1#2}{\par}


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Bibliography %%%%%%%%%%%%%%%%%%%%%%%%%%

\if@APAcite
\RequirePackage{apacite} %% For APA style bib
\fi
\RequirePackage[\@biboptions]{natbib}
\def\bibfont{\fontfamily{\rmdefault}\fontsize{8.5}{11}\selectfont}
%%\def\@biblabel#1{#1.}  %% Commented to align number
\bibsep=0pt
\bibhang=14pt

\renewcommand\NAT@bibsetnum[1]{\settowidth\labelwidth{\@biblabel{#1}}\ifnum#1>9\labelsep3.5pt\else\labelsep7.5pt\fi%
   \setlength{\leftmargin}{\labelwidth}\addtolength{\leftmargin}{\labelsep}%
   \setlength{\itemsep}{\bibsep}\setlength{\parsep}{\z@}%
   \ifNAT@openbib
     \addtolength{\leftmargin}{\bibindent}%
     \setlength{\itemindent}{-\bibindent}%
     \setlength{\listparindent}{\itemindent}%
     \setlength{\parsep}{0pt}%
   \fi
}


\@ifpackageloaded{natbib}{%
\@namedef{thebibliography*}{\def\bibsection{}\thebibliography}
\@namedef{endthebibliography*}{\endthebibliography}
}
{
\@namedef{thebibliography*}{\def\refname{}\thebibliography}
\@namedef{endthebibliography*}{\endthebibliography}
}

\def\@bibtype{}
\def\bibtype#1{\gdef\@bibtype{#1}}

%%%%%%%%%%%%%%%%%%%%%%% Definition for T1 symbols %%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% BOOK FRONTMATTER %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% PRELIMES
\def\booktitlefont{\fontfamily{\sfdefault}\fontsize{34}{32}\selectfont\leftskip0pt plus1fill}
\def\booksubtitlefont{\fontfamily{\sfdefault}\fontsize{26}{26}\selectfont\leftskip0pt\rightskip0pt plus1fill}
\def\bookauthorfont{\fontfamily{\sfdefault}\fontseries{b}\fontsize{16}{18}\selectfont\leftskip0pt plus1fill}
\def\bookaddressfont{\fontfamily{\sfdefault}\leftskip0pt plus1fill}
\def\bookeditiontextfont{\fontfamily{\sfdefault}\fontsize{10}{10}\selectfont\leftskip0pt\rightskip0pt plus1fill}
\newenvironment{frontpage}{\par%
\renewenvironment{titlepage}{}{}%
\renewcommand{\title}[1]{\gdef\@title{##1}}
\renewcommand{\subtitle}[1]{\vskip1pc\gdef\@subtitle{##1}}
\renewcommand{\author}[1]{\vskip11pt{\bookauthorfont ##1\par}}
\renewcommand{\address}[1]{{\vskip2pt\bookaddressfont##1\par}}
\newcommand{\editor}[1]{\vskip12pt{\bookauthorfont ##1\par}}
\newcommand{\edition}[1]{\centerline{\LARGE ##1}\par\vskip3pc}
\newcommand{\editiontext}[1]{\vskip114pt{\bookeditiontextfont##1\par}}
\def\logo##1{\vskip3pc\centerline{##1}}
\begin{titlepage}%
%
%%%%%%%%%%%%%%%%% Title Page
  \cleardoublepage
  \renewcommand\maketitle{%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  %\null\vfil
  \vskip 60\p@
  \thispagestyle{empty}
%  \begin{center}%
    {\booktitlefont\@title \par}%
    {\ifx\@subtitle\@empty\else\vskip1pc\booksubtitlefont \@subtitle \par\fi}\vskip160pt%
%  \end{center}\par
  \@thanks

  }%
\begin{center}}
{\par\vfill\null
\end{center}\end{titlepage}%
\gdef\@subtitle{}}

%% Dedication
\def\dedication#1#2{\gdef\@dedication{\leftskip6pc\itshape #1\par\begin{flushright}\textrm{#2}\end{flushright}}
\@dedication\par}

%%%% for chapters
\newenvironment{frontchapter}{\par
\renewcommand{\source}[1]{\vskip\baselineskip
\renewcommand{\author}[2][]{\par\noindent \hfill{\bf ####2}\par}
\renewcommand{\address}[2][]{\par\noindent \hfill####2\par}
\renewcommand{\date}[2][]{\par\noindent \hfill####2\par}
##1}
}{\par}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Table of Contents

\renewcommand\tableofcontents{{%
    %\section*{\vspace*{-18pt}}%
    \let\@dottedtocline\@maindottedtocline%
    \let\l@chapter\mainl@chapter%
    \let\l@section\mainl@section%
    \let\l@subsection\mainl@subsection%
    \let\l@subsubsection\mainl@subsubsection%
    \@starttoc{toc}%
    }}

\newdimen\tocfmsep\tocfmsep=12pt
\newdimen\tocbmsep\tocbmsep=12pt
\newdimen\tocchapnumskip
\newdimen\tocsecnumskip
\newdimen\tocsbsecnumskip
\newdimen\tocsbsbsecnumskip
\newdimen\tocseclabelwidth
\newdimen\tocsbseclabelwidth
\newdimen\tocsbsbseclabelwidth

\gdef\MaxmTocnum#1#2#3#4{%
\setbox\@tempboxa\hbox{\tocchapterfont CHAPTER~#1\hskip6\p@}\global\tocchapnumskip=\wd\@tempboxa%
\setbox\@tempboxa\hbox{\tocsecfont#2.\hskip6\p@}\global\tocsecnumskip=0pt\advance\tocsecnumskip\tocchapnumskip%
\setbox\@tempboxa\hbox{\tocsbsecfont#3.\hskip6\p@}\global\tocsbsecnumskip=\wd\@tempboxa\advance\tocsbsecnumskip\tocsecnumskip%
\setbox\@tempboxa\hbox{#4.\hskip6\p@}\global\tocsbsbsecnumskip=\wd\@tempboxa\advance\tocsbsbsecnumskip\tocsbsecnumskip%
\global\tocseclabelwidth=\tocchapnumskip%
\global\tocsbseclabelwidth=\tocchapnumskip\advance\tocsbseclabelwidth by \tocsecnumskip%
\global\tocsbsbseclabelwidth=\tocsbseclabelwidth\advance\tocsbsbseclabelwidth by \tocsbsecnumskip}

\def\tocpartfont{\reset@font\fontfamily{\sfdefault}\fontsize{14}{16}\bfseries\selectfont}
\def\tocchapterfont{\reset@font\fontfamily{\sfdefault}\fontsize{12}{14}\bfseries\selectfont}
\def\tocfmbmchapterfont{\reset@font\fontfamily{\rmdefault}\fontsize{10}{13}\selectfont}
\def\tocsecfont{\reset@font\fontfamily{\rmdefault}\fontsize{10}{12}\selectfont}
\def\tocsbsecfont{\reset@font\fontfamily{\rmdefault}\fontsize{10}{12}\selectfont}
\def\tocsbsbsecfont{\reset@font\fontfamily{\sfdefault}\fontsize{10}{12}\selectfont}

\newif\if@chaptocpresent\global\@chaptocpresentfalse

\renewcommand*\l@part{\tocpartfont\vskip1pt\def\numberline##1{\hbox{Part\space##1\hskip10pt}}\@partdottedtocline{-1}{0pt}{0pt}}
\newcommand*\mainl@chapter{\global\@chaptocpresenttrue\tocchapterfont\vskip12pt\def\numberline##1{\hb@xt@\@tempdima{\hfil CHAPTER~##1\hskip1em}}\@dottedtocline{1}{0pt}{\tocchapnumskip}}
\newcommand*\l@fmbmchapter{\tocfmbmchapterfont\def\numberline##1{\hb@xt@\@tempdima{\hfil##1.\hskip6\p@}}\@dottedtocline{1}{0pt}{\tocchapnumskip}}
\newcommand*\mainl@section{\tocsecfont\if@chaptocpresent\global\@chaptocpresentfalse\vskip6pt\else\vskip0pt\fi\def\numberline##1{\hb@xt@\@tempdima{\hfil\textsf{\textbf{##1}}\hskip6\p@}}\@dottedtocline{2}{\tocseclabelwidth}{\tocsecnumskip}}
\newcommand*\mainl@subsection{\tocsbsecfont\def\numberline##1{\hb@xt@\@tempdima{\hfil##1\hskip6\p@}}\@dottedtocline{3}{\tocsbseclabelwidth}{\tocsbsecnumskip}}
\newcommand*\mainl@subsubsection{\tocsbsbsecfont\def\numberline##1{\hb@xt@\@tempdima{\hfil##1.\hskip6\p@}}\@dottedtocline{4}{\tocsbsbseclabelwidth}{\tocsbsbsecnumskip}}
\renewcommand*\l@paragraph{\@dottedtocline{5}{7.0em}{4.1em}}
\renewcommand*\l@subparagraph{\@dottedtocline{6}{10em}{5em}}
%
\def\@maindottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip%
    \advance\rightskip\z@ plus1fil%
     \parindent #2\relax\pretolerance=10000\exhyphenpenalty=10000\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}
     \nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}

\def\@partdottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip%
    \advance\rightskip\z@ plus1fil%
     \parindent #2\relax\pretolerance=10000\exhyphenpenalty=10000\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     \MakeUppercase{#4}\par\vskip-10pt\rule{\textwidth}{.5pt}
%     \nobreak
%     \leaders\hbox{$\m@th
%        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
%        mu$}\hfill
%     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor}%
     \par\vskip-20pt}%
  \fi}
  
\MaxmTocnum{9}{9}{9.9}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%List of Contributors
\newenvironment{contributors}[1][]{%
\renewcommand{\author}[3][]{\hangindent0pt\noindent\ifx##1\empty\else ##1 \fi\textbf{##2}\enspace##3\par\vskip.5\baselineskip}%
\def\address##1{##1}%
}{}%

%%%% List of Algorithm
\AtBeginDocument{
\providecommand{\l@algocf}{\@dottedtocline{2}{1.5em}{2.3em}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% BOOK BACKMATTER %%%%%%%%%%%%%%%%%%%%%%%%%%

\newenvironment{backchapter}[1][]{\par}{\par}


%%%% For Each Element Headings
\IfFileExists{booksetup.sty}{%
\RequirePackage{booksetup}}{\@latex@error{!!! booksetup.sty not found. !!!}\@ehc}

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
\newcommand{\weblink}[2]{{{#1}\ \ref{#2}}}%
\def\eqweblink#1#2{{#1}~(\ref{#2})}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Units
\def\si#1{\,\text{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% To differ greek 'nu' and letter 'v'

\if@altmathv%
\AtBeginDocument{%
\@ifpackageloaded{txfonts}{%
\DeclareSymbolFont{normalletter}{U}{txmia}{m}{it}%
\SetSymbolFont{normalletter}{bold}{U}{txmia}{b}{it}
\DeclareMathSymbol{v}{\mathalpha}{normalletter}{51}
}{}}%
\fi

\AtBeginDocument{\@ifpackageloaded{hyperref}
  {\def\@linkcolor{blue}
   \def\@anchorcolor{blue}
   \def\@citecolor{blue}
   \def\@filecolor{blue}
   \def\@urlcolor{blue}
   \def\@menucolor{blue}
   \def\@pagecolor{blue}
\begingroup
  \@makeother\`%
  \@makeother\=%
  \edef\x{%
    \edef\noexpand\x{%
      \endgroup
      \noexpand\toks@{%
        \catcode 96=\noexpand\the\catcode`\noexpand\`\relax
        \catcode 61=\noexpand\the\catcode`\noexpand\=\relax
      }%
    }%
    \noexpand\x
  }%
\x
\@makeother\`
\@makeother\=
}{}}



%%%% P04 Template Definitions %%%%%
\setlength{\paperwidth}{7.5in}
\setlength{\paperheight}{9.25in}
\setlength\topskip   {8\p@}
\setlength{\textheight}{43\baselineskip}
\addtolength{\textheight}{\topskip}
\addtolength{\textheight}{2pt}
\setlength{\oddsidemargin}{84.28pt}
\def\oddsideskip{84pt}
\setlength{\evensidemargin}{120.4pt}
\def\evensideskip{120pt}
\setlength{\textwidth}{337.11pt}%
%
\addtolength{\oddsidemargin}{-1in}
\addtolength{\evensidemargin}{-1in}
\setlength{\topmargin}{32pt}
\addtolength{\topmargin}{-73.5pt}
\setlength{\headheight}{6pt}
\setlength{\headsep}{50.65pt}
\addtolength\headsep {-\topskip}% 
\setlength{\footskip}{22pt}
\setlength{\maxdepth}{3pt}

\setlength\maxdepth{0pt}%
\setlength\footskip{21.55pt}%
\parskip=0pt%
\setlength\parindent{14pt}%
\columnsep=14pt

\usepackage[cam,b4,center]{crop}


%% page styles
\def\titlemark#1{\markboth{#1}{#1}}%
\def\authormark#1{\markboth{#1}{#1}}%
\def\chaptermark#1{\markboth{#1}{#1}}%
\def\sectionmark#1{\markright{\ifnum\c@secnumdepth >\m@ne\textbf{\thesection}\hskip5pt\else\fi#1}}

\def\foliostyle{\reset@font\fontfamily{\sfdefault}\fontsize{11}{11}\selectfont\bfseries}
\def\rhheadstyle{\reset@font\fontfamily{\sfdefault}\fontsize{11}{11}\selectfont}

\def\ps@headings{\let\@mkboth\markboth%
\def\@evenhead{\vbox to 0pt{\raisebox{10pt}[0pt][0pt]{\llap{\rule{120.64pt}{8.5pt}}\rule{422pt}{0.35pt}}\par  
\hbox to \textwidth{\hskip-5pc\hbox to 5pc{\hfill{\foliostyle\thepage}\hskip23pt}\if@mainmatter{\foliostyle CHAPTER\space\thechapter\space}\else\fi\rhheadstyle\leftmark\hfill}}}
\def\@oddhead{\vbox to 0pt{\raisebox{10pt}[0pt][0pt]{\rlap{\rule{336pt}{0.35pt}\rule{120.64pt}{8.5pt}}}\par 
\hbox to \paperwidth{\hbox to \textwidth{\hfill\rhheadstyle\rightmark}\hbox to 6pc{\hskip23pt\foliostyle\thepage\hfill}}}}%
\def\@evenfoot{}%
\let\@oddfoot\@evenfoot}%
%
\def\ps@fmbmheadings{\let\@mkboth\markboth%
\def\@evenhead{\vbox to 0pt{%  
\hbox to \textwidth{\hskip-5pc\hbox to 5pc{\hfill{\foliostyle\thepage}\hskip23pt}\rhheadstyle\leftmark\hfill}}}
\def\@oddhead{\vbox to 0pt{\hbox to \paperwidth{\hbox to \textwidth{\hfill\rhheadstyle\rightmark}\hbox to 6pc{\hskip23pt\foliostyle\thepage\hfill}}}}%
\def\@evenfoot{}%
\let\@oddfoot\@evenfoot}%
%
\def\ps@plain{\let\@mkboth\markboth%
\def\@evenhead{}
\def\@oddhead{}
\def\@evenfoot{\hbox to \textwidth{\llap{\hbox to 28.5pt{\foliostyle\thepage\hfill}}}\hfill}%
\def\@oddfoot{\hbox to \textwidth{\hfill\rlap{\hbox to 5pc{\hskip24pt\foliostyle\thepage}}}}
%\begin{tabular}[b]{@{}r@{}}\textcopyright\ Elsevier Ltd.\\All rights reserved.\end{tabular}
}%

\def\ps@fmbmplain{\let\@mkboth\markboth%
\def\@evenhead{}
\def\@oddhead{}
\def\@evenfoot{\hbox to \textwidth{\llap{\hbox to 28.5pt{\foliostyle\thepage\hfill}}}\hfill}%
\def\@oddfoot{\hbox to \textwidth{\hfill\rlap{\hbox to 28.5pt{\hfill\foliostyle\thepage}}}}
}%

\def\ps@empty{\let\@mkboth\markboth%
\def\@evenhead{}%
\def\@oddhead{}%
\def\@evenfoot{}%
\def\@oddfoot{}%
}%

\pagestyle{headings}


%% Fonts & Sizes
\renewcommand\normalsize{%
\@setfontsize\normalsize{10bp}{12pt}%
\abovedisplayskip 6\p@ \@plus0\p@ \@minus0\p@%
\belowdisplayskip      \abovedisplayskip
\advance\belowdisplayskip by .3pt%
\abovedisplayshortskip \abovedisplayskip
\belowdisplayshortskip \abovedisplayskip
\let\@listi\@listI}%
\normalsize%

\renewcommand\small{%
   \@setfontsize\normalsize{8}{\@xpt}%
}%
%
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize{8.25bp}{10pt}%
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
}%
%
\def\footnoterule{\kern-2\p@%
\hrule \@height 0.5\p@ \@width\hsize
\kern4\p@}
%
\renewcommand\@makefntext[1]{\def\@makefnmark{\hbox{\textsuperscript{\normalfont\@thefnmark\space}}}%
    \parindent 12\p@
    \noindent
    \mbox{\@makefnmark}#1}%
%
\footnotesep 8\p@
\skip\footins=18pt % space added when footnote is present
%
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}
\renewcommand\tiny{\@setfontsize\tiny\@vpt\@vipt}
\renewcommand\large{\@setfontsize\large\@xipt{15}}
\renewcommand\Large{\@setfontsize\Large\@xiipt{16}}
\renewcommand\LARGE{\@setfontsize\LARGE\@xivpt{18}}
\renewcommand\huge{\@setfontsize\huge\@xxpt{30}}
\renewcommand\Huge{\@setfontsize\Huge{24}{36}}

%% Sections
\def\secfont{\fontfamily{\sfdefault}\fontsize{13.5bp}{14}\bfseries\selectfont}%
\def\subsecfont{\fontfamily{\sfdefault}\fontsize{12bp}{13}\bfseries\selectfont}%
\def\subsubsecfont{\fontfamily{\sfdefault}\fontsize{11bp}{12}\bfseries\itshape\selectfont}%
\def\parasecfont{\fontfamily{\sfdefault}\fontsize{10.75bp}{12}\selectfont}%
\def\runinheadfont{\fontfamily{\sfdefault}\fontsize{10bp}{12pt}\bfseries\itshape\selectfont}%
\def\subruninheadfont{\fontfamily{\sfdefault}\fontsize{10}{12pt}\bfseries\itshape\selectfont}%

\def\partouthdfont{\fontfamily{\sfdefault}\fontsize{10}{12pt}\bfseries\selectfont}%


\newif\if@Ahead\global\@Aheadfalse

\renewcommand\section{\global\@Aheadtrue\@startsection {section}{1}{\z@}%
           {-15\p@ \@plus -2\p@}%
           {6pt}%
           {\reset@font\secfont\raggedright}}%
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
           {-15\p@ \@plus -2\p@}%
           {6pt}%
           {\reset@font\subsecfont\raggedright}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
           {-12\p@ \@plus -2\p@}%
           {6pt}%
           {\reset@font\subsubsecfont\itshape\raggedright}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
           {-12\p@ \@plus -2\p@}%
           {3pt}%
       {\reset@font\parasecfont\raggedright}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\z@}%
           {-12\p@ \@plus -2\p@}%
           {-.5em}%
       {\reset@font\runinheadfont}}
\newcommand\runinhead{\@startsection{subparagraph}{6}{\parindent}%
           {0.0001pt}%
           {-.5em}%
       {\reset@font\subruninheadfont}}

\newcommand{\secauthor}[2][]{\def\@frstarg{#1}%
%\vskip-\@tempskipa%
\@afterindentfalse%
\ifx\@frstarg\empty\par\vskip-1.5pt{{\sffamily\bfseries\fontsize{9}{11}\selectfont#2\par}}\else%
\vskip-1pt#1\vskip6.5pt\par{{\sffamily\fontsize{9}{11}\selectfont\itshape#2\par}}\fi%
\vskip\@tempskipa\@afterheading}

\newif\if@partouthead\global\@partoutheadfalse%
\newcommand\partouthd{\global\@partoutheadtrue\@startsection{subparagraph}{6}{\z@}%
           {-12pt}%
           {6pt}%
       {\reset@font\partouthdfont}}


\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}

\def\@seccntformat#1{\csname the#1\endcsname\hskip.5em}
\def\@sbseccntformat#1{\csname the#1\endcsname:\hskip.5em}
%
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \ifnum #2=1%
       \protected@edef\@svsec{\textcolor{grayfifty}{\@seccntformat{#1}}\relax}%
    \else%
    \ifnum #2=2%
       \protected@edef\@svsec{\textcolor{grayfifty}{\@seccntformat{#1}}\relax}%
    \else%
       \protected@edef\@svsec{{\@seccntformat{#1}}\relax}%
    \fi\fi%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \ifnum#2=1\noindent\rule{\textwidth}{0.5pt}\par\vskip2pt\else\fi%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M \ifnum#2=1\MakeUppercase{#8}\else\ifnum#2=2\MakeUppercase{#8}\else\if@partouthead\MakeUppercase{#8}\else#8\par\fi\fi\fi\@@par%
          \if@partouthead\vskip-8.5pt\noindent\rule{\textwidth}{0.5pt}\par\vskip-1pt\else\fi}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec\ifnum#2=6\textcolor{grayfifty}{#8}\else#8.\fi}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}\global\@Aheadfalse}
%
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup\parskip\z@
      #4{%
        \if@Ahead\noindent\rule{\textwidth}{0.5pt}\par\vskip2pt\else\fi%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M \if@Ahead\MakeUppercase{#5}\else#5\fi\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5.}}%
  \fi
  \@xsect{#3}\global\@Aheadfalse}%
%
%% Pagination
\setlength\@fptop{\z@ }
\setlength\@fpsep{12\p@ }
\setlength\@fpbot{\z@ \@plus 1fil }
\def\textfraction{.01}
\def\floatpagefraction{.8}
\setlength{\intextsep}{20\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{24\p@ \@plus 2\p@ \@minus 4\p@}
\setcounter{topnumber}{4}
\def\topfraction{.9}
\setcounter{bottomnumber}{2}
\def\bottomfraction{.7}
\setcounter{totalnumber}{6}
\medmuskip=4mu%
\thickmuskip=5mu%
%
\emergencystretch=1pc
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\endinput

%%% Version 0.1
%%% Initial Released on 07/22/2015

%%% Version 0.2
%%% Released on 07/30/2016
%%% 1. apacite package added with template
%%% 2. alternate math 'v' introduced
%%% 3. all the bst files improved
%%% 4. customization for number of textbox in booksetup.sty 
