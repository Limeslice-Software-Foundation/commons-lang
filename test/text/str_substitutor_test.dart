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
  late Map? values;

  setUp(() {
    values = {"animal": "quick brown fox", "target": "lazy dog"};
  });

  tearDown(() {
    values = null;
  });

  group('Test replace methods', () {
    void doTestReplace(
        String expectedResult, String replaceTemplate, bool substring) {
      String expectedShortResult =
          expectedResult.substring(1, expectedResult.length - 1);
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);

      expect(sub.replace(replaceTemplate), equals(expectedResult));
      if (substring) {
        expect(
            sub.replace(replaceTemplate,
                offset: 1, length: replaceTemplate.length - 2),
            equals(expectedShortResult));
      }
    }

    doTestNoReplace(String? replaceTemplate) {
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);
      if (replaceTemplate == null) {
        expect(sub.replace(null), isNull);
      } else {
        expect(sub.replace(replaceTemplate), equals(replaceTemplate));
      }
    }

    test('Tests simple key replace.', () {
      doTestReplace("The quick brown fox jumps over the lazy dog.",
          "The \${animal} jumps over the \${target}.", true);
    });

    test('Test replace solo', () {
      doTestReplace("quick brown fox", "\${animal}", false);
    });

    test('test replace no variables', () {
      doTestNoReplace("The balloon arrived.");
    });

    test('Test replace null', () {
      doTestNoReplace(null);
    });

    test('Test replace empty', () {
      doTestNoReplace("");
    });

    test('Test replace unknown key', () {
      doTestReplace("The \${person} jumps over the lazy dog.",
          "The \${person} jumps over the \${target}.", true);
    });

    test('Replace changed map', () {
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);
      values!["target"] = "moon";
      String expected = "The quick brown fox jumps over the moon.";
      String? actual = sub.replace("The \${animal} jumps over the \${target}.");
      expect(actual, equals(expected));
    });

    test('Test replace adjacent at start', () {
      values!["code"] = "GBP";
      values!["amount"] = "12.50";
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);
      String expected = "GBP12.50 charged";
      String? actual = sub.replace("\${code}\${amount} charged");
      expect(actual, equals(expected));
    });

    test('Test replace adjacent at end', () {
      values!["code"] = "GBP";
      values!["amount"] = "12.50";
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);
      String expected = "GBP12.50 charged";
      String? actual = sub.replace("Amount is \${code}\${amount}");
      expect(actual, equals(expected));
    });

    test('Test replace recursive', () {
      values!["animal"] = "\${critter}";
      values!["target"] = "\${pet}";
      values!["pet"] = "\${petCharacteristic} dog";
      values!["petCharacteristic"] = "lazy";
      values!["critter"] = "\${critterSpeed} \${critterColor} \${critterType}";
      values!["critterSpeed"] = "quick";
      values!["critterColor"] = "brown";
      values!["critterType"] = "fox";
      doTestReplace("The quick brown fox jumps over the lazy dog.",
          "The \${animal} jumps over the \${target}.", true);
    });

    test('Test replace escaping', () {
      doTestReplace("The \${animal} jumps over the lazy dog.",
          "The \$\${animal} jumps over the \${target}.", true);
    });

    test('Test replace solo escaping', () {
      doTestReplace("\${animal}", "\$\${animal}", false);
    });

    test('Test replace complex escaping', () {
      doTestReplace("The \${quick brown fox} jumps over the lazy dog.",
          "The \$\${\${animal}} jumps over the \${target}.", true);
    });

    test('Test replace no prefix or suffix', () {
      doTestReplace("The animal jumps over the lazy dog.",
          "The animal jumps over the \${target}.", true);
    });

    test('Test replace incomplete prefix', () {
      doTestReplace("The {animal} jumps over the lazy dog.",
          "The {animal} jumps over the \${target}.", true);
    });

    test('Test replace prefix no suffix', () {
      doTestReplace("The \${animal jumps over the \${target} lazy dog.",
          "The \${animal jumps over the \${target} \${target}.", true);
    });

    test('Test replace suffix no prefix', () {
      doTestReplace("The animal} jumps over the lazy dog.",
          "The animal} jumps over the \${target}.", true);
    });

    test('Test replace empty keys', () {
      doTestReplace("The \${} jumps over the lazy dog.",
          "The \${} jumps over the \${target}.", true);
    });

    test('Test replace to same input', () {
      values!["animal"] = "\$\${\${thing}}";
      values!["thing"] = "animal";
      doTestReplace("The \${animal} jumps.", "The \${animal} jumps.", true);
    });

    test('Test cyclic replacement', () {
      Map map = {
        "animal": "\${critter}",
        "target": "\${pet}",
        "pet": "\${petCharacteristic} dog",
        "petCharacteristic": "lazy",
        "critter": "\${critterSpeed} \${critterColor} \${critterType}",
        "critterSpeed": "quick",
        "critterColor": "brown",
        "critterType": "\${animal}",
      };
      StrSubstitutor sub = StrSubstitutor.fromMap(map);
      expect(() => sub.replace("The \${animal} jumps over the \${target}."),
          throwsA(TypeMatcher<Exception>()));
    });

    test('Test replace weird patterns', () {
      doTestNoReplace("");
      doTestNoReplace("\${}");
      doTestNoReplace("\${ }");
      doTestNoReplace("\${\t}");
      doTestNoReplace("\${\n}");
      doTestNoReplace("\${\b}");
      doTestNoReplace("\${");
      doTestNoReplace("\$}");
      doTestNoReplace("}");
      doTestNoReplace("\${}\$");
      doTestNoReplace("\${\${");
      doTestNoReplace("\${\${}}");
      doTestNoReplace("\${\$\${}}");
      doTestNoReplace("\${\$\$\${}}");
      doTestNoReplace("\${\$\$\${\$}}");
      doTestNoReplace("\${\${}}");
      doTestNoReplace("\${\${ }}");
    });

    test('Test partial string replace - no replace', () {
      StrSubstitutor sub = StrSubstitutor.fromLookup(StrLookup.noneLookup);
      String expected = "\${animal} jumps";
      String? actual = sub.replace("The \${animal} jumps over the \${target}.",
          offset: 4, length: 15);
      expect(actual, equals(expected));
    });

    test('Test replace in variable', () {
      values!["animal.1"] = "fox";
      values!["animal.2"] = "mouse";
      values!["species"] = "2";
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);
      sub.enableSubstitutionInVariables = true;

      String expected = "The mouse jumps over the lazy dog.";
      String? actual =
          sub.replace("The \${animal.\${species}} jumps over the \${target}.");
      expect(actual, equals(expected));

      expected = "The fox jumps over the lazy dog.";
      actual =
          sub.replace("The \${animal.\${species}} jumps over the \${target}.");
      expect(actual, equals(expected));
    });

    test('Test replace in variable disabled', () {
      values!["animal.1"] = "fox";
      values!["animal.2"] = "mouse";
      values!["species"] = "2";
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);
      sub.enableSubstitutionInVariables = false;

      String expected = "The \${animal.\${species}} jumps over the lazy dog.";
      String? actual =
          sub.replace("The \${animal.\${species}} jumps over the \${target}.");
      expect(actual, equals(expected));
    });

    test('', () {
      values!["animal.2"] = "brown fox";
      values!["animal.1"] = "white mouse";
      values!["color"] = "white";
      values!["species.white"] = "1";
      values!["species.brown"] = "2";
      StrSubstitutor sub = StrSubstitutor.fromMap(values!);
      sub.enableSubstitutionInVariables = true;

      String expected = "The white mouse jumps over the lazy dog.";
      String? actual = sub.replace(
          "The \${animal.\${species.\${color}}} jumps over the \${target}.");
      expect(actual, equals(expected));
    });
  });
}
