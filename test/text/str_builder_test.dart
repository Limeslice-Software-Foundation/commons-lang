// Licensed to the Limeslice Software Foundation (LSF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The LSF licenses this file to You under the Apache License, Version 2.0
// (the "License"); you may not use this file except in compliance with
// the License.  You may obtain a copy of the License at
//
// https://limeslice.org/license.txt
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:commons_lang/commons_lang.dart';
import 'package:test/test.dart';

void main() {
  late StrBuilder buf;

  setUp(() {
    buf = StrBuilder(value: 'Hello World!');
  });

  tearDown(() {});

  group('Test char methods', () {
    test('Test char at', () {
      expect(() => buf.charAt(-1), throwsA(TypeMatcher<ArgumentError>()));
      expect(() => buf.charAt(12), throwsA(TypeMatcher<ArgumentError>()));

      expect(buf.charAt(0), equals('H'));
      expect(buf.charAt(1), equals('e'));
      expect(buf.charAt(2), equals('l'));
      expect(buf.charAt(3), equals('l'));
      expect(buf.charAt(4), equals('o'));
      expect(buf.charAt(5), equals(' '));
      expect(buf.charAt(6), equals('W'));
      expect(buf.charAt(7), equals('o'));
      expect(buf.charAt(8), equals('r'));
      expect(buf.charAt(9), equals('l'));
      expect(buf.charAt(10), equals('d'));
      expect(buf.charAt(11), equals('!'));
    });
    test('Test set char at', () {
      expect(
          () => buf.setCharAt(-1, 'X'), throwsA(TypeMatcher<ArgumentError>()));
      expect(
          () => buf.setCharAt(12, 'X'), throwsA(TypeMatcher<ArgumentError>()));

      buf.setCharAt(6, 'J');
      buf.setCharAt(7, 'o');
      buf.setCharAt(8, 'n');
      buf.setCharAt(9, 'n');
      buf.setCharAt(10, 'y');
      expect(buf.toString(), equals('Hello Jonny!'));
    });
    test('Test delete char at', () {
      expect(() => buf.deleteCharAt(-1), throwsA(TypeMatcher<ArgumentError>()));
      expect(() => buf.deleteCharAt(12), throwsA(TypeMatcher<ArgumentError>()));
      buf.deleteCharAt(1);
      buf.deleteCharAt(3);
      buf.deleteCharAt(5);
      expect(buf.toString(), equals('Hll Wrld!'));
    });
  });

  group('Test string methods', () {
    test('Test clear', () {
      buf.clear();
      expect(buf.toString(), equals(''));
    });
    test('Test length', () {
      expect(buf.length(), equals(12));
    });
    test('Test replace', () {
      buf.replace(6, 12, 'Johnny');
      expect(buf.toString(), equals('Hello Johnny'));
    });

    test('Test substring', () {
      StrBuilder sb = StrBuilder(value: 'Hello from Dart');
      expect(sb.subString(6, 4), equals('from'));
      expect(sb.subString(11, 4), equals('Dart'));
    });
  });
}
