#import "/globals.typ": *


= Python packaging
#components.progressive-outline(depth: 1)

#slide[
  - Python projects often depend on many libraries
  - Many tools (`setuptools`, `pip`, `conda`, `poetry`)
  - Many standards (`setup.py`, `pyproject.toml`, `requirements.txt`, `conda-env.yml`)

  -> Often laborious to "deploy" a project
][
  #image("/assets/python_hell.png")
]

#slide(title: "Main components")[
  Main components:
  - The `build-system`: Runs when you invoke `pip install`\
    Ex: `setuptools`, `poetry`, `hatchling`, `uv-build`, ...
    #pause
  - The dependencies specification
    Ex: `pyproject.toml`'s `dependencies` list (recommended), `requirements.txt`, `setup.py`'s `install_requires` (`setuptools` only)
    #pause
  - Optionally, a project/environment management tool:\
    Ex: `uv`, `poetry`, `conda`, ...
    #pause
  - Packaging repository *Pypi*:
    - Source distributions (`sdist`)
    - Binary builds (`wheels`)
]

#slide(title: "Dependency specification")[
  Formalized in #link("https://peps.python.org/pep-0508")[PEP-508].

  *Examples:*
  - `numpy`
  - `torch==2.9.1`
  - `pandas>=2.0,<2.4`
  - `ray[data]`
  - `requests [security,tests] >2.8.1,=2.8.* ; python_version < "2.7"`

  *Explanation:*
  - Dependency name: `requests`
  - Optional features: `[security,tests]`
  - Version constraints: `>2.8.1,=2.8.*`
  - Platform compatibility algebra: `python_version < "2.7"`

  #set align(bottom)
  _From uv2nix talk by \@adisbladis @uv2nix _
]

#slide(title: "requirements.txt", composer: (4fr, 3fr))[
  #set text(size: .9em)

  ```
  requests
  colorama; platform_system == "Windows"
  importlib; python_version
  numpy
  torch>=2.8.0
  tqdm
  git+ssh://git@github.com/echweb/echweb-utils.git
  git+https://github.com/DavidDiazGuerra/gpuRIR
  ```
][
  - Came from Pip
  - List of PEP-508 strings
  - Usually used with\
    `pip install -r requirements.txt`
  - Often alongside `setup.py`

  #set align(bottom)
  _From uv2nix talk by \@adisbladis @uv2nix _
]

#slide(title: "setup.py", composer: (5fr, 4fr))[
  #set text(size: .9em)
  ```py
  from distutils.core import setup

  setup(
    name="my_project",
    version="0.1.0",
    description="My great project",
    long_description=open('README.md').read(),
    install_requires=[
      "numpy",
      "torch>=2.8.0"
    ],
    author="Gaétan Lepage",
    author_email="gaetan@glepage.com",
    url="https://my-project.sh",
    license="MIT",
  )
  ```
][
  - Originated with `distutils`/`setuptools`
  - Most popular `build-system`
  - Project metadata as Python code
  - Build with `python setup.py build`
  - Develop with `pip install -e`
  - Not a standard
  - Can be used for complex building (e.g. native code compilation)

  #set align(bottom)
  _From uv2nix talk by \@adisbladis @uv2nix _
]

#slide(title: "pyproject.toml")[
  ```toml
  name = "my_project"
  version = "0.1.0"
  description = "My great project"
  readme = "README.md"
  license = "MIT"

  requires-python = ">=3.9,<3.14"
  dependencies = [
      "numpy",
      "torch>=2.8.0"
  ]

  [build-system]
  requires = ["setuptools", "setuptools-scm"]
  build-backend = "setuptools.build_meta"
  ```
][
  - Standard way of specifying the project metadata
  - Specification: #link("https://peps.python.org/pep-0517")[PEP-517] and  #link("https://peps.python.org/pep-0621")[PEP-621]
  - Contains the list of dependencies (no more `requirements.txt`)

  #set align(bottom)
  _From uv2nix talk by \@adisbladis @uv2nix _
]
