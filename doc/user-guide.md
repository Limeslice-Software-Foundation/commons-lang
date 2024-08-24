# Commons Lang User Guide

This document serves as the user guide for the commons_lang package.

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Classes available in library](#classes-available-in-library)
- [Getting Started](#getting-started)
- [BoolUtils](#boolutils)
- [StringUtils](#stringutils)
- [StrBuilder](#strbuilder)
- [StrSubstitutor](#strsubstitutor)

## Classes available in library
The following is a list of classes available
- BoolUtils
- StrBuilder
- StrSubstitutor

## Getting Started

Add the package as a dependency.

### Installation
Add the package to your dependencies.

```
pub add commons_lang
```

### Import Package

Import the library in your code.

```Dart
import 'package:commons_lang/commons_lang.dart';
```

## BoolUtils
Bool utils provides two key functions, converting a bool from a string and converting a bool from an int.

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

## StringUtils

StringUtils provides some utility methods for working with Strings. It provides a split method that differs from the built in String#split method in Dart by allowing multiple delimiters and allowing delimiters to be escaped. You can specify whether tokens should be trimmed or not.

```Dart
String s = "abc, xyz , 123";
List<String> list = StringUtils.split(s, ',');
print(list[0]); // abc
print(list[1]); // xyz
print(list[2]); // 123
```

### Escaping Delimiters

You can escape delimiters. The default escape character is \\. Note that the escape character is removed from the token output to the list.

```Dart
String s = "abc\\,xyz, 123";
List<String> list = StringUtils.split(s, ',');
```

In this case the list will contain only two items namely: ['abc,xyz','123']

```Dart
print(list[0]); // abc,xyz
print(list[1]); // 123
```

### Multiple Delimiters

This feature is useful when you process Strings that may contain different delimiters but you are not sure exactly which delimiter each string contains. For example in properties files you could have an = and : as delimiters:

```
key1=value1
key2:value2
```

While processing this file line by line you need to check for either of the two delimiters. The split method will handle this.

```Dart
List<String> list = StringUtils.split(s, '=:');
```

It is important to note that a given string that contains both delimiters will result in the first delimiter being used.

```Dart
String s = "key1=value1,key2:value2";
List<String> list = StringUtils.split(s, '=:');
print(list[0]); // key1
print(list[1]); // value1,key2:value2
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

### Creation

There are two factory methods for quick creation of a StrSubstitutor.

#### From a Map

Perhaps the easiest and most common way to create a StrSubstitutor is from a Map containing the values to use for interpolation.

This can be done as follows:

```Dart
Map map = {"animal": "quick brown fox", "target": "lazy dog"};
StrSubstitutor sub = StrSubstitutor.fromMap(map);
```

#### From a StrLookup

You may with to subclass <code>StrLookup</code> to provide a different mapping function and then use this to create a StrSubstitutor.

An example as follows:

```Dart
StrLookup lookup = ...
StrSubstitutor sub = StrSubstitutor.fromLookup(lookup);
```

### Basic Interpolation

Simple variable substitution is done as follows using the <code>replace</code> method:

```Dart
Map map = {"animal": "quick brown fox", "target": "lazy dog"};
StrSubstitutor sub = StrSubstitutor.fromMap(map);

// The quick brown fox jumps over the lazy dog.
print(sub.replace('The \${animal} jumps over the \${target}.'));
```

### Escaping Variables
It is possible that you may wish to escape a variable to avoid substitution. This can be done using the eascape character as a prefix - the default eascape character is <code>$</code>.

```Dart
// Use \$ as an escape character
// The ${animal} jumps over the lazy dog.
print(sub.replace('The \$\${animal} jumps over the \${target}.'));
```

### Default Options

The default variable prefix is <code>${</code> and the default variable suffix is <code>}</code>. These were selected as they will be most familiar with Dart developers as Dart uses these for its own interpolation. The default escape character is <code>$</code>.

These can be changed to suit your preferences.

```Dart
sub.setVariablePrefix('#[');
sub.setVariableSuffix(']');
sub.escapeChar = '@';

// The quick brown fox jumps over the lazy dog.
print(sub.replace('The #[animal] jumps over the #[target].'));

// Use @ as an escape character
// The #[animal] jumps over the lazy dog.
print(sub.replace('The @#[animal] jumps over the #[target].'));
```

#### Non Existent Variables

Non existent variables are simply ignored and not interpolated.

```Dart
// The ${person} jumps over the lazy dog.
print(sub.replace('The \${person} jumps over the \${target}.'));
```

### Recursive Substition

Consider the following example

```Dart
Map map = {
  "animal": "\${critter}",
  "target": "\${pet}",
  "pet": "\${petCharacteristic} dog",
  "petCharacteristic": "lazy",
  "critter": "\${critterSpeed} \${critterColor} \${critterType}",
  "critterSpeed": "quick",
  "critterColor": "brown",
  "critterType": "fox",
};
StrSubstitutor sub = StrSubstitutor.fromMap(map);

// The quick brown fox jumps over the lazy dog.
print(sub.replace('The \${animal} jumps over the \${target}.'));
```
This provides very powerful interpolation features.

### Cyclic Variables

Cyclic variable substitution is detected and will result in an ArgumentError being thrown.

```Dart
Map map = {"moon": "\${sun}", "sun": "\${moon}"};
StrSubstitutor sub = StrSubstitutor.fromMap(map);
print(sub.replace('\${sun}'));
```

### Nested Variable Substition

Variables can be nested, that is variables within variables. By default this feature is disabled and has to be explicitly turned on using the <code>enableSubstitutionInVariables</code> bool field.

Consider this example:

```Dart
Map map = {
  "animal.1": "fox", 
  "animal.2": "mouse", 
  "species": "2",
  "target": "lazy dog"
};
StrSubstitutor sub = StrSubstitutor.fromMap(map);
sub.enableSubstitutionInVariables = true;

// The mouse jumps over the lazy dog.
print(sub.replace('The \${animal.\${species}} jumps over the \${target}.'));

map["species"] = "1";

// The fox jumps over the lazy dog.
print(sub.replace('The \${animal.\${species}} jumps over the \${target}.'));
```

Again, this provides extremely powerful and flexible interpolation functionality.

### Escaped Nested Variables

It is important to note that nested variables within escaped variables will be interpolated.

```Dart
// Use \$ as an escape character
// The \${quick brown fox} jumps over the lazy dog.
print(sub.replace('The \$\${\${animal}} jumps over the \${target}.'));
```