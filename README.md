# toolchain-arm-none-eabi-gcc
[![CI](https://github.com/apcountryman/toolchain-arm-none-eabi-gcc/actions/workflows/ci.yml/badge.svg)](https://github.com/apcountryman/toolchain-arm-none-eabi-gcc/actions/workflows/ci.yml)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg)](CODE_OF_CONDUCT.md)

`toolchain-arm-none-eabi-gcc` is a CMake toolchain for cross compiling for Arm Cortex-M
and Cortex-R microcontrollers using arm-none-eabi-gcc.

## Obtaining the Source Code
HTTPS:
```shell
git clone https://github.com/apcountryman/toolchain-arm-none-eabi-gcc.git
```
SSH:
```shell
git clone git@github.com:apcountryman/toolchain-arm-none-eabi-gcc.git
```

## Versioning
`toolchain-arm-none-eabi-gcc` follows the [Abseil Live at Head
philosophy](https://abseil.io/about/philosophy).

## Workflow
`toolchain-arm-none-eabi-gcc` uses the [GitHub
flow](https://guides.github.com/introduction/flow/) workflow.

## Git Hooks
To install this repository's Git hooks, run the `install` script located in the
`git/hooks` directory.
See the script's help text for usage details.
```
$ ./git/hooks/install --help
```

## Code of Conduct
`toolchain-arm-none-eabi-gcc` has adopted the Contributor Covenant 2.0 code of conduct.
For more information, [see the `CODE_OF_CONDUCT.md` file in this
repository](CODE_OF_CONDUCT.md).

## Contributing
If you are interested in contributing to `toolchain-arm-none-eabi-gcc`, please [read the
`CONTRIBUTING.md` file in this repository](CONTRIBUTING.md).

## Authors
- Andrew Countryman

## License
`toolchain-arm-none-eabi-gcc` is licensed under the Apache License, Version 2.0.
For more information, [see the LICENSE file in this repository](LICENSE).
