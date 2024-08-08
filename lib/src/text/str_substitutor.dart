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

import 'package:commons_lang/src/text/str_builder.dart';

import 'str_lookup.dart';
import 'str_matcher.dart';

/// Provides extremely powerful and flexible String interpolation.
class StrSubstitutor {
  /// The default escape char is '$'.
  static final String defaultEscape = '\$';

  /// The default prefix matcher uses '${'.
  static final StrMatcher defaultPrefix = StrMatcher.stringMatcher('\${');

  /// The default suffix matcher uses '}'.
  static final StrMatcher defaultSuffix = StrMatcher.stringMatcher('}');

  /// The escape character to use.
  String escapeChar;

  /// The prefix matcher to use.
  StrMatcher prefixMatcher;

  /// The suffix matcher to use.
  StrMatcher suffixMatcher;

  /// The variable resolver to look up variables.
  StrLookup variableResolver;

  /// If variable substitution should be used.
  bool enableSubstitutionInVariables = false;

  /// Create a new StrSubstitutor.
  StrSubstitutor(
      {required this.escapeChar,
      required this.prefixMatcher,
      required this.suffixMatcher,
      required this.variableResolver});

  /// Create a new StrSubstitutor using a map for variable lookup.
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

  /// Create a new StrSubstitutor using the given variable lookup.
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

  /// Shortcut method to set the prefix matcher to the given String.
  void setVariablePrefix(String prefix) {
    prefixMatcher = StrMatcher.stringMatcher(prefix);
  }

  /// Shortcut method to set the suffix matcher to the given String.
  void setVariableSuffix(String suffix) {
    suffixMatcher = StrMatcher.stringMatcher(suffix);
  }

  /// Perform interpolation on the given source String.
  /// Returns null if the source is null.
  String? replace(String? source, {int offset = 0, int? length}) {
    if (source == null) {
      return null;
    }
    int bufLen = length ?? source.length;
    StrBuilder buf = StrBuilder(value: source);
    if (_substitute(buf, offset, bufLen) > 0) {
      return buf.toString();
    }
    if (length != null) {
      return source.substring(offset, length);
    } else {
      return source;
    }
  }

  int _substitute(StrBuilder buf, int offset, int length,
      {List? priorVariables}) {
    bool top = (priorVariables == null);
    bool altered = false;
    int lengthChange = 0;
    int bufEnd = offset + length;
    int pos = offset;

    while (pos < bufEnd) {
      int startMatchLen = prefixMatcher.isMatch(buf.toString(), pos,
          bufferStart: offset, bufferEnd: bufEnd);
      if (startMatchLen == 0) {
        pos++;
      } else {
        if (pos > offset && buf.charAt(pos - 1) == escapeChar) {
          buf.deleteCharAt(pos - 1);
          lengthChange--;
          altered = true;
          bufEnd--;
        } else {
          int startPos = pos;
          pos += startMatchLen;
          int endMatchLen = 0;
          int nestedVarCount = 0;
          while (pos < bufEnd) {
            if (enableSubstitutionInVariables &&
                (endMatchLen = prefixMatcher.isMatch(buf.toString(), pos,
                        bufferStart: offset, bufferEnd: bufEnd)) !=
                    0) {
              // found a nested variable start
              nestedVarCount++;
              pos += endMatchLen;
              continue;
            }
            endMatchLen = suffixMatcher.isMatch(buf.toString(), pos,
                bufferStart: offset, bufferEnd: bufEnd);
            if (endMatchLen == 0) {
              pos++;
            } else {
              if (nestedVarCount == 0) {
                String varName = buf.subString(
                    startPos + startMatchLen, pos - startPos - startMatchLen);
                if (enableSubstitutionInVariables) {
                  StrBuilder bufName = StrBuilder(value: varName);
                  _substitute(bufName, 0, bufName.length());
                  varName = bufName.toString();
                }
                pos += endMatchLen;
                int endPos = pos;

                // on the first call initialize priorVariables
                priorVariables ??= [];
                // handle cyclic substitution
                _checkCyclicSubstitution(varName, priorVariables);
                priorVariables.add(varName);

                // resolve the variable
                String? varValue =
                    _resolveVariable(varName, buf, startPos, endPos);
                if (varValue != null) {
                  // recursive replace
                  int varLen = varValue.length;
                  buf.replace(startPos, endPos, varValue);
                  altered = true;
                  int change = _substitute(buf, startPos, varLen,
                      priorVariables: priorVariables);
                  change = change + (varLen - (endPos - startPos));
                  pos += change;
                  bufEnd += change;
                  lengthChange += change;
                }

                // remove variable from the cyclic stack
                priorVariables.removeLast();
                break;
              } else {
                nestedVarCount--;
                pos += endMatchLen;
              }
            }
          }
        }
      }
    }

    if (top) {
      return (altered ? 1 : 0);
    }
    return lengthChange;
  }

  void _checkCyclicSubstitution(String varName, List priorVariables) {
    if (priorVariables.contains(varName) == false) {
      return;
    }
    throw ArgumentError('Cyclic reference in variable substitution.', varName);
  }

  String? _resolveVariable(
      String variableName, StrBuilder buf, int startPos, int endPos) {
    return variableResolver.lookup(variableName);
  }
}