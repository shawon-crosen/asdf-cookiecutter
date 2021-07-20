<div align="center">

# asdf-cookiecutter [![Build](https://github.com/shawon-crosen/asdf-cookiecutter/actions/workflows/build.yml/badge.svg)](https://github.com/shawon-crosen/asdf-cookiecutter/actions/workflows/build.yml) [![Lint](https://github.com/shawon-crosen/asdf-cookiecutter/actions/workflows/lint.yml/badge.svg)](https://github.com/shawon-crosen/asdf-cookiecutter/actions/workflows/lint.yml)


[cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add cookiecutter
# or
asdf plugin add cookiecutter https://github.com/shawon-crosen/asdf-cookiecutter.git
```

cookiecutter:

```shell
# Show all installable versions
asdf list-all cookiecutter

# Install specific version
asdf install cookiecutter latest

# Set a version globally (on your ~/.tool-versions file)
asdf global cookiecutter latest

# Now cookiecutter commands are available
cookiecutter --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/shawon-crosen/asdf-cookiecutter/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Shawon Crosen](https://github.com/shawon-crosen/)
