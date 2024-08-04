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

import 'str_lookup.dart';
import 'str_matcher.dart';

class StrSubstitutor {
  static final String defaultEscape = '\$';

  static final StrMatcher defaultPrefix = StrMatcher.stringMatcher('\${');

  static final StrMatcher defaultSuffix = StrMatcher.stringMatcher('}');

  String escapeChar;
  StrMatcher prefixMatcher;
  StrMatcher suffixMatcher;
  StrLookup variableResolver;
  bool enableSubstitutionInVariables = false;

  StrSubstitutor(
      {required this.escapeChar,
      required this.prefixMatcher,
      required this.suffixMatcher,
      required this.variableResolver});

  factory StrSubstitutor.fromMap(Map map,
      {String? escapeChar,
      StrMatcher? prefixMatcher,
      StrMatcher? suffixMatcher}) {
    return StrSubstitutor(
        variableResolver: StrLookup.mapLookup(map),
        escapeChar: escapeChar ?? defaultEscape,
        prefixMatcher: prefixMatcher ?? defaultPrefix,
        suffixMatcher: suffixMatcher ?? defaultSuffix);
  }

  factory StrSubstitutor.fromLookup(StrLookup lookup,
      {String? escapeChar,
      StrMatcher? prefixMatcher,
      StrMatcher? suffixMatcher}) {
    return StrSubstitutor(
        variableResolver: lookup,
        escapeChar: escapeChar ?? defaultEscape,
        prefixMatcher: prefixMatcher ?? defaultPrefix,
        suffixMatcher: suffixMatcher ?? defaultSuffix);
  }

  String? replace(String? source, {int offset = 0, int? length}) {
    if (source==null) {
      return null;
    }
    int bufLen = length ?? source.length;
    String input = source;
    if (substitute(input, offset, bufLen) > 0) {
      return input;
    }
    if (length != null) {
      return source.substring(offset, length);
    } else {
      return source;
    }
  }

  int substitute(String buf, int offset, int length, {List? priorVariables}) {
    bool top = (priorVariables == null);
    bool altered = false;
    int lengthChange = 0;
    int bufEnd = offset + length;
    int pos = offset;

    // while (pos < bufEnd) {
    //   int startMatchLen = prefixMatcher.isMatch(buf, pos,
    //       bufferStart: offset, bufferEnd: bufEnd);
    //   if (startMatchLen == 0) {
    //     pos++;
    //   } else {

    //   }
    // }

    if (top) {
      return (altered ? 1 : 0);
    }
    return lengthChange;
  }
}
