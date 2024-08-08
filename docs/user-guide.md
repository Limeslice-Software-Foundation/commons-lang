# Commons Lang User Guide

This document serves as the user guide for the commons_lang package.

## Table of Contents

## Classes available for use
The following is a list of classes available
- BoolUtils
- StrBuilder
- 

## BoolUtils

### From String
Converts a String to a bool.

Example:
```Dart
  print(BoolUtils.fromString('y')); // true
  print(BoolUtils.fromString('t')); // true
  print(BoolUtils.fromString('Y')); // true
  print(BoolUtils.fromString('T')); // true
  print('');
  print(BoolUtils.fromString('n')); // false
  print(BoolUtils.fromString('N')); // false
  print(BoolUtils.fromString('f')); // false
  print(BoolUtils.fromString('F')); // false
  print('');
  print(BoolUtils.fromString('on')); // true
  print(BoolUtils.fromString('ON')); // true
  print(BoolUtils.fromString('On')); // true
  print('');
  print(BoolUtils.fromString('no')); // false
  print(BoolUtils.fromString('NO')); // false
  print(BoolUtils.fromString('No')); // false
  print('');
  print(BoolUtils.fromString('yes')); // true
  print(BoolUtils.fromString('YES')); // true
  print(BoolUtils.fromString('Yes')); // true
  print('');
  print(BoolUtils.fromString('Off')); // false
  print(BoolUtils.fromString('OFF')); // false
  print(BoolUtils.fromString('Off')); // false
  print('');
  print(BoolUtils.fromString('true')); // true
  print(BoolUtils.fromString('TRUE')); // true
  print(BoolUtils.fromString('True')); // true
  print('');
  print(BoolUtils.fromString('false')); // false
  print(BoolUtils.fromString('FALSE')); // false
  print(BoolUtils.fromString('False')); // false
```

## StrBuilder

StrBuilder provides some additional methods for working with Strings specifically around characters since the Dart language doesn't really have characters. In this case characters are represented as Strings with a length of 1.

This class uses 0 based indexing and so all positions given are assumed to be 0 based.

### Character Methods
It is possible to get, set and remove a character for a given position.

```Dart
StrBuilder builder = StrBuilder('Hello World!');
print(builder.charAt(1)); // e
builder.setCharAt(1,'i');
print(builder); // Hillo World!
builder.deleteCharAt(1);
print(builder); // Hllo World!
```

## StrSubstitutor

StrSubstitutor provides extremely powerful and flexible String interpolation.