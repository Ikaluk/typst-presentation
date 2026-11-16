#import "@preview/touying:0.7.4": *
#import themes.dewdrop: *

#import "functions.typ": *

#import "@preview/numbly:0.1.0": numbly


#import "@preview/eggs:0.8.0": *
#import abbreviations: *
#show: eggs

#import "@preview/citesugar:0.1.0": *
#show cite: citesugar

#set text(lang: "de")

#show: dewdrop-theme.with(aspect-ratio: "16-9",
  footer: self => self.info.title,
  navigation: "mini-slides",
  mini-slides: (linebreaks:false),
  config-common(
    datetime-format: "[day].[month].[year]",
    new-section-slide-fn: body => touying-slide-wrapper(self => {
      let slide-body = {
        set std.align(horizon)
        show: pad.with(20%)
        set text(size: 1.5em)
        stack(
          spacing: 0.5em,
          text(self.colors.neutral-darkest, utils.display-current-heading(
            level: 1,
            numbered: true,
          )),
          block(
            components.progress-bar(
              height: 2pt,
              self.colors.primary,
              self.colors.primary-light,
            ),
          ),
          v(1.5em)
        )
      }
      touying-slide(self: self, slide-body)
    }),
    //handout: true,
  ),
  config-info(
    title: [#typst für die Linguistik],
    subtitle: [Eine #LaTeX Alternative],
    author: [Merlin Jonathan Fischer],
    date: datetime.today(),
    institution: [Goethe Universität Frankfurt],
    contact: [fischer\@lingua.uni-frankfurt.de],

    logo: image("assets/Logo-Goethe-University-Frankfurt-am-Main.svg.png", height: 2cm),
  ),
  config-page(
		margin: (top: 3.5em, bottom: 2em, x: 2em),
	),
)

#set heading(numbering: none)

#set raw(lang: "typ")
#show link: it => if type(it.dest) == str { underline(it) } else { it }

#show table.cell.where(y: 0): it => text(20pt, weight: "bold", it)
#set table(
  stroke: (x, y) => ( 
    top: if y <= 1 { 0.8pt } else { 0pt },
    bottom: 0.8pt
  ),
  inset: (y: 8pt)
)

/////////////////////////


#title-slide()

#outline-slide()

= Einführung
==  <touying:hidden>
#grid(
  columns: (1fr, 1fr),
  gutter: 8pt, 
  [], 
  move(dy: -2.4em, text(size:18pt, raw("= Einführung")))
)

== Was ist #typst?

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt, 
  [
    #pause
    - Textsatzsystem
    #pause
    - wysiwym#footnote[what you see is what you mean]
    #pause
    - hochkonfigurierbares Satzlayout mit Fokus auf wissenschaftliche Publikationen
    #pause
    === Aber was ist anders?
    #pause
    + _einfache_ Anwendung durch *Markdown*
    #pause
    + einheitliche Syntax und Kompatibilität
    #pause
    + verständliche Fehlermeldungen
  ],
  move(dy: -2.5em, block[
    #set par(justify: false)
    #set text(size: 18pt)

    #meanwhile #raw("= Einführung") \ #v(4pt)
    #raw("== Was ist #typst?")\
    #only("2-", raw("- Textsatzsystem"))\
    #only("3-", raw("- wysiwym#footnote[what you see is what you mean]"))\ 
    #only("4-", raw("- hochkonfigurierbares Satzlayout mit Fokus auf wissenschaftliche Publikationen"))\ #v(4pt)
    #only("5-", raw("=== Aber was ist anders?"))\
    #only("6-", raw("+ _einfache_ Anwendung durch *Markdown*"))\
    #only("7-", raw("+ einheitliche Syntax und Kompatibilität"))\
    #only("8-", raw("+ verständliche Fehlermeldungen"))\
  ],)
)

== Formatierung

