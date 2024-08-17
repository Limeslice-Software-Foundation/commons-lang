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
  group('fromInt', () {
    test('Single character input', () {
      expect(BoolUtils.fromInt(0), equals(false));
      expect(BoolUtils.fromInt(1), equals(true));
      expect(BoolUtils.fromInt(-1), equals(true));
    });
  });

  group('fromString', () {
    test('Single character input', () {
      expect(BoolUtils.fromString('t'), equals(true));
      expect(BoolUtils.fromString('T'), equals(true));
      expect(BoolUtils.fromString('y'), equals(true));
      expect(BoolUtils.fromString('Y'), equals(true));

      expect(BoolUtils.fromString('n'), equals(false));
      expect(BoolUtils.fromString('N'), equals(false));
      expect(BoolUtils.fromString('f'), equals(false));
      expect(BoolUtils.fromString('F'), equals(false));

      expect(BoolUtils.fromString('A'), equals(false));
      expect(BoolUtils.fromString('a'), equals(false));
      expect(BoolUtils.fromString('B'), equals(false));
      expect(BoolUtils.fromString('b'), equals(false));
    });

    test('Double character input', () {
      expect(BoolUtils.fromString('on'), equals(true));
      expect(BoolUtils.fromString('On'), equals(true));
      expect(BoolUtils.fromString('ON'), equals(true));

      expect(BoolUtils.fromString('no'), equals(false));
      expect(BoolUtils.fromString('NO'), equals(false));
      expect(BoolUtils.fromString('No'), equals(false));

      expect(BoolUtils.fromString('Ab'), equals(false));
      expect(BoolUtils.fromString('BC'), equals(false));
    });

    test('Tripple character input', () {
      expect(BoolUtils.fromString('yes'), equals(true));
      expect(BoolUtils.fromString('Yes'), equals(true));
      expect(BoolUtils.fromString('YES'), equals(true));

      expect(BoolUtils.fromString('off'), equals(false));
      expect(BoolUtils.fromString('Off'), equals(false));
      expect(BoolUtils.fromString('OFF'), equals(false));

      expect(BoolUtils.fromString('Abc'), equals(false));
      expect(BoolUtils.fromString('BCD'), equals(false));
    });

    test('Variations of "true" return true', () {
      expect(BoolUtils.fromString('true'), equals(true));
      expect(BoolUtils.fromString('True'), equals(true));
      expect(BoolUtils.fromString('TRUE'), equals(true));
    });

    test('Variations of "false" return false', () {
      expect(BoolUtils.fromString('false'), equals(false));
      expect(BoolUtils.fromString('False'), equals(false));
      expect(BoolUtils.fromString('FALSE'), equals(false));
    });
  });
}
