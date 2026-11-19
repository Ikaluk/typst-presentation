#import "@preview/touying:0.7.4": *
#import themes.dewdrop: *

#import "@preview/numbly:0.1.0": numbly

#import "@preview/eggs:0.8.0": *
#import abbreviations: *
#show: eggs

#import "@preview/citesugar:0.1.0": *
#show cite: citesugar

#import "@preview/dtree:0.1.1": dtree as dtree-old
#let dtree(..args) = box(stroke: 2pt + gray, inset: (right: 9pt, rest: 0.5pt), radius: 0.5em, dtree-old(
  size: 1em,
  indent-width: 1em,
  ..args,
))

#import "@preview/fletcher:0.6.0" as fletcher: diagram, edge, node
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/booktyps:0.1.1": booktabs

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


#let typst = {
  set text(
    size: 1.05em,
    font: "Buenard",
    weight: "bold",
    fill: rgb("#239dad"),
  )
  box({
    text("t")
    text("y")
    h(0.035em)
    text("p")
    h(-0.025em)
    text("s")
    h(-0.015em)
    text("t")
  })
}

#let LaTeX = {
  let A = (
    offset: (
      x: -0.33em,
      y: -0.3em,
    ),
    size: 0.7em,
  )
  let T = (
    x_offset: -0.12em,
  )
  let E = (
    x_offset: -0.2em,
    y_offset: 0.23em,
    size: 1em,
  )
  let X = (
    x_offset: -0.1em,
  )
  [L#h(A.offset.x)#text(size: A.size, baseline: A.offset.y)[A]#h(T.x_offset)T#h(E.x_offset)#text(size: E.size, baseline: E.y_offset)[E]#h(X.x_offset)X]
}


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

= Introduction

== What is #typst?

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  [
    #pause
    - typesetting programme for documents
    #pause
    - wysiwym#footnote[what you see is what you mean]
    #pause
    - highly customisable typesetting layout with a focus on academic publications
    #pause
    === But what is different?
    #pause
    + _easy_ to use thanks to *markdown*
    #pause
    + consistent syntax and compatibility
    #pause
    + clear error messages
    #pause
    + instant compilation
  ],
  place(dy: -2.5em, block[
    #set par(justify: false)
    #set text(size: 18pt)

    #meanwhile #raw("= Introduction") \ #v(4pt)
    #raw("== Was ist #typst?")\
    #only("2-", raw("- typesetting programme for documents"))\
    #only("3-", raw("- wysiwym#footnote[what you see is what you mean]"))\
    #only("4-", raw("- highly customisable typesetting layout with a focus on academic publications"))\ #v(4pt)
    #only("5-", raw("=== But what is different?"))\
    #only("6-", raw("+ _easy_ to use thanks to *markdown*"))\
    #only("7-", raw("+ consistent syntax and compatibility"))\
    #only("8-", raw("+ clear error messages"))\
    #only("9-", raw("+ instant compilation"))\
  ]),
)


== Images

#place(right + top, align(left, dtree(```
presentation/
  assets/
    sheep.png
  fill=eastern | main.pdf
  fill=eastern | main.typ
```)))

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  [
    #only("1", image("assets/sheep.png"))
    #only("2", image("assets/sheep.png", width: 10cm))
    #only("3-", [
      #figure(
        image("assets/sheep.png", width: 10cm),
        caption: [Is caora álainn í seo.],
      ) <sheep>
    ])
    #only("4", [There's a beautiful sheep in Figure~1.])
  ],
  [
    #v(8em)
    #only("1", raw("\n #image(\"assets/sheep.png\")"))
    #only("2", box(width: 14cm, raw("\n #image(\"assets/sheep.png\", width: 10cm)")))
    #only("3-", box(
      ``` #figure(
        image("assets/sheep.png", width: 10cm),
        caption: [Is caora álainn í seo.]
      ) <sheep>


      ```,
      width: 14cm,
    ))
    #only("4", `There's a beautiful sheep in @sheep.`)
  ],
)

== Tables