#grid(
  columns: (1fr, 0.1fr, 0.8fr),
  pause,
  [
    ```
    + _einfache_ Anwendung durch *Markdown*
    + einheitliche Syntax und Kompatibilität
    + verständliche Fehlermeldungen
    ```
  ],
  pause,
  {v(1em); math.arrow},
  pause,
  move(
    dy: -1.6em,
    alternatives[
      `#set text(font: "Calibri")`
      #set text(font: "Calibri")
      #set text(size: 17pt)

      + _einfache_ Anwendung durch *Markdown*
      + einheitliche Syntax und Kompatibilität
      + verständliche Fehlermeldungen
    ][
      `#set enum(numbering: "a.")`
      #set enum(numbering: "a.")
      #set text(size: 17pt)

      + _einfache_ Anwendung durch *Markdown*
      + einheitliche Syntax und Kompatibilität
      + verständliche Fehlermeldungen
    ][
      `#show emph: set text(fill: red)`
      #show emph: set text(fill: red)
      #set text(size: 17pt)

      + _einfache_ Anwendung durch *Markdown*
      + einheitliche Syntax und Kompatibilität
      + verständliche Fehlermeldungen
    ][
      `#show "Syntax": smallcaps`
      #show "Syntax": smallcaps
      #set text(size: 17pt)

      + _einfache_ Anwendung durch *Markdown*
      + einheitliche Syntax und Kompatibilität
      + verständliche Fehlermeldungen
    ]
  )
)

#pause
=== Seitenformatierung #pause
- `#set text(lang: "de", font: "Charter")` #pause
- `#set par(justify: true)` #pause
- `#set page(
  header: align(right)[TITELTITEL],
  numbering: "1"
)`

#place(
  bottom + right, dx: -3em, dy: 6em, {
    only("8", image("assets/t.png"))
    only("9", image("assets/t(1).png"))
    only("10", image("assets/t(2).png"))
    only("11", image("assets/t(4).png"))
  }
)


== Templates
#pause

- #link("https://typst.app/universe/")[Typst Universe] #pause
- Papers #pause
  - _cogsci-conference_ #pause
  - _athena-tu-darmstadt-thesis_ #pause
- CV #pause
  - _basic-resume_ #pause
- Präsentationen #pause
  - _touying_ #pause #pause #pause #pause
  - _diatypst_ #pause #pause
- Poster #pause
  - _peace-of-posters_ #pause #pause
  - _pollux_ #pause


#place(right + top, only("4", box(inset: (y: -3em), image("assets/cogsci.png", height: 1fr))))
#place(right + top, only("5", box(inset: (y: -3em), image("assets/tudapub_prev-01.png", height: 1fr))))
#place(right + top, only("7", box(inset: (y: -3em),  image("assets/example-resume.png", height: 1fr))))

#place(right + top, only("9", box(inset: (top: 1em), image("assets/image.png"))))
#place(right + top, only("10", box(inset: (top: 1em), image("assets/image-1.png"))))
#place(right + top, only("11", box(inset: (top: 1em), image("assets/image-2.png"))))
#place(right + top, only("12", box(inset: (top: 1em), image("assets/image-3.png"))))
#place(right + top, only("13", box(inset: (top: 1em), image("assets/image-4.png"))))
#place(right + top, only("14", box(inset: (top: 1em), image("assets/image-5.png"))))
#place(right + top, only("16", box(inset: (y: -2em), image("assets/image-6.png"))))
#place(right + top, only("17", box(inset: (y: -1em), image("assets/image-8.png"))))
#place(right + top, only("18", box(inset: (y: -2em), image("assets/image-9.png"))))



== Editoren

=== Web-Editor #pause
- #link("https://typst.app/") #pause
- *Live-Kompilierung* #pause
- unbegrenzte Kollaboration #pause
- Konverter von LaTeX, Word, Markdown #pause
- Click-to-source

#empty-slide(box(inset: (x: -2em,y:-2em),image("assets/image-11.png")))

#[
  #set text(gray)
