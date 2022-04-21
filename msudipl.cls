\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{msudipl}[2021/11/16 MSU diploma class, v. 0.2.1]

%%	ОПИЦИИ КЛАССА msudipl
%%
%%	по умолчанию титульный лист компилируется как курсовая работа;
%%	bacw - для бакалаврских работ;
%%	magd - для магистерских диссертация;
%%	spec - для дипломов специалистов;
%%
%%	Ручное переопределение типа работы или, если оставить пустым - убирает тип работы с титульного листа вообще.
%%	
%%	\worktype{учебно-методическая работа} % на титульном листе тип работы будет УЧЕБНО-МЕТОДИЧЕСКАЯ РАБОТА
%%	\worktype{}  % на титульном листе не будет отображаться тип работы
%%
%%	Оформление литературы
%%	Доступно в основе своей несколько стилей ссылок по действующему ГОСТ Р 7.1-2008
%%	numeref - числом [N], список не сортируется, нумерация сплошная, в порядке упоминания (по умолчанию)
%%	footnotefer - сноской, в сноске краткие сведения, затекстовый список сортируется
%%	authoryear - [Фамилия, год], затекстовый список сортируется
%%	inlineref - (полная запись) - внутритекстовые записи, затекстовый список сортируется
%%	harvard - (Фамилия, год) - Harvard Ref Style, противоречит ГОСТу (всем версиям ГОСТ, начиная как минимум с ГОСТ 7.1-76, т.е. уже более 45 лет), затекстовый список будет не по ГОСТ, лучше не пользоваться (хотя ряд ... старых дубов требует именно так, но лучше переубеждать старые дубы, чем потакать их хотелкам)
%%	Источники сортируются по языку (и работает \iflitsort). 
%%	Язык указывается в записях в bib-файле в поле langid в каждой записи.
%%
%%
%%
%%	ТИТУЛЬНЫЙ ЛИСТ
%%	название факультета, можно использовать \par или \\ для красоты
%%	\facname{футурологический факультет}
%%	чтобы убрать название факультета с титульного листа использовать опцию класса nofac (исчезнет также и название кафедры)
%%
%%	название кафедры, можно использовать \par или \\ для красоты
%%	\kafname{кафедра вакуумной акустики}
%%
%%	тема ВКР
%%	\diplotitle{что я сделал со своей жизнью}
%%
%%	ФИО студента
%%	\author{Имяреков Имярек Имярекович}
%%
%%	группа
%%	\group{X14}
%%
%%	научники (пишем сколько их надо, редко больше одного, но чего только не бывает)
%%	\supervisor{Мимокрокодилов Антиох Рамзесович}
%%	\supervisor{Случайнопроходилов Киба Тутанхамонович}
%%
%%	Титульный лист продуцируется стандартной командой \maketitle
%%

\newif\ifmatheavy
\newif\ifbacw
\newif\ifmagd
\newif\ifspec
\newif\ifnofac
\newif\iffloatypics
\newif\iflitsort
\floatypicstrue

\DeclareOption{mmt}{\mmttrue}
\DeclareOption{bacw}{\bacwtrue}
\DeclareOption{magd}{\magdtrue}
\DeclareOption{spec}{\spectrue}
\DeclareOption{nofac}{\nofactrue}
\DeclareOption{notfloat}{\floatypicsfalse}
\DeclareOption{numeref}{\litsortfalse\PassOptionsToPackage{style=gost-numeric,backend=biber,natbib=true,sorting=none,autolang=other}{biblatex}}
\DeclareOption{authoryear}{\litsorttrue\PassOptionsToPackage{style=gost-authoryear,backend=biber,natbib=true,sorting=nyt,autolang=other}{biblatex}}
\DeclareOption{footnoteref}{\litsortfalse\PassOptionsToPackage{citestyle=gost-footnote-min,bibstyle=gost-footnote,backend=biber,natbib=true,sorting=none,autolang=other}{biblatex}}
\DeclareOption{inlineref}{\litsorttrue\PassOptionsToPackage{citestyle=gost-inline-min,bibstyle=gost-inline,backend=biber,natbib=true,sorting=nyt,autolang=other}{biblatex}}
\DeclareOption{harvard}{\litsorttrue\PassOptionsToPackage{style=authoryear-icomp,backend=biber,natbib=true,sorting=nyt,autolang=other}{biblatex}}

