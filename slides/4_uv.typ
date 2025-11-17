#import "/globals.typ": *

= uv: A modern approach on python tooling
#components.progressive-outline(depth: 1)

== What is it?
#slide[
  #image("/assets/logo_uv.svg")
  What is `uv`?

  - A modern tool to manage a python development project:
    - Specify dependencies...
    - ...install them...
    - reproducibly!

  Developped by #link("https://astral.sh/")[Astral], a company building open source python tooling.
]


#slide[
  #image("/assets/logo_uv.svg")
  *Installation*
  ```bash
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```

  *Resources*
  - _Documentation:_ https://docs.astral.sh/uv
  - _GitHub repo:_ https://github.com/astral-sh/uv
  - _Python packaging documentation:_ https://packaging.python.org
]

#slide[
  - *Pros:*
    - Modern (August 2024)
    - Good ergonomics, intuitive UI
    - Fast (written in Rust)
    - Respects Python standards (e.g. PEP 621)
    - User-local installation (no need for `sudo`)
  - *_Cons_:*
    - Limited to Python (v.s. Pixi @fischer2025pixi or Nix/Guix)
]

== How does it work?

#slide[
  - Creates and edits the `pyproject.toml` file
  - Downloads and manages its own Python interpreters
  - Creates and modifies the virtual environment
    - Computes the versions of all dependencies (SAT solver)
    - Transitive dependencies are pinned too!
    - Save the result in the `uv.lock` file
    - Installs all dependencies in the virtual environment
]

== Dependency locking: the key to _true_ reproducibility

#slide[
  - All dependency versions are saved to the `uv.lock` lockfile
  - Ensures the environment can be reproduced later (same versions)
  - Generate/update the lock file: `uv lock`
  - Update dependencies: `uv lock --upgrade`

  -> `uv.lock` should be tracked by `git`
]

== How does it compare to other tools

#slide[
  - *Barebone `pip` (+ `venv`)*
    - Python based
    - Manages environments
    - "Slow"
    - No locking
  - *Poetry, pdm et al.*
    - Python based
    - "Slow"
    - Consistent locking!
  - *Conda*
    - Slow
    - Installs (some) _system libraries_
    - No locking

  #set align(bottom)
  _From uv2nix talk by \@adisbladis @uv2nix _
]

== Tutorial

#slide(title: "Installation")[

  On Linux and MacOS
  ```bash
  $ curl -LsSf https://astral.sh/uv/install.sh | sh
  ```
  On Windows
  #block[
    #set text(size: .9em)
    ```windows
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```
  ]

  No `sudo` privileges required

  Test it!
  ```bash
  $ uv --version
  ```
]

#slide(title: "Project initialization (uv init)")[
  #set text(size: .9em)
  -> Generates important files:
  - `pyproject.toml` (if necessary)
  - lockfile: `uv.lock`
  - `.git` and `.gitignore`
  - `main.py` (Hello-world example)

  ```bash
  # Existing projects
  $ uv init .

  # New project
  $ uv init new_project

  $ tree -a -L1
  ├── .git
  ├── .gitignore
  ├── main.py
  ├── pyproject.toml
  ├── .python-version
  └── README.md

  ```
][
  #set align(top)
  ```bash
  # Create the venv and install python
  $ uv sync

  # Two new files
  $ tree -a -L1
  ...
  ├── uv.lock
  └── .venv
  ```

  *Note:* To specify a python version:\
  ```bash
  $ uv init --python 3.12
  ```

]

#slide(title: "Adding dependencies")[
  #set text(size: .9em)
  Most important command: `uv add`.
  It is the best way to _add_ a dependency to the project

  What it does:
  - Adds the dependency specification (`numpy>=2.0,<2.4.0`) to `dependencies` in `pyproject.toml`
  - Creates the virtual environment (`.venv`) if necessary
  - Solves the environment (choose the version to install for each dependency)
  - Installs the required dependencies (including transitive ones) to the virtual environment
  - Updates `uv.lock`

  You can provide arbitrary dependency specifications:
  ```bash
  # Add a single dependency
  $ uv add "requests[security,tests]>2.8.1"

  # Add all dependencies from `requirements.txt`
  $ uv add -r requirements.txt

  # Remove a dependency
  $ uv remove requests
  ```
]

#slide(title: "Running the code")[
  Two solutions to run the code:

  1. `uv run main.py`
    - Automatically and transparently activates the virtual environment on the fly

  2. Manually activate the virtual environment
    ```bash
    $ source .venv/bin/activate

    $ python main.py
    ```
    Useful to quickly run scripts or the REPL
]