=== #text(gray)[Web-Editor]
- #link("https://typst.app/")
- Live-Kompilierung
- unbegrenzte Kollaboration
- Konverter von LaTeX, Word, Markdown
- Click-to-source
]
=== #link("https://code.visualstudio.com/")[vscode]/#link("https://vscodium.com/")[vscodium] + #link("https://github.com/Myriad-Dreamin/tinymist")[tinymist] #pause
- alles wie in der WebApp #pause
- lokal, offline, selbst konfigurierbar #pause
- keine Rechtschreibprüfung #pause
- keine Package-Vorschläge


#empty-slide(box(inset: (x: -2em,y:-3.2em),image("assets/image-10.png")))


= Vergleich zu #LaTeX

== Präambel

#{
  set text(14pt)
  box(inset: (left: 10em, top: -3em), figure(
    table(
      columns: (1fr, 1.6fr),
      align: left,
      typst, LaTeX,
      pause,
      raw("Hallo Welt!", lang: "typ"),
      pause,
      {
        uncover("2-", raw("\documentclass{article}\n", lang: "tex"))
        only("3", text(11.5pt, weight: "bold", raw("\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{geometry} % edit margins of paper
\usepackage{setspace} % edit line spacing
\usepackage{fancyhdr} % header, footer
\usepackage{titlesec} % edit format of titles
\usepackage[dvipsnames]{xcolor} % colors
\usepackage{amsmath} % math tools
\usepackage{amssymb} % math symbols
\usepackage{amsthm} % thereoms
\usepackage{mathtools} % math tools
\usepackage{nameref}
\usepackage{hyperref}
\usepackage{cleveref}
\usepackage[shortlabels]{enumitem} % enumerations
\usepackage{lastpage} % get number of last page\n", lang: "tex")))
          uncover("2-", raw("\begin{document}
Hallo Welt!
\end{document}", lang: "tex"))
        },

    ))
  )
}



== Syntax

#figure(
  table(
    columns: (1fr, 1fr),
    align: left,
    inset: (y: 13pt),
    
    table.cell(inset: (y: 7pt), typst), table.cell(inset: (y: 7pt), LaTeX),
    [
      #pause
      Drei Modi:
      #v(-13pt)
      #grid(columns: 3, column-gutter: 1em, row-gutter: 0.5em, 
      pause,
      [1. Markup], `[...]`, `#let n = [*Typst!*]`,
      pause,
      [2. Code], `#...`, `#(1 + 2)`,
      pause,
      [3. Math], `$...$`, `$sqrt(-1)$ is $i$`,
      pause
      )
    ],
    {
      [Diverse Umgebungen & Makros für alles.\ ]
      pause
      raw(lang: "tex", "\begin{minipage}{...}...\end{minipage}\n")
      pause
      raw(lang: "tex", "\\newcommand{\cmd}{def}")
    },
    pause,
    [einheitliche, auf diese Modi basierende Syntax & Package-Kompatibilität],
    pause,
    [variierende Syntax in verschiedenen Paketen, unübersichtliche Argumente in `{}[]{}{}`],
    pause,
    [echte Programmiersprache: `#if, #for, #let`], 
    pause,
    [benötigt Pakete (`expl3`) für Scripting]
  )
)


== Grundfunktionen
#{
  show table.cell.where(x:1): set raw(lang: "tex")
  set text(size: 12pt)
  table(
    columns: (1fr, 1fr),
    align: left,
    
    table.header(typst, LaTeX,),
    [`*strong*` or `#strong[strong]`], [`\textbf{strong}`],
    [`_emphasis_` or `#emph[emphasis]`], [`\textit{emphasis}` or `\emph{emphasis}`],
    [#raw("`print(1)`") or `#raw("print(1)")`], [`\texttt{print(1)}`],
    [`https://typst.app/`], [`\url{https://typst.app/}`],
    [`<intro>`], [`\label{intro}`],
    [`@intro`], [`\ref{intro}`],
    [`@key`], [`\cite{key}`],
    [`= Heading`], [`\section{Heading}`],
    [`== Heading`], [`\subsection{Heading}`],
    [`=== Heading`], [`\subsubsection{Heading}`],
    [`- item`], [`\begin{itemize}\item...\end{itemize}`],
    [`+ item`], [`\begin{enumerate}\item...\end{enumerate}`],
    [`$x^2$`], [`$x^2$` (inline)],
    [`$ x^2 $`], [`\[x^2\]` or `\begin{equation}`],
    [`~`], [`~` (non-breaking space)],
    [`---`], [`---`],
    [`--`], [`--`],
    [`\`], [`\\`],
    [`// line comment`], [`% comment`],
    [`/* block comment */`], [(no equivalent)],
    [`#outline()`], [`\tableofcontents`],
    [`#footnote[...]`], [`\footnote{...}`],
    [`#bibliography("file.bib", style: "ieee")`], [`\bibliography{file}\bibliographystyle{plain}`],
    [`#underline[...]`], [`\underline{...}`],
    [`#upper[...]`], [`\uppercase{...}`],
    [`#text(fill: red)[...]`], [`\textcolor{red}{...}`],
    [`#highlight(fill: yellow)[...]`], [`\colorbox{yellow}{...}`],
    [`#set par(first-line-indent: 0pt)`], [`\noindent`],
    [`#pagebreak()`], [`\newpage`],
    [`#h(1cm)`], [`\hspace{1cm}`],
    [`#v(1cm)`], [`\vspace{1cm}`],
    [`#h(1fr)`], [`\hfill`],
    [`#v(1fr)`], [`\vfill`],
    [`#line(length: 100%)`], [`\hrule`],
    [`#quote[...]`], [`\begin{quote}...\end{quote}`],
    raw("```...```"), [`\begin{verbatim}...\end{verbatim}`],
    [`#figure(table(...))`], [`\begin{table}...\end{table}`],
    [`#figure(image(...))`], [`\begin{figure}...\end{figure}`],
    [`#image("img.png", width: 5cm)`], [`\includegraphics[width=5cm]{img}`],
    [`#box[...]`], [`\begin{minipage}{...}...\end{minipage}`],
    [`#box(stroke: 1pt)[...]`], [`\fbox{...}`],
    [`#box(width: 5cm)[...]`], [`\parbox{5cm}{...}`],
    [`#align(center)[...]`], [`\begin{center}...\end{center}`],
    [`#columns(2)[...]`], [`\begin{multicols}{2}...\end{multicols}`],
    [`#canvas[...] (via cetz)`], [`\begin{tikzpicture}...\end{tikzpicture}`],
    [`$ ... $ (block, with spaces)`], [`\begin{equation}...\end{equation}`],
    [`$ ... & ... \ $`], [`\begin{align}...\end{align}`],
    [`$cases(...)$`], [`\begin{cases}...\end{cases}`],
    [`$mat(...)$`], [`\begin{matrix}...\end{matrix}`],
    [`#show: ... or #let ...`], [`\renewcommand{\...}{...}`],
    [`#let x = ...`], [`\def\x{...}`],
    [`#include "file.typ"`], [`\input{file}`],
    [`#import "@preview/pkg:1.0.0": *`], [`\usepackage{pkg}`],
  )
}

== Tabellen

#{
  show table.cell.where(x:1): set raw(lang: "tex")
  
  table(
    columns: (1fr, 1.2fr),
    align: left,
    
    typst, {h(1.75em); LaTeX},
  `#table(
  columns: (1fr, 1fr),
  align: left,
  table.hline(),
  [*Header 1*], [*Header 2*],
  table.hline(),
  [Cell A], [Cell B],
  [Cell C], [Cell D],
  table.hline(),
)`,
  `
\begin{tabular}{ll}
  \hline
  \textbf{Header 1} & \textbf{Header 2} \\
  \hline
  Cell A & Cell B \\
  Cell C & Cell D \\
  \hline
\end{tabular}
  `,
    table.hline(),
  )
}

== Schreibumgebung
#table(
  columns: (1fr, 1fr),
  align: left,
  typst, LaTeX,
  pause,
  [inkrementelle Live-Kompilierung], [Pseudo-Live-Kompilierung mit Kompilierungslimit im Online-Editor],
  pause,
  [ungefähr verständliche Fehlermeldungen], [kryptische Fehlermeldungen],
  pause,
  [einheitliche Dokumentation], [viele dezentrale Dokumentationen]

)


== Verwendung im akademischen Bereich

#table(
  columns: (1fr, 1fr),
  align: left,
  typst, LaTeX,
  pause,
  table.cell(inset: (right: 1em))[Der #typst\-Quellcode wird bisher nur vom _International Journal of Interactive Multimedia and Artificial Intelligence (IJIMAI)_ akzeptiert.
  Bei einigen Journals können auch PDFs eingereicht werden.],
  [Der #LaTeX\-Quellcode wird von den allermeisten Journals und Konferenzen akzeptiert.],
  pause,
  [Alles ist möglich, gar nicht so kompliziert, manches ist noch in der Entwicklung.],
  [#LaTeX ist etabliert, es gibt zu allem Templates und Lösungen (auch wenn diese teilweise sehr kompliziert sind).]
)


= Packages für  die Linguistik
== eggs


- Linguistische Beispiele und Glossings (#link("https://raw.githubusercontent.com/typst/packages/main/packages/preview/eggs/0.8.0/documentation.pdf")[Dokumentation])
- Leipzig Glossing Abkürzungen
- Markdown für Judges
`#import "@preview/eggs:0.8.0": *
#import abbreviations: *
#show: eggs
`
#grid(columns: (1fr, 1fr),
  `#example[
  Beispiel
  + - Colorless  green
    - ideas sleep
  + furiously.
]
`,
example[
  Beispiel
  + - Colorless  green
    - ideas sleep
  + furiously.
]

)

== eggs <touying:hidden>

#{
  set text(15pt, lang: "en")

  `#example[
  @mohanan1995wordhood[77--78]
  + - ilaa  #emph[baccõ=ko] kʰojtii  rahtii  hai
    - Ila.#nom  children=#acc  search.#smallcaps[hab]  #prog  be.#prs
    'Ila keeps searching for the/some children.'
  + - ilaa  #emph[bacce]  kʰojtii  rahtii  hai
    - Ila.#nom  children.#nom  search.#smallcaps[hab]  #prog  be.#prs
    'Ila keeps children-searching (i.e. performing the act of searching for children).'
  ]
  `
  example[
    @mohanan1995wordhood[77--78]
    + - ilaa  #emph[baccõ=ko] kʰojtii  rahtii  hai
      - Ila.#nom  children=#acc  search.#smallcaps[hab]  #prog  be.#prs
      'Ila keeps searching for the/some children.'
    + - ilaa  #emph[bacce]  kʰojtii  rahtii  hai
      - Ila.#nom  children.#nom  search.#smallcaps[hab]  #prog  be.#prs
      'Ila keeps children-searching (i.e. performing the act of searching for children).'
  ]

}



== arborly


#import "@preview/arborly:0.3.2": *



#{
  set text(16pt)
  `#import "@preview/arborly:0.3.2": *

#tree(style: (fit: "band"), code: { agree("a1", "a2", 4) },
)[TP
  [#sym.nu\P
    [DP
      [NP [anil\ Anil #a(triangle: true)]]
      [P [=ne\ #erg]]
    ]
    [VP
      [DP
        [kitaabẽ\ books.#nom\ \[#pl.#f\] #a(triangle: true, name: "a1")]
      ]
      [V\ #strike(offset: -2.4pt)[bec-\ sell]]
    ]
  ]
  [T\ becĩĩ\ sold\ \[#emph(sym.phi.alt): #prf.#pl.#f\] #a(name: "a2")]
]
`
}
#place(top, dx: 15cm, dy: -1cm, 
tree(style: (fit: "band",text: (size: 15pt),), code: { agree("a1", "a2", 4) },
)[
  TP
  [
    #sym.nu\P
    [
      DP
      [NP [anil\ Anil #a(triangle: true)]]
      [P [=ne\ #erg]]
    ]
    [
      VP
      [
        DP
        [kitaabẽ\ books.#nom\ \[#pl.#f\] #a(triangle: true, name: "a1")]
      ]
      [V\ #strike(offset: -2.4pt)[bec-\ sell]]
    ]
  ]
  [T\ becĩĩ\ sold\ \[#emph(sym.phi.alt): #prf.#pl.#f\] #a(name: "a2")]
]
)

== IPA
#set text(18pt)

#pause
#grid(columns: (1fr, 1fr),
[=== Unicode (ohne Paket)],
[`ˌfoʊnəˈtɪʃən` #sym.arrow ˌfoʊnəˈtɪʃən]
)

#pause
=== tyipa
#import "@preview/tyipa:0.1.1" as ipa
`#import "@preview/tyipa:0.1.1" as ipa
#ipa.text[stress-mark.secondary f o upsilon n schwa stress-mark t I esh schwa n]` #sym.arrow #ipa.text[stress-mark.secondary f o upsilon n schwa stress-mark t I esh schwa n]

#pause
=== ascii-ipa
#import "@preview/ascii-ipa:2.1.0": *
#grid(
  columns: 3, 
  align: horizon,
  column-gutter: 10pt,

  `#import "@preview/ascii-ipa:2.1.0": *
#branner("'XU.X:i.,Xae)S:t.lI")
#cxs("'XU.X:i.,X&S:t.lI")
#praat("\\'1\\cf\\hs.\\cf\\:f.\\'2\\ae\\sh\\:ft.l\\ic")
#sil("}x=u<x=:i}}x=a<s=:tli=")
#xsampa("\"XUX:i%X{S:tlI")
  `,
  math.cases(reverse: true)[][][][][][],
  [ˈχʊ.χːi.ˌχæʃːt.lɪ]
)


#set text(20pt)
== Zitieren
#set text(19pt)
#[
  #set par(spacing: 0.8em)

#pause
=== Zitieren ohne Paket: ~ BibTeX, ~ #link("https://github.com/citation-style-language/styles/blob/master/unified-style-sheet-for-linguistics.csl")[Unified Style Sheet for Linguistics]
#pause
#grid(columns: 3, align: horizon, column-gutter: 10pt,
[
  - `#cite(<mohanan1995wordhood>, supplement: [101])`\
  - `@mohanan1995wordhood[101]`
],
math.cases(reverse: true)[][],
cite(<mohanan1995wordhood>, supplement: [101])
)
#pause
- `#cite(<mohanan1995wordhood>, supplement: [101], form: "prose")` #sym.arrow #cite(<mohanan1995wordhood>, supplement: [101], form: "prose")

#uncover("2-")[
`#bibliography("refs.bib", style: "unified-style-sheet-for-linguistics.csl")`]
]

#pause
=== citesugar

#grid(columns: 3, column-gutter: 25pt,
`#import "citesugar.typ": *
#show cite: citesugar
`,
`@mohanan1995wordhood
@mohanan1995wordhood[p:]
@mohanan1995wordhood[a:]
@mohanan1995wordhood[y:]
@mohanan1995wordhood[b:]
@mohanan1995wordhood[ps:]
@mohanan1995wordhood[as:]
`,
[
  #set text(16pt)
  @mohanan1995wordhood\
  @mohanan1995wordhood[p:]\
  @mohanan1995wordhood[a:]\
  @mohanan1995wordhood[y:]\
  @mohanan1995wordhood[b:]\
  @mohanan1995wordhood[ps:]\
  @mohanan1995wordhood[as:]\
],
)


#set text(20pt)
== phonokit

#import "@preview/phonokit:0.5.9": *
#phonokit-init(font: "New Computer Modern")

`#consonants("german", scale: 1.1)`
#consonants("german", scale: 1.1)

#pagebreak()

#grid(
columns: (1fr, 1fr),
align: horizon,
text(18pt, `#vowels(
  "english",
  arrows: (
    ("a", "U"),
    ("a", "I"),
    ("e", "I"),
    ("O", "I"),
    ("o", "U"),
  ),
  arrow-color: blue.lighten(60%),
  curved: true,
  highlight: ("a", "e", "o", "O"),
  highlight-color: blue.lighten(80%),
  scale: 1.1
)
`),
vowels(
  "english",
  arrows: (
    ("a", "U"),
    ("a", "I"),
    ("e", "I"),
    ("O", "I"),
    ("o", "U"),
  ),
  arrow-color: blue.lighten(60%),
  curved: true,
  highlight: ("a", "e", "o", "O"),
  highlight-color: blue.lighten(80%),
  scale: 1.1
)
)

#pagebreak()
`#word("('po.Ra).('man.pla)", foot: "R", scale: 1.4)`

#word("('po.Ra).('man.pla)", foot: "R", scale: 1.4)


#pagebreak()



`#tableau(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "*Complex"),
  violations: (
    ("", "", "*"),
    ("*!", "", ""),
    ("", "*!", ""),
  ),
  winner: 0,
  dashed-lines: (0,),
)`

#place(right+bottom,dy: -2cm, dx: -2cm, tableau(
  input: "kraTa",
  candidates: ("[kra.Ta]", "[ka.Ta]", "[ka.ra.Ta]"),
  constraints: ("Max", "Dep", "*Complex"),
  violations: (
    ("", "", "*"),
    ("*!", "", ""),
    ("", "*!", ""),
  ),
  winner: 0,
  dashed-lines: (0,),
)
)




