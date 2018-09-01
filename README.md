# wud.sh : Wait Until Deployment !

wud.sh is a bash program to wait for a deployment to complete.

## Usage

### Installing

Install wud.sh in a directory and run it !

```
# Get wud.sh
chmod +x wud.sh
./wud.sh -v
```

### Waits for a deployment with default values.

Default values for initial wait, interval check and timeout.

```
./wud.sh -u https://www.site2deploy.com
```

## Running the tests

You should have as prerequisites a Python environment and pip installed. Tests are runned with [Robot Framework](http://robotframework.org/).

```
# Installation of Robot Framework
pip install -r tests/requirements.txt
# Run Tests
robot tests/
```

### And coding style

Code is reviewed with [ShellCheck](https://github.com/koalaman/shellcheck).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/jfx/wud.sh/tags).

## Authors

* **FX Soubirou** - *Initial work* - [Github repositories](https://github.com/jfx)

## License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version. See the [LICENSE](LICENSE) file for details.
