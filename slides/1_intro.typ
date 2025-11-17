#import "/globals.typ": *

#slide(title: "Who am I?")[
  *Gaétan Lepage*

  - Ensimag 2020
  - PhD \@Inria Grenoble (RobotLearn team)\
    - Deep Learning for robotic acoustics
  - Nix(OS) contributor since 2021
    - Python ecosystem maintenance
    - Member of the CUDA team
][
  #set align(center)
  #image("/assets/logo_ensimag.svg", height: 16%)
  #figure(
    grid(
      columns: 2,
      gutter: 3em,
      image("/assets/logo_inria.svg", height: 12%), image("/assets/logo_robotlearn.png", height: 16%),
    ),
  )
  #figure(
    grid(
      columns: 2,
      gutter: 3em,
      image("/assets/logo_nixos.svg", height: 20%), image("/assets/logo_cuda.jpg", height: 20%),
    ),
  )
]

#slide(title: "Objectives")[
  *Objectives:*
  - Why "packaging" is important, especially in research
  - Overview of how things work in Python
  - A presentation of `uv`
  - Hands-on! *Try `uv` on your own project*
]

#components.progressive-outline(depth: 1)
