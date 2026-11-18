#import "@preview/touying:0.7.4": *
#import themes.dewdrop: *

#import "functions.typ": *

#import "@preview/numbly:0.1.0": numbly


#import "@preview/eggs:0.8.0": *
#import abbreviations: *
#show: eggs

#import "@preview/citesugar:0.2.0": *
#show cite: citesugar

#import "@preview/dtree:0.1.1": dtree as dtree-old
#let dtree(..args) = box(stroke: 2pt + gray, inset: (right: 9pt, rest: 0.5pt), radius: 0.5em, dtree-old(
  size: 1em,
  indent-width: 1em,
  ..args,
))

///
#import "@preview/fletcher:0.6.0" as fletcher: diagram, edge, node
#import "@preview/lilaq:0.6.0" as lq


///





#set text(lang: "en")

#set heading(numbering: none)

#set raw(lang: "typ")
#show link: it => if type(it.dest) == str { underline(it) } else { it } // because of header's page dots

//#show table.cell.where(y: 0): it => text(weight: "bold", it)
#set table(
  stroke: (x, y) => (
    top: if y <= 1 { 0.8pt } else { 0pt },
    bottom: 0.8pt,
  ),
  inset: (y: 8pt),
)



#show: dewdrop-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.title,
  navigation: "mini-slides",
  mini-slides: (linebreaks: false),
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
          v(1.5em),
        )
      }
      touying-slide(self: self, slide-body)
    }),
    //handout: true,
  ),
  config-info(
    title: [#typst for academic writing],
    subtitle: [An alternative for #LaTeX and Word],
    author: [Merlin Jonathan Fischer],
    date: datetime.today(),
    institution: link("https://github.com/Ikaluk/typst-presentation"),
    contact: [fischeme\@tcd.ie],

    logo: image("assets/Logo-Goethe-University-Frankfurt-am-Main.svg.png", height: 2cm),
  ),
  config-page(
    margin: (top: 3.5em, bottom: 2em, x: 2em),
  ),
)


/////////////////////////


#title-slide()

#outline-slide()

#bibliography("refs.bib", style: "unified-style-sheet-for-linguistics.csl")

= Useful packages
== numbly

#place(right + top, link("https://typst.app/universe/package/numbly"))

```
#import "@preview/numbly:0.1.0": numbly
#set heading(numbering: numbly(
  "Appendix {1:A}.",                // use {level:format} to specify the format
  "{1:A}.{2}.",      // if format is not specified, arabic numbers will be used
  "Step {3}.",                              // here, we only want the 3rd level
))

= Guide
== Installation
=== Download
=== Install
== Usage
```

#place(center + bottom, dx: 5em, dy: -1em, image("assets/image-12.png"))

== citesugar

#place(right + top, link("https://typst.app/universe/package/citesugar"))

#{
  set text(0.88em)
  grid(
    columns: (2fr, 1.1fr, 0.7fr),
    column-gutter: 1em,
    [
      ```

      // native citation:

      @oswald2022detection
      #cite(<oswald2022detection>, form: "prose")
      #cite(<oswald2022detection>, form: "author")
      #cite(<oswald2022detection>, form: "year")
      ```
      #v(-0.3em)
      #text(0.5em, `#cite(<oswald2022detection>, form: "author")~#cite(<oswald2022detection>, form: "year")`)\
      #text(0.5em, `#cite(<oswald2022detection>, form: "author")’s~(#cite(<oswald2022detection>, form: "year"))`)\
      #text(0.9em, `#cite(<oswald2022detection>, form: "author")’s`)
    ],
    pause,
    [
      #box(`#import "@preview/citesugar:0.2.0": *`, width: 14cm)
      #v(-0.7em)
      ```
      #show cite: citesugar

      @oswald2022detection
      @oswald2022detection[p:]
      @oswald2022detection[a:]
      @oswald2022detection[y:]
      @oswald2022detection[b:]
      @oswald2022detection[ps:]
      @oswald2022detection[as:]
      ```
    ],

    only("1-")[
      #v(3.5em)
      #set text(0.86em)
      @oswald2022detection\
      @oswald2022detection[p:]\
      @oswald2022detection[a:]\
      @oswald2022detection[y:]\
      @oswald2022detection[b:]\
      @oswald2022detection[ps:]\
      @oswald2022detection[as:]\
    ],
  )
}
== cetz
#place(right + top, link("https://typst.app/universe/package/cetz"))


#grid(
  columns: (1fr, 1fr, 1fr),
  align: center,
  {
    image("assets/image-14.png", width: 80%)
    image("assets/image-17.png", width: 73%)
  },
  {
    image("assets/image-15.png", width: 80%)
    image("assets/image-18.png", width: 86%)
  },
  {
    image("assets/image-16.png", width: 71%)
    image("assets/image-19.png", width: 80%)
  },
)


== fletcher
#place(right + top, link("https://typst.app/universe/package/fletcher"))