\DeclareOption*{
	\PackageWarning{msudipl}{Unknown option ‘\CurrentOption’}%
}
\ProcessOptions\relax

% проверка совместимости опций
\ifmagd
  \ifbacw
    \ClassError{msudipl}{Несовместимые опции bacw и magd}{Опции bacw и magd несовместимы, \MessageBreak оставьте только одну, \MessageBreak нужную вам согласно типу ВКР:\MessageBreak bacw для бакалаврской работы,\MessageBreak magd для магистерской диссертации,\MessageBreak spec для диплома специалиста или\MessageBreak ни одну из этих опций для курсовой работы}
  \fi
  \ifspec
    \ClassError{msudipl}{Несовместимые опции magd и spec}{Опции spec и magd несовместимы, \MessageBreak оставьте только одну, \MessageBreak нужную вам согласно типу ВКР:\MessageBreak bacw для бакалаврской работы,\MessageBreak magd для магистерской диссертации,\MessageBreak spec для диплома специалиста или\MessageBreak ни одну из этих опций для курсовой работы}
  \fi
\fi

\ifbacw
  \ifspec
    \ClassError{msudipl}{Несовместимые опции bacw и spec}{Опции bacw и magd несовместимы, \MessageBreak оставьте только одну, \MessageBreak нужную вам согласно типу ВКР:\MessageBreak bacw для бакалаврской работы,\MessageBreak magd для магистерской диссертации,\MessageBreak spec для диплома специалиста или\MessageBreak ни одну из этих опций для курсовой работы}
  \fi
\fi

\LoadClass{report}

% размеры страницы и полей
\RequirePackage{geometry}
\geometry{a4paper}					% размер бумаги A4
\geometry{left=30mm,right=10mm,top=20mm,bottom=20mm}	% поля по ГОСТ 7.32-2001

% подгрузка пакетов для корректного и наиболее полного отображения формул и символов. должен грузиться как можно раньше, т.к. внутри себя определяет шрифты и некоторые прочие настройки, которые несколько не соответствуют тому, что надо.
\RequirePackage{amsmath}

\ifmatheavy
	\RequirePackage{amsthm}				% пакет для работы с теоремами и леммами
	\RequirePackage{amssymb} 			% большое количество специфических математических символов
\fi

\everymath{\displaystyle}				% отключаем масштабирование символов в многоэтажных дробях, индексах и пределах интегралов в соответствии с традицией русской типографской вёрстки
\DeclareMathSizes{14}{14}{10}{10}    			% увеличенные размеры символов в формулах (синтаксис {елси не векторный шрифт}{основной текст}{верхний индекс}{нижний индекс})

\RequirePackage[T2A]{fontenc}				% подгрузка расширенной поддержки кириллических шрифтов
\RequirePackage[utf8]{inputenc}				% прямым текстом указываем, в какой кодировке работаем (UTF8), применение других кодировок (cp1251 или koi8r) вполне допустимо, но не рекомендуемо (cp866 можно, но зачем?)
\RequirePackage[english,russian]{babel}			% указываем, что пользоваться будем русским языком, подгружающая словари переносов, выставляются в соответствии с принятыми нормами отступы, интервалы между словами и пр., а иногда и английским.

\IfFileExists{pscyr.sty}{\RequirePackage{pscyr}}{
\RequirePackage{fontspec}
\usepackage{ dsfont }
\setmainfont{Times New Roman}}		% проверка, установлен ли в системе pscyr (очень рекомендуется!), если нет, то 
%\renewcommand{\rmdefault}{cmr}				% установка начертания типа Times New Roman или очень похожего
\DeclareSymbolFont{operators}{OT1}{\rmdefault}{m}{n}
\SetSymbolFont{operators}{normal}{OT1}{\rmdefault}{x}{n}	% переключаем шрифт начертания операторов и цифр (они в душе тоже операторы) на ту же нарнитуру, что и основной текст


\RequirePackage{indentfirst}				% заставляет ТеХ делать отступ в первом абзаце главы/параграфа/раздела
\setlength{\parindent}{1.25cm}				% настройка отступов
\RequirePackage{graphicx}				% Подключаем пакет работы с графикой

