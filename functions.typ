
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
    x_offset: -0.12em    
  )
  let E = (
    x_offset: -0.2em,
    y_offset: 0.23em,
    size: 1em
  )
  let X = (
    x_offset: -0.1em
  )
  [L#h(A.offset.x)#text(size: A.size, baseline: A.offset.y)[A]#h(T.x_offset)T#h(E.x_offset)#text(size: E.size, baseline: E.y_offset)[E]#h(X.x_offset)X]
}

#import "@preview/cetz:0.3.4"

#let agree(start, end, depth, ..style) = {
  cetz.draw.set-style(mark: (end: ">", start: ">"), stroke: (paint: black, dash: "solid"))
  cetz.draw.set-style(..style)
  cetz.draw.bezier(
    start + ".south",
    end + ".south",
    (rel: (-90deg, depth * 1cm), to: (start, 0%, end)),
    (rel: (-90deg, (depth + 3) * 1cm), to: (start, 100%, end)),
  )
}

