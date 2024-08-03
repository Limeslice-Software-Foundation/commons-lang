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
  test('Test String Matcher', () {
    String buffer = "abcdef";
    StrMatcher matcher = StrMatcher.stringMatcher("bc");
    expect(matcher.isMatch(buffer, 0), equals(0));
    expect(matcher.isMatch(buffer, 1), equals(2));
    expect(matcher.isMatch(buffer, 2), equals(0));
  });
}