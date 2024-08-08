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

/// Provides some additional methods for Strings
class StrBuilder {
  /// Internal String value.
  String value;

  /// Create a new StrBuilder with the given value.
  StrBuilder({this.value = ''});

  /// Return the specific character as a String at the given position.
  /// Throws ArgumentError if the pos is out of range.
  String charAt(int pos) {
    if (pos < 0 || pos >= value.length) {
      throw ArgumentError('', 'pos');
    }
    return value.substring(pos, pos + 1);
  }

  /// Set the character at the given position to the given value.
  /// Throws ArgumentError if the pos is out of range.
  void setCharAt(int pos, String char) {
    if (pos < 0 || pos >= value.length) {
      throw ArgumentError('', 'pos');
    }
    value = value.replaceRange(pos, pos + 1, char);
  }

  /// Remove the character at the given position.
  /// Throws ArgumentError if the pos is out of range.
  void deleteCharAt(int pos) {
    if (pos < 0 || pos >= value.length) {
      throw ArgumentError('', 'pos');
    }
    value = value.replaceRange(pos, pos + 1, '');
  }

  /// Replace the text from the given start position to the given end position
  /// with the given replacement String.
  void replace(int startPos, int endPos, String replacement) {
    value = value.replaceRange(startPos, endPos, replacement);
  }

  /// Return the length of the String value.
  int length() {
    return value.length;
  }

  /// Clear the String value.
  void clear() {
    value = '';
  }

  /// Create a substring from the given offset with the given length.
  String subString(int offset, int count) {
    return value.substring(offset, offset + count);
  }

  /// Return the value as a String.
  @override
  String toString() {
    return value;
  }
}
