# toolchain-arm-none-eabi-gcc

[![CI](https://github.com/apcountryman/toolchain-arm-none-eabi-gcc/actions/workflows/ci.yml/badge.svg)](https://github.com/apcountryman/toolchain-arm-none-eabi-gcc/actions/workflows/ci.yml)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg)](CODE_OF_CONDUCT.md)

toolchain-arm-none-eabi-gcc is a CMake toolchain for cross compiling for Arm Cortex-M and
Cortex-R microcontrollers using arm-none-eabi-gcc.
In addition to configuring CMake for cross compiling with arm-none-eabi-gcc, the toolchain
provides optional OpenOCD utilities.

## Obtaining the Source Code

HTTPS:
```shell
git clone https://github.com/apcountryman/toolchain-arm-none-eabi-gcc.git
```
SSH:
```shell
git clone git@github.com:apcountryman/toolchain-arm-none-eabi-gcc.git
```

## Usage (Dependency)

To use this toolchain, simply set `CMAKE_TOOLCHAIN_FILE` to the path to this repository's
`toolchain.cmake` file when initializing CMake.

To use the OpenOCD utilities, add the path to this repository to the project's
`CMAKE_MODULE_PATH`, and include `openocd-utilities.cmake`.
The OpenOCD utilities include the following functions:
- `add_openocd_target()`
- `add_openocd_flash_programming_target()`

Documentation for the usage of the OpenOCD utilities [can be found in the
`openocd-utilities.cmake` file in this repository](openocd-utilities.cmake).

### Finding Tools

This toolchain expects to find `arm-none-eabi-gcc`, `arm-none-eabi-g++`, associated binary
utilities, and `openocd` in the path(s) searched by CMake's `find_program()` command.
`openocd` is only required if `openocd-utilities.cmake` is included.
If the toolchain fails to locate tools, consult the documentation for CMake's
`find_program()` command.

## Usage (Development)

This repository's Git `pre-commit.sh` hook script is the simplest way to configure, build,
and test this project during development.
See the `pre-commit.sh` script's help text for usage details.
```shell
./git/hooks/pre-commit.sh --help
```

Additional checks, such as static analysis, are performed by this project's GitHub Actions
CI workflow.

## Versioning

toolchain-arm-none-eabi-gcc follows the [Abseil Live at Head
philosophy](https://abseil.io/about/philosophy).

## Workflow

toolchain-arm-none-eabi-gcc uses the [GitHub
flow](https://guides.github.com/introduction/flow/) workflow.

## Git Hooks

To install this repository's Git hooks, run the `install.sh` script located in the
`git/hooks` directory.
See the `install.sh` script's help text for usage details.
```
$ ./git/hooks/install.sh --help
```

## Code of Conduct

toolchain-arm-none-eabi-gcc has adopted the Contributor Covenant 2.0 code of conduct.
For more information, [see the `CODE_OF_CONDUCT.md` file in this
repository](CODE_OF_CONDUCT.md).

## Contributing

If you are interested in contributing to toolchain-arm-none-eabi-gcc, please [read the
`CONTRIBUTING.md` file in this repository](CONTRIBUTING.md).

## Authors

- Andrew Countryman

## License

toolchain-arm-none-eabi-gcc is licensed under the Apache License, Version 2.0.
For more information, [see the `LICENSE` file in this repository](LICENSE).