#slide(title: "Dependency groups and optional dependencies", align: top)[
  #set text(size: .9em)
  - `optional-dependencies`: for extra features
    - Adding an optional dependency
    ```bash
    $ uv add matplotlib --optional plot
    ```
    - In `pyproject.toml`
    ```toml
    [project.optional-dependencies]
    plot = [
      "matplotlib>=3.6.3"
    ]
    excel = [
      "odfpy",
      "xlsxwriter>=3.0.5"
    ]
    ```
    - Installing (in another project):
    ```bash
    $ uv add my_project[plot]
    $ pip install my_project[plot]
    ```
][
  #set text(size: .9em)
  - `dependency-groups`: for development dependencies
    - Adding a development dependency:
    ```bash
    $ uv add --group test pytest
    ```
    - In `pyproject.toml`
    ```toml
    [dependency-groups]
    dev = [
      "pytest"
    ]
    lint = [
      "ruff"
    ]
    ```

  #v(10%)
  #text(size: .8em)[https://pydevtools.com/handbook/explanation/what-are-optional-dependencies-and-dependency-groups/]
]

#slide(title: "The `uv pip` command")[
  `uv` implements most (all?) `pip` commands:

  *Example:*
  ```bash
  $ uv pip install numpy
  ```

  - Much faster than the original `pip`
  - Can sometimes be useful, but should not be used to install dependencies
  - Prefer `uv add`
]

#slide(title: "Storage management")[
  #set text(size: .8em)
  `uv` stores data in multiple places:
  - *#link("https://docs.astral.sh/uv/concepts/cache")[Cache:]*
    - `uv` uses aggressive caching to avoid re-downloading (and re-building) dependencies that have already been accessed in prior runs.
    - Contains downloaded and built dependencies, then linked in the virtual environments.
    - Where ? `~/.cache/uv` (`--cache-dir`, `$UV_CACHE_DIR`, `$XDG_CACHE_HOME/uv`)
    - Can be purged: `uv cache clean`
  #pause
  - *Configuration:*
    - Where ? `~/.config/uv`
  #pause
  - *Persistent data directory:*
    - Contains `python` interpreters and tools
    - `~/.local/share/uv` (`$XDG_DATA_HOME/uv`)
  #pause
  - *Virtual environment:*
    - By default, in `my_project/.venv/`
    - Contains links to the cache directory (must be on the same FS)
    - Contains all project dependencies

  *WARNING: Be careful when running on systems where `$HOME` storage is limited.*
]


#slide(title: "Use `uvx` to install/run an executable on the fly")[
  ```bash
  # Run a tool, right here, right now
  $ uvx ruff
  $ uv tool run ruff # same, but more verbose

  # Add dependencies on the fly
  $ uvx --with pandas,pyarrow ipython

  $ uvx --from jupyter-core jupyter lab
  ```

  To install a CLI tool with `uv`:
  ```bash
  $ uv tool install ruff
  $ which ruff
    /home/gaetan/.local/bin/ruff
  ```
]

#slide(title: "Deploying your projects to a remote system")[
  Install `uv`, clone your project and run your code, that's it!
  ```bash
  $(local) [~/work/project] git push
  $(local) [~/work/project] ssh cluster

  $(cluster) [~]          git clone <PROJECT_URL>
  $(cluster) [~/project]  cd project
  $(cluster) [~/project]  uv run main.py
  ```
]

#slide(title: "uv in Docker containers")[
  #set text(size: .7em)
  - `uv` can be used in Docker containers
  - Both _distroless_ and regular images are provided. `uv` is pre-installed
    - Distroless: `ghcr.io/astral-sh/uv:latest`
    - Alpine: `ghcr.io/astral-sh/uv:alpine`
    - Debian: `ghcr.io/astral-sh/uv:debian-slim`
  #pause
  #line(length: 100%)
  - Run your app!
  ```Dockerfile
  FROM ghcr.io/astral-sh/uv:debian-slim
  ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

  # Copy the project into the image
  ADD . /project

  # Sync the project into a new environment, asserting the lockfile is up to date
  WORKDIR /project

  RUN uv sync --locked

  # Presuming there is an `hello` command provided by the project
  CMD ["uv", "run", "hello"]
  ```

  https://docs.astral.sh/uv/guides/integration/docker
]


= Hands-on!
#components.progressive-outline(depth: 1)

#slide(composer: (3fr, 2fr))[
  #set text(size: .9em)
  *Installation*
  ```bash
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```
  - _Documentation:_ https://docs.astral.sh/uv
  - _GitHub repo:_ https://github.com/astral-sh/uv
  - _Python packaging documentation:_ https://packaging.python.org
  #line(length: 100%)
  #pause
  *Your turn!*
  - Pick a project:
    - Your own Python project
    - One of your students/colleagues' project
    - Open source code from an article
  - Bootstrap `uv`
][
  #pause
  *Cheatsheet:*
  ```bash
  # Init a project
  $ uv init .  # or uv init my_project

  # Add a dependency
  $ uv add numpy

  # Run the code
  $ uv run main.py

  # Sync the virtual environment
  $ uv sync
  ```
]
