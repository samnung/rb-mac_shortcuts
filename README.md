
# mac_shortcuts

[![Build Status](http://img.shields.io/travis/samnung/rb-mac_shortcuts/master.svg?style=flat)](https://travis-ci.org/samnung/rb-mac_shortcuts)
[![Gem Version](http://img.shields.io/gem/v/mac_shortcuts.svg?style=flat)](http://badge.fury.io/rb/mac_shortcuts)
[![Coverage Status](https://coveralls.io/repos/samnung/rb-mac_shortcuts/badge.svg)](https://coveralls.io/r/samnung/rb-mac_shortcuts)
[![Code Climate](https://codeclimate.com/github/samnung/rb-mac_shortcuts/badges/gpa.svg)](https://codeclimate.com/github/samnung/rb-mac_shortcuts)
[![Inline docs](http://inch-ci.org/github/samnung/rb-mac_shortcuts.png)](http://inch-ci.org/github/samnung/rb-mac_shortcuts)


Do you hate setting custom shortcuts in applications on Mac as much as I do?
Well, here is CLI tool to resolve this pain.


## Usage

```bash
mac_shortcuts set <application-name> <menu-title> <shortcut-string>
```

- `application-name` name or path to plist of application preferences
- `menu-title` text in menu action on which you want to set shortcut
- `shortcut-string` can use human names of the modifier keys, like `cmd`, `ctrl`, `alt`, `option`, `shift`, ...


## Examples

```bash
mac_shortcuts set Terminal "Bigger" "cmd + ctrl + ="
```


## Installation

```bash
[sudo] gem install mac_shortcuts
```


## Author

Roman Kříž (roman@kriz.io)


## License

This project is licensed under the terms of the MIT license. See the LICENSE.md file.