#grid(
  columns: (1fr, 1.5fr),
  column-gutter: 1em,
  [
    #only(1, table(
      columns: 3,
      stroke: 1pt,

      [Animal], [Sound], [Verb],
      [Bee], [buzz], [buzz],
      [Cat], [meow], [meow],
      [Dog], [woof], [bark],
      [Fish], [blub], [bubble],
      [Parrot], [_[talk]_], [squawk],
      [Sheep], [baa, meh], [bleat],
    ))
    #only(2, table(
      columns: 3,
      stroke: none,

      [Animal], [Sound], [Verb],
      [Bee], [buzz], [buzz],
      [Cat], [meow], [meow],
      [Dog], [woof], [bark],
      [Fish], [blub], [bubble],
      [Parrot], [_[talk]_], [squawk],
      [Sheep], [baa, meh], [bleat],
    ))
    #only(3, table(
      columns: 3,
      stroke: none,

      [Animal], table.vline(), [Sound], [Verb],
      table.hline(),
      [Bee], [buzz], [buzz],
      [Cat], [meow], [meow],
      [Dog], [woof], [bark],
      [Fish], [blub], [bubble],
      [Parrot], [_[talk]_], [squawk],
      [Sheep], [baa, meh], [bleat],
    ))
    #only(4, table(
      columns: 3,
      stroke: none,
      align: center,
      [Animal], table.vline(), [Sound], [Verb],
      table.hline(),
      [Bee], [buzz], [buzz],
      [Cat], [meow], [meow],
      [Dog], [woof], [bark],
      [Fish], [blub], [bubble],
      [Parrot], [_[talk]_], [squawk],
      [Sheep], [baa, meh], [bleat],
    ))
    #only(5, table(
      columns: 3,
      stroke: none,
      align: center,
      [Animal], table.vline(), [Sound], [Verb],
      table.hline(),
      [Bee], table.cell(colspan: 2)[buzz],
      [Cat], table.cell(colspan: 2)[meow],
      [Dog], [woof], [bark],
      [Fish], [blub], [bubble],
      [Parrot], [_[talk]_], [squawk],
      [Sheep], [baa, meh], [bleat],
    ))
    #only(6, figure(
      table(
        columns: 3,
        stroke: none,

        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], table.cell(colspan: 2)[buzz],
        [Cat], table.cell(colspan: 2)[meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      ),
      caption: [Animal sounds.],
    ))
    #only(7, figure(
      table(
        columns: 3,
        stroke: none,
        align: left,
        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], table.cell(colspan: 2, align(center)[buzz]),
        [Cat], table.cell(colspan: 2, align(center)[meow]),
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      ),
      caption: [Animal sounds.],
    ))
    #only(8, figure(
      table(
        columns: (1fr, 1fr, 1fr),
        stroke: none,
        align: (left, center, center),
        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], table.cell(colspan: 2)[buzz],
        [Cat], table.cell(colspan: 2)[meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      ),
      caption: [Animal sounds.],
    ))
    #only(9, [#figure(
        table(
          columns: (1fr, 1fr, 1fr),
          stroke: none,
          align: (left, center, center),
          [Animal], table.vline(), [Sound], [Verb],
          table.hline(),
          [Bee], table.cell(colspan: 2)[buzz],
          [Cat], table.cell(colspan: 2)[meow],
          [Dog], [woof], [bark],
          [Fish], [blub], [bubble],
          [Parrot], [_[talk]_], [squawk],
          [Sheep], [baa, meh], [bleat],
        ),
        caption: [Animal sounds.],
      ) <animal-sounds2>

      See @animal-sounds2 for animal sounds.
    ])
  ],
  move(dy: -2em)[
    #set text(0.9em)
    #only(1, ```

      #table(
        columns: 3,
        

        [Animal], [Sound], [Verb],

        [Bee], [buzz], [buzz],
        [Cat], [meow], [meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      )
    ```)
    #only(2, ```

      #table(
        columns: 3,
        stroke: none,

        [Animal], [Sound], [Verb],

        [Bee], [buzz], [buzz],
        [Cat], [meow], [meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      )
    ```)
    #only(3, ```

      #table(
        columns: 3,
        stroke: none,

        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], [buzz], [buzz],
        [Cat], [meow], [meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      )
    ```)
    #only(4, ```

      #table(
        columns: 3,
        stroke: none,
        align: center,
        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], [buzz], [buzz],
        [Cat], [meow], [meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      )
    ```)
    #only(5, ```

      #table(
        columns: 3,
        stroke: none,
        align: center,
        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], table.cell(colspan: 2)[buzz],
        [Cat], table.cell(colspan: 2)[meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      )
    ```)
    #only(6, ``` #figure(
      table(
        columns: 3,
        stroke: none,

        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], table.cell(colspan: 2)[buzz],
        [Cat], table.cell(colspan: 2)[meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      ),
      caption: [Animal sounds.],
    )```)
    #only(7, box(
      ``` #figure(
        table(
          columns: 3,
          stroke: none,
          align: left,
          [Animal], table.vline(), [Sound], [Verb],
          table.hline(),
          [Bee], table.cell(colspan: 2, align(center)[buzz]),
          [Cat], table.cell(colspan: 2, align(center)[meow]),
          [Dog], [woof], [bark],
          [Fish], [blub], [bubble],
          [Parrot], [_[talk]_], [squawk],
          [Sheep], [baa, meh], [bleat],
        ),
        caption: [Animal sounds.],
      )```,
      width: 17cm,
    ))
    #only(8, ``` #figure(
      table(
        columns: (1fr, 1fr, 1fr),
        stroke: none,
        align: (left, center, center),
        [Animal], table.vline(), [Sound], [Verb],
        table.hline(),
        [Bee], table.cell(colspan: 2)[buzz],
        [Cat], table.cell(colspan: 2)[meow],
        [Dog], [woof], [bark],
        [Fish], [blub], [bubble],
        [Parrot], [_[talk]_], [squawk],
        [Sheep], [baa, meh], [bleat],
      ),
      caption: [Animal sounds.],
    )```)
    #only(9, place[``` #figure(
        table(
          columns: (1fr, 1fr, 1fr),
          stroke: none,
          align: (left, center, center),
          [Animal], table.vline(), [Sound], [Verb],
          table.hline(),
          [Bee], table.cell(colspan: 2)[buzz],
          [Cat], table.cell(colspan: 2)[meow],
          [Dog], [woof], [bark],
          [Fish], [blub], [bubble],
          [Parrot], [_[talk]_], [squawk],
          [Sheep], [baa, meh], [bleat],
        ),
        caption: [Animal sounds.],
      ) <animal-sounds>

      See @animal-sounds for animal sounds.```
    ])
  ],
)

== Bibliography

#only(1, place(left + top, dy: 2em, text(1em, box(
  ```bib
  @article{oswald2022detection,
    title={Detection and classification methods for 
            animal sounds},
    author={Oswald, Julie N. and Erbe, Christine and 
            Gannon, William L. and Madhusudhana, Shyam and 
            Thomas, Jeanette A.},
    journal={Exploring animal behavior through sound},
    volume={1},
    pages={269--317},
    year={2022},
    publisher={Springer},
    address={Cham}
  } ```,
))))

#only(1, place(right + top, align(left, dtree(```
presentation/
  fill=gray | assets/
    fill=gray | sheep.png
  main.pdf
  main.typ
  fill=eastern | refs.bib
