#import "/globals.typ": *

= Reproducibility
#components.progressive-outline(depth: 1)

#slide(composer: (2fr, 3fr))[
  #image("/assets/lab_experiment.jpg", width: 90%)
][
  Definitions: @ANTUNES2024100655
  - *Repeatability:* Same team, same experimental setup
  - *Reproducibility:* Different teams, same experimental setup
  - *Replicability:* Different teams, different experimental setups

  #pause

  *Reprocubility crisis:*\
  Difficulty to reproduce scientific studies from other groups
  #pause

  Only in experimental sciences... right?\
  #pause
  -> *Major issue in modern computer science research*
]

== Software

#slide[
  Reasons for the lack of reproducibility:
  #pause
  - Code is not available
  #pause
  - Data is not available
  #pause
  - *Code is hard to run*
][
  // #image("/assets/frustration.jpg", height: 200pt)
  #image("/assets/tech_loops.png")
]

#slide(title: "General recommendations")[
  - Most importantly: keep things simple!\
    -> Fewer dependencies/languages/constraints = fewer problems
  #pause
  - Use version control (`git`)
  #pause
  - Add a license (`LICENSE`) (MIT, GPL, Apache...)
  #pause
  - Write a `README.md` file:
    - Context about the project
    - Installation instructions
    - How to run the code?
    - How to download data?
    - How to replicate the results?
  #pause
  - Ensure your code and experiments can be easily run and are reproducible
]

== Existing approaches

// TODO: pixi

#slide[
  - *Nothing*\
    -> Fine for very simple software stacks. Doesn't scale
    #pause
  - *Natural language* (i.e. instructions)\
    -> Documentation is great, but does not scale with complexity
    #pause
  - *Virtual environments* (for Python)\
    -> How to fill it? (not often reproducible)\
    -> no control on the system's environment
    #pause
  - *What about containers?*\
    -> How to fill it? (not often reproducible)\
    -> Not resource-efficient
    #pause
  - *Functional package managers (Nix, Guix)*\
    -> Elegant, powerful, but very hard to use
]
