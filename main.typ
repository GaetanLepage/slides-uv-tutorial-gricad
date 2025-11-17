#import "globals.typ": *

#let orange = rgb("#eb811b")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  // footer: self => self.info.institution,
  config-info(
    title: [
      The road to reprod*`uv`*ibility in Python
    ],
    subtitle: [An introduction to the `uv` tool],
    author: [Gaétan Lepage],
    //date: datetime.today(),
    date: "November 15, 2025",
    institution: [GRICAD, Grenoble],
    logo: image("assets/logo_uv.svg"),
  ),
  config-colors(
    primary: orange,
    primary-light: rgb("#d6c6b7"),
    secondary: rgb("#23373b"),
    neutral-lightest: rgb("#fafafa"),
    neutral-dark: rgb("#23373b"),
    neutral-darkest: rgb("#23373b"),
  ),
  config-common(
    new-section-slide-fn: none,
    // show-strong-with-alert: false,
    // show-bibliography-as-footnote: bib,
  ),
)

// Do not number figures
#set figure(numbering: none)

// #set super(size: 1em, baseline: 0em)
#show strong: it => {
  text(black)[#it]
}

#show link: it => {
  text(eastern)[#it]
}
#show raw: it => {
  text(maroon)[#it]
}

// #set heading(numbering: numbly(
//   "{1}.",
//   default: "1.1",
// ))

#title-slide()

#include "slides/0_index.typ"
// #bib
#bibliography("bibliography.bib", title: none)