```))))
#only("2-5", place(right + top, align(left, dtree(```
presentation/
  fill=gray|assets/
    fill=gray|sheep.png
  fill=eastern | main.pdf
  fill=eastern | main.typ
  refs.bib
```))))
#only("6-", place(right + top, align(left, dtree(```
presentation/
  fill=gray|assets/
    fill=gray|sheep.png
  fill=eastern | main.pdf
  fill=eastern | main.typ
  refs.bib
  ussl.csl
```))))

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  [
    #only(2, [
      \ \ \ \

      *#text(1.4em)[Bibliography]*
      #bibliography("refs.bib", title: none)
    ])
    #only(3, [
      "Frequently, researchers describe and name animal
      sounds based on their perception of the sound and
      thus based on their own language."

      *#text(1.4em)[Bibliography]*
      #bibliography("refs.bib", title: none)
    ])
    #only(4, [
      "Frequently, researchers describe and name animal
      sounds based on their perception of the sound and
      thus based on their own language." @oswald2022detection

      *#text(1.4em)[Bibliography]*
      #bibliography("refs.bib", title: none)
    ])
    #only(5, [
      "Frequently, researchers describe and name animal
      sounds based on their perception of the sound and
      thus based on their own language." @oswald2022detection

      *#text(1.4em)[Bibliography]*
      #bibliography("refs.bib", title: none, style: "apa")
    ])
    #only(6, [
      "Frequently, researchers describe and name animal
      sounds based on their perception of the sound and
      thus based on their own language." @oswald2022detection

      *#text(1.4em)[Bibliography]*
      #bibliography("refs.bib", title: none, style: "unified-style-sheet-for-linguistics.csl")
    ])
    #only(7, [
      #cite(<oswald2022detection>, form: "prose") claim that researchers describe and name animal sounds based on their perception of the sound and thus based on their own language.

      *#text(1.4em)[Bibliography]*
      #bibliography("refs.bib", title: none, style: "unified-style-sheet-for-linguistics.csl")
    ])
  ],
  [
    #only(2, [
      ```










      #bibliography("refs.bib")```
    ])
    #only(3, [
      ``` "Frequently,
      researchers 
      describe and name 
      animal sounds 
      based on their 
      perception of the 
      sound and thus 
      based on their 
      own language."

      #bibliography("refs.bib")```
    ])
    #only(4, [
      ``` "Frequently,
      researchers 
      describe and name 
      animal sounds 
      based on their 
      perception of the 
      sound and thus 
      based on their 
      own language." @oswald2022detection

      #bibliography("refs.bib")```
    ])
    #only(5, box(width: 15cm)[
      ``` "Frequently,
      researchers 
      describe and name 
      animal sounds 
      based on their 
      perception of the 
      sound and thus 
      based on their 
      own language." @oswald2022detection

      #bibliography("refs.bib", style: "apa")```
    ])
    #only(6, box(width: 14cm)[
      ``` "Frequently,
      researchers 
      describe and name 
      animal sounds 
      based on their 
      perception of the 
      sound and thus 
      based on their 
      own language." @oswald2022detection

      #bibliography("refs.bib", style: "ussl.csl")```

      #text(0.9em, link("https://github.com/citation-style-language/styles"))
    ])
    #only(7, box(width: 14cm)[
      #place(dy: -2.3em, dx: -4.8em, box(width: 10cm)[`#cite(<oswald2022detection>, 
          form: "prose")` ])
      ```
      claim that 
      researchers 
      describe and name 
      animal sounds
      based on their 
      perception of the 
      sound and thus 
      based on their 
      own language.

      #bibliography("refs.bib", style: "ussl.csl")```

      #text(0.9em, link("https://github.com/citation-style-language/styles"))
    ])
  ],
)

