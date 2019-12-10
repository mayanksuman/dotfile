# Introduction

Python is setup using `pyenv` in this configuration.
Along with `pyenv`, `pipenv` is also used for dependency management.
These two different piece of software have following roles:

1. `pyenv`: install different python versions using `pyenv install <version>` (aliased as `pi <version>`) and make virtual environments based on them using `pyenv virtualenv <version> <virtualenv_name>` (aliased to `pv <version> <virtualenv_name>`)
2. `pipenv` is used only for dependency management. It can be used for making virtualenvs but it is not recommended under the current configureation.

# Starting new project

To start a new project, following actions are required:

1. Make the required directory and `cd` into it
2. Make a new virtualenv by `pyenv virtual <version> <virtualenv_name>`. If you do not have the required python version under `pyenv`, then you need to install it before this command by `pyenv install <version>`. If you want to use already existing virtualenv please skip this step.
3. Declare that the folder will use virtualenv by command `pyenv local <virtualenv_name>`. The virtualenv should be active now.
4. Use `pipenv` or `conda` (only for miniconda or anaconda version) to install libraries using command `pipenv install <lib_name>` or `conda install <lib_name>`. `pipenv` can also be used for miniconda and anaconda based virtualenv but it is not recommended as package from `conda` are better focused for scientific workload than packages from `pypi` (`pipenv` install from `pypi`)

Note: Do not use `pipenv` or `conda` to make new virtualenv. The new virtualenv should only be made by step 2. It should also be noted that if virtualenv is made from miniconda/anaconda, then it will automatically added in `jupyter` kernel provided `ipykernel` is installed.

# Details about the current setup

The current setup by default install `python 3.8.0` and `miniconda-latest` versions. It also make three different vertualenvs from `miniconda-latest` (`jupyter`, `conda_tools`, and `num_python`). `jupyter` has `jupyter lab` set up inside it and `conda_tools` install numerical programs like `Orange3` and `glueviz`. `num_python` is general purpose numerical environment for scientific workload.

By default, the default global versions for `pyenv` is `3.8.0 jupyter conda_tools` (in order; set by command `pyenv global 3.8.0 jupyter conda_tools` in `install.sh`). Hence, the default version of python is `3.8.0` (not a miniconda version) and cli/gui programs from `jupyter` and `conda_tools` can be used in a newly opened terminal.

# Managing virtualenv under pyenv

virtualenv can be made using `pyenv virtualenv <version> <virtualenv_name>` and can be deleted with command `pyenv unistall <virtualenv_name>`. All the virtualens in `pyenv` can be displayed by `pyenv virtualenvs`.

# Some Tips

Under `pipenv`, the project specific environment variable can be saved in `.env` file.