%увеличение шрифта с 12 pt по умолчанию, на 14 pt и полуторный интервал!
\renewcommand{\tiny}{\fontsize{7}{10.5pt}\selectfont}
\renewcommand{\scriptsize}{\fontsize{9}{13.5pt}\selectfont}
\renewcommand{\footnotesize}{\fontsize{12}{18pt}\selectfont}
\renewcommand{\small}{\fontsize{12}{18pt}\selectfont}
\renewcommand{\normalsize}{\fontsize{14}{21pt}\selectfont}
\renewcommand{\large}{\fontsize{17}{25.5pt}\selectfont}
\renewcommand{\Large}{\fontsize{20}{30pt}\selectfont}
\newcommand{\sectitlesize}{\fontsize{16}{24pt}\selectfont}
\newcommand{\chaptersize}{\fontsize{18}{27pt}\selectfont}

\RequirePackage{appendix} %управление стилями загловков в приложениях

%% ОФОРМЛЕНИЕ ТЕКСТА
% Нумерация списков строго вида 1.1.1.1
\RequirePackage{enumitem}
\renewcommand*{\labelenumi}{\arabic{enumi}.} 
\renewcommand*{\labelenumii}{\arabic{enumi}.\arabic{enumii}}
\renewcommand*{\labelenumiii}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}}
\renewcommand*{\labelenumiv}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}.\arabic{enumiv}}

\setcounter{secnumdepth}{5}				% по правилам нумеруются все заголовки вплоть до пунктов, так что выставляется максимальная доступная без копания под капотом глубина нумерации

\counterwithin*{footnote}{page}				% сброс нумерации сносок на каждой странице, требования такие

%% ОФОРМЛЕНИЕ ОГЛАВЛЕНИЯ
\setcounter{tocdepth}{1}				% Оглавлении будут только главы и параграфы, но не будет мелких заголовков. Для дипломов нормально, для диссертаций стоит поднять до 2.

%% Для корректного оформления иллюстраций, чтобы каждый раз не вызывать \afterpage{\clearpage}
\RequirePackage{afterpage}
\iffloatypics
	\NewCommandCopy{\ordref}{\ref}
	\renewcommand*{\ref}[1]{\oldref{#1}\afterpage{\clearpage}}
\fi

\sloppy   						% убираем висячие строки  и подобное безобразие
\clubpenalty=10000					% Запрещаем разрыв страницы после первой строки абзаца
\widowpenalty=10000					% Запрещаем разрыв страницы перед последней строкой абзаца


%%
\RequirePackage[hidelinks]{hyperref}			% позволяет сделать в полученной PDFке рабочими ссылки как в оглавлении, так и в списке литературы и вообще в тексте
\RequirePackage{tocloft}				% управление стилем оглавления
\renewcommand{\cftchapdotsep}{\cftdotsep}		% точки в оглалении между названиями глав и номерами страниц (по умолчанию их нет)

%% ОФОРМЛЕНИЕ ССЫЛОК И ЛИТЕРАТУРЫ
\RequirePackage{biblatex}

%% РУЧНОЕ ПЕРЕОПРЕДЕЛЕНИЕ ТИПОВ ЗАГОЛОВКОВ

\renewcommand\chapter{\clearpage
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \@makechapterhead{#2}%
                    \@afterheading
}
                   
\def\@makechapterhead#1{%
%  \vspace*{20\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \centering \chaptersize \bfseries \@chapapp\space \thechapter.
       % \par\nobreak
       % \vskip 00\p@
    \fi
    \interlinepenalty\@M
    \chaptersize \bfseries #1 \par\nobreak
    \vskip 20\p@
  }}
\def\@schapter#1{ \@makeschapterhead{#1}%
                   \@afterheading
                 }
\def\@makeschapterhead#1{%
  \vspace*{20\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \centering \chaptersize \bfseries  #1%\par\nobreak
    \vskip 20\p@
  }}
      \renewcommand\section{\@startsection {section}{1}{\z@}%
                                      {-3.5ex \@plus -1ex \@minus -.2ex}%
                                      {.5ex \@plus .1ex}%
                                      {\normalfont\sectitlesize\bfseries}}

   \renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                      {-2ex \@plus -1ex \@minus -.2ex}%
                                      {.5ex \@plus .1ex}%
                                      {\normalfont\normalsize\bfseries\itshape}}

