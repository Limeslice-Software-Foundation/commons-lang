// Licensed to the Limeslice Software Foundation (LSF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The LSF licenses this file to You under the MIT License (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
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
  group('split', () {
    test('Test split', () {
      String s = "abc, xyz , 123";
      List<String> list = StringUtils.split(s, ',');
      expect(list.length, equals(3));
      expect(list[0], equals('abc'));
      expect(list[1], equals('xyz'));
      expect(list[2], equals('123'));
    });

    test('Test split no trim', () {
      String s = "abc, xyz , 123";
      List<String> list = StringUtils.split(s, ',', false);
      expect(list.length, equals(3));
      expect(list[0], equals('abc'));
      expect(list[1], equals(' xyz '));
      expect(list[2], equals(' 123'));
    });

    test('Test split with escaped separator', () {
      String s = "abc\\,xyz, 123";
      List<String> list = StringUtils.split(s, ',');
      expect(list.length, equals(2));
      expect(list[0], equals('abc,xyz'));
      expect(list[1], equals('123'));
    });

    test('Test split empty values', () {
      String s = ",,";
      List<String> list = StringUtils.split(s, ',');
      expect(list.length, equals(3));
      expect(list[0], equals(''));
      expect(list[1], equals(''));
      expect(list[2], equals(''));
    });

    test('Test split with ending slash', () {
      String s = "abc, xyz\\";
      List<String> list = StringUtils.split(s, ',');
      expect(list.length, equals(2));
      expect(list[0], equals('abc'));
      expect(list[1], equals('xyz\\'));
    });

    test('Test split with escaped escape char', () {
      List<String> list = StringUtils.split("C:\\Temp\\\\,xyz", ',');
      expect(list.length, equals(2));
      expect(list[0], equals('C:\\Temp\\'));
      expect(list[1], equals('xyz'));
    });
  });
}
