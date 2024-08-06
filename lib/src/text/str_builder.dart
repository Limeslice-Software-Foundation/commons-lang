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

class StrBuilder {
  String value;

  StrBuilder({this.value = ''});

  String charAt(int pos) {
    if (pos < 0 || pos >= value.length) {
      throw ArgumentError('', 'pos');
    }
    return value.substring(pos, pos + 1);
  }

  void setCharAt(int pos, String char) {
    if (pos < 0 || pos >= value.length) {
      throw ArgumentError('', 'pos');
    }
    value = value.replaceRange(pos, pos + 1, char);
  }

  void deleteCharAt(int pos) {
    if (pos < 0 || pos >= value.length) {
      throw ArgumentError('', 'pos');
    }
    value = value.replaceRange(pos, pos + 1, '');
  }

  void replace(int startPos, int endPos, String replacement) {
    value = value.replaceRange(startPos, endPos, replacement);
  }

  int length() {
    return value.length;
  }

  void clear() {
    value = '';
  }

  String subString(int offset, int count) {
    return value.substring(offset, offset+count);
  }

  @override
  String toString() {
    return value;
  }
}