== Maths

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [What is $sum_(k=0)^n k$?], ``` What is $sum_(k=0)^n k$?```,
  pause,

  $
    sum_(k=0)^n k & = 1 + ... + n \
                  & = (n(n+1)) / 2
  $,
  ``` $
    sum_(k=0)^n k & = 1 + ... + n \
                  & = (n(n+1)) / 2
  $```,

  pause,
  $
    mat(
      1, 2, ..., 10;
      2, 2, ..., 10;
      dots.v, dots.v, dots.down, dots.v;
      10, 10, ..., 10;
    )
  $,

  ``` $ mat(
    1, 2, ..., 10;
    2, 2, ..., 10;
    dots.v, dots.v, dots.down, dots.v;
    10, 10, ..., 10;
  ) $ ```,
  pause,
)

#link("https://typst.app/docs/reference/symbols/sym/") #h(1fr) #link("https://typst.app/docs/reference/math/")

= Formatting & Styling
== Page, Par, Text

#alternatives[
  ```
  #set page(
    paper: "a7",
    



  )
  ```
][
  ```
  #set page(
    paper: "a7",
    header: [TITELTITEL #h(1fr) AUTHOR],
    


  )
  ```
][
  ```
  #set page(
    paper: "a7",
    header: [TITELTITEL #h(1fr) AUTHOR],
    numbering: "1",
    

  )
  ```
][
  ```
  #set page(
    paper: "a7",
    header: [TITELTITEL #h(1fr) AUTHOR],
    numbering: "1",
    margin: (top: 5em, x: 1em),
    
  )
  ```
][
  ```
  #set page(
    paper: "a7",
    header: [TITELTITEL #h(1fr) AUTHOR],
    numbering: "1",
    margin: (top: 5em, x: 1em),
    columns: 2,
  )
  ```
]
#v(0.7em)
#alternatives(start: 6)[
  ```
  #set par(
    justify: true,
    


  )
  ```
][
  ```
  #set par(
    justify: true,
    first-line-indent: 1em,
    

  )
  ```
][
  ```
  #set par(
    justify: true,
    first-line-indent: 1em,
    spacing: 0.9em,
    
  )
  ```
][
  ```
  #set par(
    justify: true,
    first-line-indent: 1em,
    spacing: 0.9em,
    leading: 0.6em,
  )
  ```
]

#place(bottom, line(stroke: 0.5pt, length: 40%))

#place(center + bottom, dx: 1em, box(
  height: 68%,
  width: 25.4%,
  stroke: (left: 0.5pt, top: 0.5pt),
  inset: (left: 1em, top: 1em, bottom: 0.5em),
  align(left)[
    #alternatives(start: 10)[
      ```
      #set text(
        lang: "de",
        


      )
      ```
    ][
      ```
      #set text(
        lang: "de",
        size: 10pt,
        

      )
      ```
    ][
      ```
      #set text(
        lang: "de",
        size: 10pt,
        font: "Inter",
        
      )
      ```
    ][
      ```
      #set text(
        lang: "de",
        size: 10pt,
        font: "Inter",
        weight: "light",
      )
      ```
    ]
    #v(0.7em)

    ```
    #lorem(50)

    #lorem(20)
    ```
  ],
))
#{
  set image(height: 100%)
  show image: it => box(stroke: (thickness: 0.5pt, dash: "dashed"), it)
  only(1, place(right + top, image("assets/page00.pdf")))
  only(2, place(right + top, image("assets/page01.pdf")))
  only(3, place(right + top, image("assets/page02.pdf")))
  only(4, place(right + top, image("assets/page03.pdf")))
  only(5, place(right + top, image("assets/page04.pdf")))
  only(6, place(right + top, image("assets/page05.pdf")))
  only(7, place(right + top, image("assets/page06.pdf")))
  only(8, place(right + top, image("assets/page07.pdf")))
  only(9, place(right + top, image("assets/page08.pdf")))
  only(10, place(right + top, image("assets/page09.pdf")))
  only(11, place(right + top, image("assets/page10.pdf")))
  only(12, place(right + top, image("assets/page11.pdf")))
  only(13, place(right + top, image("assets/page12.pdf")))
}

== Numbering

