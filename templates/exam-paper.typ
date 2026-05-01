#import "@preview/tyniverse:0.2.3": homework

#let heading-fonts = ("New Computer Modern Sans", "Libertinus Sans")
#let body-fonts = ("Libertinus Serif", "New Computer Modern")
#let math-fonts = ("New Computer Modern Math", "Libertinus Math")

#let build-meta(
  course: none,
  exam: none,
  source: none,
  year: none,
  note: none,
) = {
  (
    (label: "Course", value: course),
    (label: "Exam", value: exam),
    (label: "Source", value: source),
    (label: "Year", value: year),
    (label: "Note", value: note),
  ).filter(item => item.value != none)
}

#let meta-grid(items) = {
  if items.len() == 0 {
    return
  }

  grid(
    columns: (auto, 1fr),
    column-gutter: 0.8em,
    row-gutter: 0.45em,
    ..items.map(item => (
      strong(item.label + ":"),
      item.value,
    )).flatten(),
  )
}

#let template(
  title: "Past Exam",
  subtitle: none,
  course: none,
  exam: none,
  source: none,
  year: none,
  note: none,
  body,
) = {
  let meta-items = build-meta(
    course: course,
    exam: exam,
    source: source,
    year: year,
    note: note,
  )

  set document(title: title)
  set text(font: body-fonts, lang: "en")
  show math.equation: set text(font: math-fonts)
  set par(linebreaks: "optimized", justify: true)
  show raw.where(block: true): set par(linebreaks: "simple", justify: false)
  show heading: set text(font: heading-fonts)

  set page(
    numbering: "1",
    number-align: center,
    header-ascent: 14pt,
    header: context if counter(page).get().at(0) != 1 {
      set text(size: 8pt)
      grid(
        columns: (1fr, auto),
        column-gutter: 1fr,
        text(font: heading-fonts, weight: "bold", title),
        if year != none { year } else { [] },
      )
    },
  )

  align(
    center,
    [
      #set text(font: heading-fonts)
      #text(weight: "bold", size: 1.8em, title)
      #if subtitle != none [
        #v(0.45em)
        #text(weight: "medium", size: 1.02em, subtitle)
      ]
    ],
  )

  [
    #v(1.2em)
    #meta-grid(meta-items)
    #v(1.2em)
    #body
  ]
}

#let question = homework.complex-question
#let short-question = homework.simple-question

#let reference-answer(body) = block(
  inset: 10pt,
  radius: 6pt,
  fill: rgb("#f6f7f1"),
  stroke: (paint: rgb("#a8ad8f"), thickness: 0.9pt),
  [
    #set text(size: 10pt)
    #set par(justify: false)
    #strong([Reference Answer])
    #v(0.45em)
    #body
  ],
)

#let remark(body) = block(
  inset: 10pt,
  radius: 6pt,
  fill: rgb("#f7f7f7"),
  stroke: (paint: rgb("#b8b8b8"), thickness: 0.8pt),
  [
    #set text(size: 10pt)
    #set par(justify: false)
    #strong([Remark])
    #v(0.45em)
    #body
  ],
)
