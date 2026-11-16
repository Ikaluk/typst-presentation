#import "@preview/touying:0.7.4": *
#import themes.dewdrop: *

#import "functions.typ": *

#import "@preview/numbly:0.1.0": numbly


#import "@preview/eggs:0.8.0": *
#import abbreviations: *
#show: eggs

#import "@preview/citesugar:0.1.0": *
#show cite: citesugar

#import "@preview/dtree:0.1.1": dtree as dtree-old
#let dtree(..args) = box(stroke: 2pt + gray, inset: (right: 9pt, rest: 0.5pt), radius: 0.5em, dtree-old(size: 1em, indent-width: 1em, ..args))

#set text(lang: "en")

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
    //institution: [Goethe Universität Frankfurt],
    contact: [fischeme\@tcd.ie],

    logo: image("assets/Logo-Goethe-University-Frankfurt-am-Main.svg.png", height: 2cm),
  ),
  config-page(
    margin: (top: 3.5em, bottom: 2em, x: 2em),
  ),
)

#set heading(numbering: none)

#set raw(lang: "typ")
#show link: it => if type(it.dest) == str { underline(it) } else { it }

//#show table.cell.where(y: 0): it => text(20pt, weight: "bold", it)
#set table(
  stroke: (x, y) => (
    top: if y <= 1 { 0.8pt } else { 0pt },
    bottom: 0.8pt,
  ),
  inset: (y: 8pt),
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
    #only("1", raw("#image(\"assets/sheep.png\")"))
    #only("2", raw("#image(\"assets/sheep.png\", width: 10cm)"))
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
    author={Oswald, Julie N and Erbe, Christine and 
            Gannon, William L and Madhusudhana, Shyam and 
            Thomas, Jeanette A},
    journal={Exploring animal behavior through sound},
    volume={1},
    pages={269--317},
    year={2022},
    publisher={Springer International Publishing},
    address={Cham, Switzerland}
  } ```
))))

#only(1, place(right + top, align(left, dtree(```
presentation/
  fill=gray | assets/
    fill=gray | sheep.png
  main.pdf
  main.typ
  fill=eastern | refs.bib
```))))
#only("2-", place(right + top, align(left, dtree(```
presentation/
  fill=gray|assets/
    fill=gray|sheep.png
  fill=eastern | main.pdf
  fill=eastern | main.typ
  refs.bib
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
       based on their own language."


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
       based on their own language." @oswald2022detection

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
       based on their own language." @oswald2022detection

      #bibliography("refs.bib", style: "apa")```
    ])
  ],
)

== Maths

= 
==