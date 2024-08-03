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

/// Utility methods for working with bools.
class BoolUtils {
  /// Converts a String to a Boolean.
  /// <code>'true'</code>, <code>'on'</code> or <code>'yes'</code>
  /// (case insensitive) will return <code>true</code>.
  /// <code>'false'</code>, <code>'off'</code> or <code>'no'</code>
  /// (case insensitive) will return <code>false</code>.
  /// Any other value return false.
  /// BoolUtils.fromString(null)        = false
  /// BoolUtils.fromString("true")      = true
  /// BoolUtils.fromString("false")     = false
  /// BoolUtils.fromString("on")        = true
  /// BoolUtils.fromString("YES")       = true
  /// BoolUtils.fromString("off")       = false
  /// BoolUtils.fromString("oFf")       = false
  /// BoolUtils.fromString("blue")      = false
  static bool fromString(String? value) {
    if (value == null) {
      return false;
    }
    if (value == 'true') {
      return true;
    }
    if (value == 'false') {
      return false;
    }

    String lower = value.toLowerCase();
    switch (lower.length) {
      case 1:
        {
          if ((lower == 'y' || lower == 't')) {
            return true;
          }
          break;
        }
      case 2:
        {
          if (lower == 'on') {
            return true;
          }
          break;
        }
      case 3:
        {
          if (lower == 'yes') {
            return true;
          }
          break;
        }
      case 4:
        {
          if (lower == 'true') {
            return true;
          }
          break;
        }
      case 5:
        {
          if (lower == 'false') {
            return false;
          }
          break;
        }
    }

    return false;
  }

  /// Any non 0 value returns true, 0 returns false
  static bool fromInt(int? value) {
    if (value == null) {
      return false;
    }
    return value != 0;
  }
}