== synkit

#import "@preview/synkit:0.0.4": *
#place(dx:0cm, dy:-2cm, tree(
  "[IP [IP [IP [IP [DP† [D the_2] [\\muP every woman] ] [IP [I] [VP is smiling] ] ] [IP [and] [IP [DP‡ [D the_2] [\\muP every man] ] [IP [I] [VP is frowning] ] ] ] ] [\\lambda2] ] [QP [Q \\forall ] [\\muP\\* [\\muP] [CP who came in together] ] ] ]",
  annotation: (
    (
      "IP1",
      [$forall$_y_ [_y_ is a woman+man $and$ _y_ came in together] $arrow$ \
        [the woman part of _y_ is smiling and the man part of _y_ is frowning]],
    ),
    (
      "IP2",
      [$lambda$_x_ : _x_ has a has a unique maximal woman part \
        and a unique maximal man part. \
        the woman part of x is smiling and \
        the man part of x is frowning],
    ),
    (
      "QP1",
      [$lambda$_Q_$forall$_y_[_y_ is woman+man \
        $and$ _y_ came in together] $arrow$ _Q(y)_],
    ),
    (
      "IP3",
      [the woman part of g(2) is smiling \
        and the man part of g(2) is frowning],
    ),
    (
      "DP†1",
      [the woman part \
        of g(2)],
    ),
    (
      "DP‡1",
      [the man part \
        of g(2)],
    ),
  ),
  annotation-size: 0.8,
  dominance: (
    (from: "muP4", to: "muP1", ctrl: (-6.1, 8.5)),
    (from: "muP4", to: "muP2", ctrl: (-6, 5)),
  ),
  scale: 1,
  spread: 0.8,
  terminal-branch: true,
))

#{
  set text(18pt)
  place(bottom, dx: 12.5cm, dy: -2.5cm, eg(labels: (<s-plain>, <s-move>))[
  - Who do you think saw Mary?
  - #move(
      "[CP Who do you think [(CP)[TP<who>saw Mary]]]",
      arrows: ((from: "who2", to: "who1", dash: "solid", color: black),),
    )
])
}



== Weitere, allgemeine Packages
#pause
- _cetz_: Zeichenpaket (#sym.equiv #LaTeX\: tikz) #pause
- _fletcher_ / _lilaq_: Diagramme zeichnen. #pause
- _mitex_: #LaTeX\-Code innerhalb von #typst ausführen. #pause

=== Konverter #LaTeX $<->$ #typst
#pause
- Typlite #pause
- Tylax

#pagebreak()

#bibliography("refs.bib", style: "unified-style-sheet-for-linguistics.csl",)


#focus-slide[
  Danke für Eure Aufmerksamkeit!
  #place(bottom + center, text(white)[`#focus-slide[Danke für Eure Aufmerksamkeit!]`])

]

//#focus-slide[
