# The road to reprod`uv`ibility in Python

This repo contains the slides for the presentation I gave for [GRICAD](https://gricad.univ-grenoble-alpes.fr/), on 2025 Nov. 18.

## What is `uv`?

[uv](https://docs.astral.sh/uv) is a modern python management tool.
It is, according to me, the most convenient and performant solution for developing in Python.
Thanks to its `uv.lock` lock file, it ensures that the code is reproducible

## Compiling the slides

The document is made using [Typst](https://typst.app/).

To compile it,
```bash
typst compile main.typ
```

## Resources

### Research reproducibility

- [Reproducibility, Replicability and Repeatability: A survey of reproducible research with a focus on high performance computing](https://www.sciencedirect.com/science/article/pii/S157401372400039X?fr=RR-2&ref=pdf_download&rr=9a08e0806f499e85)
- [French software and environments reproducibility working group](https://gt-env-logiciels.gricad-pages.univ-grenoble-alpes.fr/sandbox-notecards)

### Python packaging

- Official Python packaging documentation: [packaging.python.org](https://packaging.python.org/en/latest/)
- `pyproject.toml` specification:
    - [PEP 517 – A build-system independent format for source trees](https://peps.python.org/pep-0517)
    - [PEP 621 – Storing project metadata in pyproject.toml](https://peps.python.org/pep-0621)
- [PEP 508 – Dependency specification for Python Software Packages](https://peps.python.org/pep-0508/)

### uv

- [Documentation](https://docs.astral.sh/uv)
- [GitHub repository](https://github.com/astral-sh/uv)
- Tutorials:
    - [Python UV: The Ultimate Guide to the Fastest Python Package Manager](https://www.datacamp.com/tutorial/python-uv)
    - [uv is the best thing to happen to the Python ecosystem in a decade](https://emily.space/posts/251023-uv)
- [@adisbladis's talk on `uv2nix` at NixCon 2025](https://talks.nixcon.org/nixcon-2025/talk/Y8TSAW/)