#{
  show grid.cell.where(y: 0): set align(center)
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 1em,
    inset: (x: 1em, y: 8pt),
    grid.cell(colspan: 2)[#alternatives[` `][`#set enum(numbering: "A)")    `][`#set enum(numbering: "i.a.1.")`]],
    grid.vline(),
    grid.cell(colspan: 2)[#alternatives[` `][`#set enum(numbering: "1.1")    `][`#set enum(numbering: "I) a-1.")`]],

    alternatives[
      + foo
      + bar
        + qux
          + boom
        + quux
        + quuux
      + baz
    ][
      #set enum(numbering: "A)")
      + foo
      + bar
        + qux
          + boom
        + quux
        + quuux
      + baz
    ][
      #set enum(numbering: "i.a.1.")
      + foo
      + bar
        + qux
          + boom
        + quux
        + quuux
      + baz
    ],

    [
      ```
      + foo
      + bar
        + qux
          + boom
        + quux
        + quuux
      + baz
      ```
    ],

    [
      #set par(leading: 1em)
      #alternatives[
        *#text(1.4em)[Foo]*\
        *#text(1.4em)[Bar]*\
        *#text(1.2em)[Qux]*\
        *Boom*\
        *#text(1.2em)[Quux]*\
        *#text(1.2em)[Quuux]*\
        *#text(1.4em)[Baz]*\
      ][
        *#text(1.4em)[\1. Foo]*\
        *#text(1.4em)[\2. Bar]*\
        *#text(1.2em)[2.1 Qux]*\
        *2.1.1 Boom*\
        *#text(1.2em)[2.2 Quux]*\
        *#text(1.2em)[2.3 Quuux]*\
        *#text(1.4em)[\3. Baz]*\
      ][
        *#text(1.4em)[I) Foo]*\
        *#text(1.4em)[II) Bar]*\
        *#text(1.2em)[II) a. Qux]*\
        *II) a-1. Boom*\
        *#text(1.2em)[II) b. Quux]*\
        *#text(1.2em)[II) c. Quuux]*\
        *#text(1.4em)[III) Baz]*\
      ]
    ],

    [
      ```
      = Foo
      = Bar
      == Qux
      === boom
      == quux
      == quuux
      = baz
      ```
    ],
  )
}

== `#show`-rules

