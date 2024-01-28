// This function gets your whole document as its `body` and formats
// it as a simple fiction book.

#let book(
  mainColor: blue,
  lightTextColor: luma(90),
  // The book's title.
  title: [Title],

  // The book's author.
  author: "Author Name",

  // The paper size to use.
  paper: "a4",

  subtitle: "",

  // A dedication to display on the third page.
  dedication: none,

  // Details about the book's publisher that are
  // display on the second page.
  publishing-info: none,

  backgroundImage: none,
  logo: none,
  bottomText: none,

  // The book's content.
  body,
) = {
  // Set the document's metadata.
  set document(title: title, author: author)

  // Set the body font. TeX Gyre Pagella is a free alternative
  // to Palatino.
  set text(font: "EB Garamond", size: 1.2em)

  // Configure the page properties.
  set page(
    paper: paper,
    margin: (bottom: 1.75cm, top: 2.25cm),
  )
  show footnote.entry: set text(style: "italic", fill: lightTextColor)
  // The first page.
  page(margin: 1.5cm, header: none, align(center + horizon)[
    
    #if backgroundImage != none {
      set image(width: 100%, height: 100%)
      set page(margin: 0cm)
      place(bottom, image(backgroundImage))
    }

    #text(2em, fill: mainColor)[*#title*]
    #v(2em, weak: true)
    #text(1.8em, fill: lightTextColor)[#subtitle]
    #v(2em, weak: true)
    #text(1.6em, author)
    #if logo != none {
      image(logo, width: 25%)
    }
    #v(2em, weak: true)
    #if bottomText != none {
      place(bottom + center, dy: -3em, text(1.2em, bottomText))
    }
  ])
  

  // Display publisher info at the bottom of the second page.
  if publishing-info != none {
    align(center + bottom, text(0.8em, publishing-info))
  }

  pagebreak()

  // Display the dedication at the top of the third page.
  if dedication != none {
    v(15%)
    align(center, dedication)
  }

  // Books like their empty pages.
  pagebreak(to: "odd")

  // Configure paragraph properties.
  set par(leading: 0.78em, first-line-indent: 12pt, justify: true)
  show par: set block(spacing: 0.78em)
  // Configure heading properties.
  set heading(numbering: "1.")
  
  show heading: it => {

    // Create the heading numbering.
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    v(5%)
    text(1.5em, fill: mainColor, weight: 700, block([#number #it.body]))
    v(1.25em)
  }

  // Start with a chapter outline.
  show outline: set text(16pt, fill: mainColor.lighten(20%), weight: 400)
  show outline: set par(leading: 1.2em)
  outline(title: [Capítols], depth: 3, indent: true)
  
  // Configure page properties.
  set page(
    numbering: "1",

    // The header always contains the book title on odd pages and
    // the chapter title on even pages, unless the page is one
    // the starts a chapter (the chapter title is obvious then).
    header: locate(loc => {
      // Are we on an odd page?
      let i = counter(page).at(loc).first()
      if calc.odd(i) {
        return text(0.85em, smallcaps(title), fill: lightTextColor)
      }

      // Are we on a page that starts a chapter? (We also check
      // the previous page because some headings contain pagebreaks.)
      // let all = query(heading, loc)
      // if all.any(it => it.location().page() in (i - 1, i)) {
      //   return
      // }

      // Find the heading of the section we are currently in.
      let before = query(selector(heading).before(loc), loc)
      if before != () {
        align(right, text(0.85em, smallcaps(before.last().body), fill: lightTextColor))
      }
    }),
  )

  // Configure chapter headings.
  show heading.where(level: 1): it => {
    // Always start on odd pages.
    pagebreak(to: "odd")

    // Create the heading numbering.
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    v(5%)
    text(2em, weight: 700, fill: mainColor, block([#number #it.body]))
    v(1.25em)
  }
  show heading: set text(11pt, fill: mainColor, weight: 400)

  show bibliography: set par(first-line-indent: 0pt)
  body
}
