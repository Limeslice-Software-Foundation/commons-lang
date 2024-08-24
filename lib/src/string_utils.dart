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
import 'text/str_builder.dart';

/// Provides String utility methods.
class StringUtils {
  /// The default escape character which is a <code>\</code>.
  static const String defaultListEscChar = '\\';

  /// Split a string on the specified delimiter.
  /// The method differs from the built in String split method by allowing
  /// escaping of the delimiter character.
  /// Consider this String: <code>test.separator\=in.key = foo</code>, in this
  /// case only two Strings will be in the List returned, namely:
  /// <code>['test.separator=in.key','foo']</code>
  /// It is important to note that the escape char can itself be escaped,
  /// consider the following code:
  /// <code>List<String> list = StringUtils.split("C:\\Temp\\\\,xyz", ',');</code>
  /// This will result in a List containing two Strings namely:
  /// <code>['C:\Temp\','xyz']</code>
  static List<String> split(String str, String delimiter,
      [bool trim = true, listEscChar = defaultListEscChar]) {
    if (str.isEmpty) {
      return [];
    }
    if (delimiter.isEmpty) {
      return [str];
    }

    String delim = '';
    StrBuilder builder = StrBuilder(value: delimiter);
    for(int i = 0; i<delimiter.length; i++) {
      if(str.contains(builder.charAt(i))) {
        delim = builder.charAt(i);
        break;
      }
    }
    

    List<String> list = [];
    StringBuffer token = StringBuffer();
    StrBuilder s = StrBuilder(value: str);
    int begin = 0;
    bool inEscape = false;

    while (begin < s.length()) {
      String c = s.charAt(begin);
      if (inEscape) {
        // last character was the escape marker
        // can current character be escaped?
        if (c != delim && c != listEscChar) {
          // no, also add escape character
          token.write(listEscChar);
        }
        token.write(c);
        inEscape = false;
      } else {
        if (c == delim) {
          // found a list delimiter
          String t = token.toString();
          if (trim) {
            t = t.trim();
          }
          list.add(t);
          token = StringBuffer();
        } else if (c == listEscChar) {
          // eventually escape next character
          inEscape = true;
        } else {
          token.write(c);
        }
      }
      begin++;
    }
    if (inEscape) {
      token.write(listEscChar);
    }
    // Add last token
    String t = token.toString();
    if (trim) {
      t = t.trim();
    }
    list.add(t);
    return list;
  }
}
