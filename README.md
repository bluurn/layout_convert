# Basic latin2cyrillic layout swapper [![Gem Version](https://badge.fury.io/rb/layout_convert.svg)](http://badge.fury.io/rb/layout_convert) [![Code Climate](https://codeclimate.com/github/bluurn/layout_convert.png)](https://codeclimate.com/github/bluurn/layout_convert) [![Coverage](https://codeclimate.com/github/bluurn/layout_convert/coverage.png)](https://codeclimate.com/github/bluurn/layout_convert) [![Build Status](https://travis-ci.org/bluurn/layout_convert.svg?branch=master)](https://travis-ci.org/bluurn/layout_convert)

A String class now has these methods available
* cyrillic?
* latin?
* mixed?
* cyrillish?
* latinish?
* swap_layout

## Usage

It's simple, just type
```
"ghbdtn".swap_layout
```
And you will get this result
```
=> "привет"
```
Easy! :)