#grid(
  
  gutter: 1em,
  [`#import "@preview/fletcher:0.6.0" as fletcher: diagram, edge, node`],
  [
    #set text(0.8em)
    ```
  #let hom = edge.with(in-math: true)
  #diagram($
    G hom(f, ->) hom("d", pi, ->>) & im(f) \
    G slash ker(f) hom("ur", tilde(f), "hook-->")
  $)
  ```
  ],
  
  text(0.75em, ```
  #diagram(
    node-stroke: .1em,
    node-fill: gradient.radial(blue.lighten(90%), blue, center: (30%, 20%), radius: 80%),
    spacing: 4em,
    node((-0.85, 0),  `open(path)`, fill: none, stroke: none),      edge("-|>"),
    node((0, 0), `reading`, radius: 2em),      edge(`read()`, "-|>"),
    node((1, 0), `eof`, radius: 2em),      edge(`close()`, "-|>"),
    node((2, 0), `closed`, radius: 2em, extrude: (-2.5, 0)),
    edge((0, 0), `read()`, "--|>", loop: top, size: 3em),
    edge((0, 0), (2, 0), `close()`, "-|>", bend: -40deg),
  )
  ```),
)
#place(right + bottom, [
  #set text(0.5em)
  #diagram(
    node-stroke: .1em,
    node-fill: gradient.radial(blue.lighten(90%), blue, center: (30%, 20%), radius: 80%),
    spacing: 4em,
    node((-0.85, 0), `open(path)`, fill: none, stroke: none),
    edge("-|>"),
    node((0, 0), `reading`, radius: 2em),
    edge(`read()`, "-|>"),
    node((1, 0), `eof`, radius: 2em),
    edge(`close()`, "-|>"),
    node((2, 0), `closed`, radius: 2em, extrude: (-2.5, 0)),
    edge((0, 0), `read()`, "--|>", loop: top, size: 3em),
    edge((0, 0), (2, 0), `close()`, "-|>", bend: -40deg),
  )
])

#place(top+right, dy: 3em, [
  #let hom = edge.with(in-math: true)
  #diagram(
    spacing: 2em,
    $
      G hom(f, ->) hom("d", pi, ->>) & im(f) \
      G slash ker(f) hom("ur", tilde(f), "hook-->")
    $,
  )
])

== lilaq
#place(right + top, link("https://typst.app/universe/package/lilaq"))


#grid(
  columns: (1fr, auto),
  align: (left, right),
  gutter: 1em,
  ```
  #import "@preview/lilaq:0.6.0" as lq

  #lq.diagram(
    lq.plot((0, 1, 2, 3, 4), (3, 5, 4, 2, 3))
  )
  ```,
  {
    set text(0.6em)
    lq.diagram(
      lq.plot((0, 1, 2, 3, 4), (3, 5, 4, 2, 3)),
    )
  },

  [
    #set text(0.9em)
    ```
    #let x = lq.linspace(0, 10, num: 30)
    #lq.diagram( lq.stem(
      x,
      x.map(calc.cos),
      color: orange,
      mark: "d",
      base: -0.25,
      base-stroke: black,
    ) )
    ```
  ],
  [
    #set text(0.6em)
    #let x = lq.linspace(0, 10, num: 30)

    #lq.diagram(
      lq.stem(
        x,
        x.map(calc.cos),
        color: orange,
        mark: "d",
        base: -0.25,
        base-stroke: black,
      ),
    )
  ],
)


== touying

#columns(2)[
  ```
  #import "@preview/touying:0.8.0": *
  #import themes.simple: *

  #show: simple-theme.with(
    aspect-ratio: "16-9",
    footer: [Simple slides],
  )

  #title-slide[...]
  #outline-slide()

  = Section
  == New Slide
  #focus-slide[...]
  == Dynamic slides

  On slide 1 #pause

  Appears on slide 2

  #meanwhile Already on slide 1

  #uncover("1")[*Only* on slide 1]
  #only("2-3")[*Only* on slide 2-3]
  #alternatives[Slide 1][S. 2][S. 3]
  ```
  
  _works in maths, cetz, fletcher_
]



= Working setup


```
#import "@preview/eggs:0.6.0": *
#show: eggs.with(
  auto-judges: (),
)
#import abbreviations: *
#import "@preview/arborly:0.3.2": * // needs function "a"
#import "@preview/numbly:0.1.0": numbly
#import "citesugar.typ": *
#show cite: citesugar

#import "../functions.typ": *

#let autor = "Merlin Jonathan Fischer"
#let titel = "Wordhood of Noun Incorporation by Ph(r)ase in Inuit and Hindi"
#set document(author: autor, title: titel)
#let datum = datetime.today().display("[day].[month].[year]")


#set text(
  lang: "en",
  size: 11pt,
)

#set enum(full: true, numbering: numbly("{1:1.}", "{2:i.}"))

#set heading(numbering: "1.1")
#show heading: it => block(
  above: 2.2em,
  below: 1.5em,
  it,
)

#set page(
  margin: 2.5cm,
  numbering: "1",
  number-align: right,
)

#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => ( 
    top: if y <= 1 { 0.8pt } else { 0pt },
    bottom: 0.8pt
  ),
)
#show table: it => {
  set par(leading: 0.8em)
  it
}
#show figure.caption: it => {
  set par(leading: 0.8em)
  it
}

#let original_example(..args) = example(..args)
#let example(..args) = {
  set par(leading: 0.8em)
  original_example(..args)
}
#let hab = abbreviation[hab][habitual]

```

https://sitandr.github.io/typst-examples-book/book/

// delete unused images, packages