#grid(
  columns: (1.6fr, 1fr),
  column-gutter: 1em,
  [

    #[
      #set par(leading: 0.5em)
      #pause
      `#show "the lazy dog": smallcaps`\ #pause
      `#show " and": [ &]`\ #pause
      `#show strong: underline`\ #pause
      `#show "brown": set text(orange.darken(50%))`\ #pause
      #v(-0.8em)`#show emph: it => [🦊 #it 🦊]`\ #pause
      `#show regex("\(.*\)"): set text(style: "italic")`\ #pause
      `#show regex("[Tt]he"): set text(1.4em)`\
    ]
    #alternatives(start: 1)[
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ][
      #show "the lazy dog": smallcaps
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ][
      #show "the lazy dog": smallcaps
      #show " and": [ &]
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ][
      #show "the lazy dog": smallcaps
      #show " and": [ &]
      #show strong: underline
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ][
      #show "the lazy dog": smallcaps
      #show " and": [ &]
      #show strong: underline
      #show "brown": set text(orange.darken(50%))
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ][
      #show "the lazy dog": smallcaps
      #show " and": [ &]
      #show strong: underline
      #show "brown": set text(orange.darken(50%))
      #show emph: it => [🦊 #it 🦊]
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ][
      #show "the lazy dog": smallcaps
      #show " and": [ &]
      #show strong: underline
      #show "brown": set text(orange.darken(50%))
      #show emph: it => [🦊 #it 🦊]
      #show regex("\(.*\)"): set text(style: "italic")
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ][
      #show "the lazy dog": smallcaps
      #show " and": [ &]
      #show strong: underline
      #show "brown": set text(orange.darken(50%))
      #show emph: it => [🦊 #it 🦊]
      #show regex("\(.*\)"): set text(style: "italic")
      #show regex("[Tt]he"): set text(1.4em)
      *The Rest of the Story* (Jennifer Clauson)

      The _quick brown fox_ jumps over the lazy dog.\
      He lands head first on a rotting maple log.\
      Knocked unconscious, fox sleeps with shallow breath\
      until the lazy dog awakes and worries him to death.\
    ]
  ],
  [
    #pause
    #place(dy: -2em)[
      #set par(spacing: 0.7em)
      #alternatives(start: 9)[```



      ```][```
      #show link: set text(navy)
      #show link: underline
      ```]
      ```
      #link("https://github.com/Ikaluk/typst-presentation")
      ```
      #v(0.5em)
      #text(0.8em, navy, box(width: 14cm, alternatives(
        "https://github.com/Ikaluk/typst-presentation",
        link("https://github.com/Ikaluk/typst-presentation"),
      )))

    ]

    #pause

    #v(4.6em)
    #line(length: 110%)
    #v(-0.4em)

    #[
      #box(width: 14cm, text(0.7em, alternatives(start: 11, ```
      
      ```,```
      
      ```,```
      #import "@preview/booktyps:0.1.1": booktabs
      ```)))
      #set text(0.9em)
      #box(width: 14cm, alternatives(start: 11, ```
      


      ```, ```

      #show table.cell.where(y: 0): strong
      ```, ```
      #show table: booktabs
      #show table.cell.where(y: 1): strong
      ```))
      
      #alternatives[
        #table(
          columns: 2,
          stroke: 1pt,
          table.header([language], [barking]),
          [French], [ouaf ouaf],
          [Spanish], [guau guau],
          [Indonesian], [guk guk],
        )
      ][
        #show table.cell.where(y: 0): strong

        #table(
          columns: 2,
          stroke: 1pt,
          table.header(box(height: 0.66em)[language], [barking]),
          [French], [ouaf ouaf],
          [Spanish], [guau guau],
          [Indonesian], [guk guk],
        )
      ][
        #import "@preview/booktyps:0.1.1": booktabs
        #show table: booktabs
        #show table.cell.where(y: 1): strong
        #table(
          columns: 2,
          stroke: 1pt,
          table.header(box(height: 0.66em)[language], [barking]),
          [French], [ouaf ouaf],
          [Spanish], [guau guau],
          [Indonesian], [guk guk],
        )
        #place(right+bottom, dx:1em, dy:-6.1em, text(0.8em)[`table.header(...)`])
      ]
      #v(-0.5em)
      #place(bottom+right, dx: 1em, text(0.6em)[@oswald2022detection[272]])
    ]
  ],
)




== Templates
#pause

- #link("https://typst.app/universe/")[Typst Universe] #pause
- Papers #pause
  - _cogsci-conference_ #pause
  - _athena-tu-darmstadt-thesis_ #pause
- CVs #pause
  - _basic-resume_ #pause
- Presentations #pause
  - _touying_ #pause #pause #pause #pause
  - _diatypst_ #pause #pause
- Posters #pause
  - _peace-of-posters_ #pause #pause
  - _pollux_ #pause


#place(right+top, only(2, image("assets/image-13.png")))
#place(right + top, only("4", box(inset: (y: -1.5em), image("assets/cogsci.png", height: 1fr))))
#place(right + top, only("5", box(inset: (y: -1.5em), image("assets/tudapub_prev-01.png", height: 1fr))))
#place(right + top, only("7", box(inset: (y: -1.5em), image("assets/example-resume.png", height: 1fr))))

#place(right + top, only("9", box(inset: (top: 1.5em), image("assets/image.png"))))
#place(right + top, only("10", box(inset: (top: 1.5em), image("assets/image-1.png"))))
#place(right + top, only("11", box(inset: (top: 1.5em), image("assets/image-2.png"))))
#place(right + top, only("12", box(inset: (top: 1.5em), image("assets/image-3.png"))))
#place(right + top, only("13", box(inset: (top: 1em), image("assets/image-4.png"))))
#place(right + top, only("14", box(inset: (top: 1em), image("assets/image-5.png"))))
#place(right + top, only("16", box(inset: (y: -1.5em, right: 1em), image("assets/image-6.png"))))
#place(right + top, only("17", box(inset: (y: -1.5em, right: 1em), image("assets/image-8.png"))))
#place(right + top, only("18", box(inset: (y: -1.5em, right: 1em), image("assets/image-9.png"))))


= Editors

== Web-editor
#pause
- #link("https://typst.app/") (requires account) #pause
- *Live compilation* #pause
- unlimited collaborations #pause
- converter from LaTeX, Word, Markdown #pause
- Click-to-source

#empty-slide(box(inset: (x: -2em, y: -2em), image("assets/image-11.png")))


== vscode/vscodium + tinymist
- #link("https://code.visualstudio.com/")
- #link("https://vscodium.com/")
- #link("https://github.com/Myriad-Dreamin/tinymist")
#pause
#place(right + top)[
  #set align(left)
  #set text(gray)
  *#text(gray, 1.2em)[Web-editor]*

  - #text(weight: "bold")[Live compilation]
  - unlimited collaborations
  - converter from LaTeX, Word, Markdown
  - Click-to-source
]
- everything is just like in the web app #pause
- local, offline, customizable #pause
- no spell check


#empty-slide(box(inset: (x: -2em, y: -3.2em), image("assets/image-10.png")))


= Comparison to #LaTeX


== Preamble
#show table.cell.where(y: 0): it => text(weight: "bold", it)

#{
  set text(14pt)
  box(inset: (left: 10em, top: -3em), figure(
    table(
      columns: (1fr, 1.6fr),
      align: left,
      typst, LaTeX,
      pause, raw("Hello World!", lang: "typ"),
      pause,
      {
        uncover("2-", raw("\documentclass{article}\n", lang: "tex"))
        only("3", text(11.5pt, weight: "bold", raw(
          "\usepackage[utf8]{inputenc}
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
\usepackage{lastpage} % get number of last page\n",
          lang: "tex",
        )))
        uncover("2-", raw("\begin{document}
Hello World!
\end{document}", lang: "tex"))
      },
    ),
  ))
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
      Three modes:
      #v(-13pt)
      #grid(
        columns: 3,
        column-gutter: 1em,
        row-gutter: 0.5em,
        pause, [1. Markup], `[...]`,
        `#let n = [*Typst!*]`, pause, [2. Code],
        `#...`, `#(1 + 2)`, pause,
        [3. Math], `$...$`, `$sqrt(-1)$ is $i$`,
        pause,
      )
    ],
    {
      [Various environments, macros for everything.\ ]
      pause
      raw(lang: "tex", "\begin{minipage}{...}...\end{minipage}\n")
      pause
      raw(lang: "tex", "\\newcommand{\cmd}{def}")
    },
    pause,
    [consistent syntax based on these modes & package compatibility],
    pause,
    [varying syntax across different packages,\ confusing arguments in `{}[]{}{}`],
    pause,
    [real programming language: `#if, #for, #let`],
    pause,
    [requires packages (`expl3`) for scripting],
  ),
)


