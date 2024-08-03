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

/// A matcher class that can be queried to determine if a String portion
/// matches.
abstract class StrMatcher {
  /// Matches no characters.
  static final StrMatcher _noneMatcher = NoMatcher();

  /// Returns the number of matching characters, zero for no match.
  /// This method is called to check for a match.
  /// The parameter <code>pos</code> represents the current position to be
  /// checked in the string <code>buffer</code> .
  int isMatch(String buffer, int pos, {int bufferStart = 0, int? bufferEnd});

  /// Factory that creates a matcher from the given String.
  static StrMatcher stringMatcher(String? str) {
    if (str == null || str.isEmpty) {
      return _noneMatcher;
    }
    return StringMatcher(string: str);
  }
}

/// Class used to define a set of characters for matching purposes.
class StringMatcher extends StrMatcher {

  /// The string to match.
  final String string;

  /// Create a new StringMatcher with the given String.
  StringMatcher({required this.string});

  /// Returns whether or not the given text matches the stored string.
  /// 0 is returned if no match is found, otherwise the length of the
  /// stored string is returned.
  /// Searching is done at the given pos.
  @override
  int isMatch(String buffer, int pos, {int bufferStart = 0, int? bufferEnd}) {
    int length = string.length;
    int buffEnd = bufferEnd ?? buffer.length-1;
    if (pos + length > buffEnd) {
      return 0;
    }
    
    return buffer.startsWith(string, pos) ? length : 0;
  }

}

/// Class used to match no characters.
class NoMatcher extends StrMatcher {

  /// Always returns 0.
  @override
  int isMatch(String buffer, int pos, {int bufferStart = 0, int? bufferEnd}) {
    return 0;
  }

}