\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                      {-1.5ex \@plus -1ex \@minus -.2ex}%
                                      {.5ex \@plus .2ex}%
                                      {\normalfont\normalsize}}

    \renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                      {-1.5ex \@plus -1ex \@minus -.2ex}%
                                      {-0.5em}%
                                      {\normalfont\normalsize\itshape}}

 \renewcommand\subparagraph{\@startsection{subparagraph}{5}{\z@}%
                                      {-1.5ex \@plus -0ex \@minus -.0ex}%
                                      {-.0em}%
                                      {\normalfont\normalsize}}


%% ТИТУЛЬНЫЙ ЛИСТ подготовка
\RequirePackage{textcase}

\newcommand*{\facname}[1]{\gdef\@facname{#1}}
\newcommand*{\@facname}{футурологический факультет}
\newcommand*{\kafname}[1]{\gdef\@kafname{#1}}
\newcommand*{\@kafname}{кафедра вакуумной акустики}
\newcommand*{\worktype}[1]{\gdef\@worktype{#1}}
\newcommand*{\@worktype}{курсовая работа}

\ifbacw
	\worktype{бакалаврская работа}
\fi

\ifmagd
	\worktype{магистерская диссертация}
\fi	

\ifspec
	\worktype{дипломная работа}
\fi	

\newcommand*{\diplotitle}[1]{\gdef\@diplotitle{#1}}
\newcommand*{\@diplotitle}{О влиянии лунного света на рельсы}
\newcommand*{\group}[1]{\gdef\@group{#1}}
\newcommand*{\@group}{XXX}

\newcounter{supernum}
\newcommand*{\supervisorstring}{}
\newcommand*{\supervisor}[1]{\stepcounter{supernum}\expandafter\def\expandafter\supervisorstring\expandafter{\supervisorstring{\raggedleft#1\hspace{2cm}\ \par}\vspace{7pt}{\raggedleft \rule{4.25cm}{1pt}\hspace{2cm}\ \par}}}


%% СОБСТВЕННО ТИТУЛЬНЫЙ ЛИСТ
\renewcommand*{\maketitle}{
\renewcommand{\normalsize}{\fontsize{14}{16.8pt}\selectfont}
\begin{titlepage}
{\centering
ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ БЮДЖЕТНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ \\<<МОСКОВСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ\\
имени М.\,В.\,ЛОМОНОСОВА>>\par}
\ifnofac
\else
    \vspace{16.8pt}
    {\centering\MakeTextUppercase{\@facname}\par}
    \vspace{16.8pt}
    {\centering\MakeTextUppercase{\@kafname}\par}
\fi
\vspace{\fill}
{\centering\MakeTextUppercase{\@worktype}\par}
\vspace{16.8pt}
{\centering\bfseries\MakeTextUppercase{\@diplotitle}\par}
\vfill
{\raggedleft Выполнил студент\hspace{2cm}\ \par}
{\raggedleft \@group\ группы\hspace{2cm}\ \par}
{\raggedleft \@author\hspace{2cm}\ \par}
\vspace{7pt}
{\raggedleft \rule{4.25cm}{1pt}\hspace{2cm}\ \par}
\vspace{16.8pt}
\ifnum \thesupernum > 1 
    {\raggedleft Научные руководители\hspace{2cm}\ \par}
\else
    {\raggedleft Научный руководитель\hspace{2cm}\ \par}
\fi

\vspace{7pt}
\supervisorstring\par
\vspace{\fill}
{\raggedright Допущена к защите\ \rule{3cm}{1pt}\par}
\vspace{7pt}
{\raggedright Зав. кафедрой\ \rule{4.25cm}{1pt}\par}
\vspace{-7pt}
{\raggedright\hspace{4.5cm}\footnotesize (подпись)\par}

\vspace{\fill}

{\centering Москва\par2022\par}

\end{titlepage}

\renewcommand{\normalsize}{\fontsize{14}{21pt}\selectfont}
}