== Basic Functions
#{
  show table.cell.where(x: 1): set raw(lang: "tex")
  set text(size: 12pt)
  table(
    columns: (1fr, 1fr),
    align: left,

    table.header(typst, LaTeX),
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

== Tables

#{
  show table.cell.where(x: 1): set raw(lang: "tex")

  table(
    columns: (1fr, 1.2fr),
    align: left,

    typst,
    {
      h(1.75em)
      LaTeX
    },
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



== Writing environment
#table(
  columns: (1fr, 1fr),
  align: left,
  typst, LaTeX,
  pause, [incremental live compilation],
  [pseudo-live compilation with a compilation limit in the online editor], pause,
  [somewhat understandable error messages], [cryptic error messages],
  pause, [consistent documentation],
  [many decentralized documentation sources],
)


== Use in academic settings



#table(
  columns: (1fr, 1fr),
  inset: (right: 0.5em),
  align: left,
  typst, LaTeX,
  pause,
  [The #typst source code is currently accepted only by the _International Journal of Interactive Multimedia and Artificial Intelligence (IJIMAI)_.
    Some journals also accept PDF submissions.],
  [The #LaTeX source code is accepted by the vast majority of journals and conferences.],
  pause,
  [Anything is possible; it's not that complicated -- some things are still under development.],
  [#LaTeX is well-established; there are templates and solutions for everything (even if some of them are very complicated).],
)




= Useful packages
== Numbering: `numbly`

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

#place(center + bottom, dx: 5em, dy: -1em, image("assets/image-12.png", height: 6cm))

== References: `citesugar`

#place(right + top, link("https://typst.app/universe/package/citesugar"))

#{
  set text(0.88em)
  grid(
    columns: (2fr, 1.1fr, 0.7fr),
    column-gutter: 1em,
    [
      #only("1", place(right + top, dx: 11.79em, dy: 3.35em, align(left)[
        `@oswald2022detection`
        #v(8.08em)
        #text(0.8em)[`@oswald2022detection[p.~272]`]
      ]))
      ```

      // native citation:

      #cite(<oswald2022detection>)
      #cite(<oswald2022detection>, form: "prose")
      #cite(<oswald2022detection>, form: "author")
      #cite(<oswald2022detection>, form: "year")
      ```
      #v(-0.3em)
      #text(0.5em, `#cite(<oswald2022detection>, form: "author")~#cite(<oswald2022detection>, form: "year")`)\
      #text(0.5em, `#cite(<oswald2022detection>, form: "author")’s~(#cite(<oswald2022detection>, form: "year"))`)\
      #text(0.9em, `#cite(<oswald2022detection>, form: "author")’s`)

      #v(1.1em)
      #text(0.9em, `#cite(<oswald2022detection>, supplement: [p~272])`)
      #text(0.7em, `#cite(<oswald2022detection>, form: "author", supplement: [p~272])`)
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
      \
      #v(-0.8em)
      #set text(0.8em)
      #set par(leading: 1em)
      ```
      @oswald2022detection[p.~272]
      @oswald2022detection[p:p.~272]
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
      \
      #set text(0.8em)
      #set par(leading: 1em)
      @oswald2022detection[p.~272]\
      @oswald2022detection[p:p.~272]\
    ],
  )
}

== Tables: `booktyps`

#place(top + right, link("https://typst.app/universe/package/booktyps"))


#grid(
  columns: (1fr, auto),
  box(inset: (bottom: -2em))[
    #set text(0.7em)
    ```
    #import "@preview/booktyps:0.1.1": booktabs
    #show table: booktabs
    #show table.cell.where(y: 1): strong

    #table(
      columns: 4,
      align: (left, center+horizon, center, right),
      
      table.header([Month], [Season], [Long month], [Days]),

      [January], table.cell(rowspan: 2)[winter], [yes], [31],
      [February], [no], [28],
      table.hline(end: 2),
      [March], table.cell(rowspan: 3)[spring], [yes], [31],
      [April], [no], [30],
      [May], [yes], [31],
      table.hline(end: 2),
      [June], table.cell(rowspan: 1)[summer], [no], [30],

      table.footer([*Total*], [], [], [181]),
    )
    ```
  ],
  [
    #show table: booktabs
    #show table.cell.where(y: 1): strong

    #table(
      columns: 4,
      align: (left, center + horizon, center, right),

      table.header([Month], [Season], [Long month], [Days]),

      [January], table.cell(rowspan: 2)[winter], [yes], [31],
      [February], [no], [28],
      table.hline(end: 2),
      [March], table.cell(rowspan: 3)[spring], [yes], [31],
      [April], [no], [30],
      [May], [yes], [31],
      table.hline(end: 2),
      [June], table.cell(rowspan: 1)[summer], [no], [30],

      table.footer([*Total*], [], [], [181]),
    )

  ],
)

== Graphics: `cetz`
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


== Diagrams: `fletcher`
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

#place(top + right, dy: 3em, [
  #let hom = edge.with(in-math: true)
  #diagram(
    spacing: 2em,
    $
                     G hom(f, ->) hom("d", pi, ->>) & im(f) \
      G slash ker(f) hom("ur", tilde(f), "hook-->")
    $,
  )
])

== Plots: `lilaq`
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


== Slides: `touying`
#place(top + right, link("https://typst.app/universe/package/touying"))

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



= How to write a document
== Workflow
#place(top + right)[*(click on any _`keyword`_ for reference)*]
#columns(2)[
  #set par(justify: false)
  #set list(marker: [◦])
  #let lnk(dest, body) = {
    show underline.where(stroke: auto): it => it.body
    link(dest, body)
  }

  #pause

  0. Prepare #lnk("https://typst.app/docs/reference/model/bibliography/")[`refs.bib`, `#bibliography`], #lnk("https://typst.app/universe/package/citesugar")[`citesugar`]

  #pause

  + Write everything in markdown
    - #link("https://typst.app/docs/reference/model/heading/")[`= heading`]
    - #lnk("https://typst.app/docs/reference/model/strong/")[`*strong*`]
    - #lnk("https://typst.app/docs/reference/model/emph/")[`_emph_`]
    - #lnk("https://typst.app/docs/reference/model/enum/")[`+ enum`]
    - #lnk("https://typst.app/docs/reference/model/list/")[`- list`]
    - #lnk("https://typst.app/docs/reference/model/terms/")[`/ terms`]
    - put #lnk("https://typst.app/docs/reference/model/table/")[`#table`] and #lnk("https://typst.app/docs/reference/visualize/image/")[`#image`] in #lnk("https://typst.app/docs/reference/model/figure/")[`#figure`]
    - #lnk("https://typst.app/docs/reference/foundations/label/")[`<label>`] and #lnk("https://typst.app/docs/reference/model/ref/")[`@reference`] elements
    - add #lnk("https://typst.app/universe/search/?kind=packages")[_packages_] on the go
  #colbreak()

  #pause

  2. add #lnk("https://typst.app/docs/reference/model/title/")[`#title`], #lnk("https://typst.app/docs/reference/model/outline/")[`#outline`]

  #pause

  + #lnk("https://typst.app/docs/tutorial/formatting/")[_Format_] and #lnk("https://typst.app/docs/reference/styling/")[_style_] everything as needed
    #table(
      columns: (1fr, 1fr),
      lnk("https://typst.app/docs/reference/styling/")[`#set`],
      lnk("https://typst.app/docs/reference/styling/")[`#show`],
      lnk("https://typst.app/docs/reference/model/document/")[`#document`],
      lnk("https://typst.app/universe/search/?kind=templates")[_templates_],
      [#lnk("https://typst.app/docs/reference/layout/page/")[`#page`], #lnk("https://typst.app/docs/reference/model/par/")[`#par`]],
      lnk("https://typst.app/universe/search/?kind=packages")[_packages_],
      table.cell(colspan: 2, align(
        center,
        [#lnk("https://typst.app/docs/reference/text/text/")[`#text`], #lnk("https://typst.app/docs/reference/model/table/")[`#table`], #lnk("https://typst.app/docs/reference/model/heading/")[`#heading`]],
      )),
      [#lnk("https://typst.app/docs/reference/model/enum/")[`#enum`], #lnk("https://typst.app/docs/reference/text/raw/")[`#raw`]],
      lnk("https://typst.app/docs/reference/model/link/")[`#link`],
    )

  #pause

  + #lnk("https://typst.app/docs/reference/layout/")[_Layout_] and position elements with #lnk("https://typst.app/docs/reference/layout/align/")[`#align`], #lnk("https://typst.app/docs/reference/layout/columns/")[`#columns`], #lnk("https://typst.app/docs/reference/layout/grid/")[`#grid`], #lnk("https://typst.app/docs/reference/layout/place/")[`#place`], #lnk("https://typst.app/docs/reference/layout/move/")[`#move`]
]




== A possible preamble

#columns(2)[
  #set text(0.8em)

  ```
  #import "@preview/numbly:0.1.0": numbly
  #import "@preview/citesugar:0.2.0": *
  #import "@preview/booktyps:0.1.1": booktabs
  // more packages

  #set document(author: "AUTHOR", title: "TITLE") //
  #let date = datetime.today().display("[day].[month].[year]") // for further use

  #set page(
    margin: (top: 3cm),
    header: [HEADER],
    numbering: "1 / 1",
    // ...
  )

  #set par(justify: true)
  #set text(
    lang: "en",
    size: 11pt,
    // ...
  )

  #set enum(full: true, numbering: numbly("{1:1.}", "{2:i.}"))
  #set heading(numbering: "1.1")

  #set raw(lang: "py")

  #show cite: citesugar

  #show table: booktabs
  #show table.cell.where(y:1): strong

  #show link: underline
  ```
]

== Further References

- #link("https://typst.app/docs/tutorial/")
- #link("https://sitandr.github.io/typst-examples-book/book/")
- #link("https://typst.app/docs/reference/")


// delete unused images, packages

//#bibliography("refs.bib")
