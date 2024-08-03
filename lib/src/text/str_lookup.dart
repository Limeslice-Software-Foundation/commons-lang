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

/// Lookup a String key to a String value.
/// This class represents the simplest form of a string to string mapping.
/// It has a benefit over a map in that it can create the result on
/// demand based on the key.
abstract class StrLookup {
  /// Lookup that always returns null.
  static final StrLookup noneLookup = MapStrLookup(map: null);

  /// Returns a lookup which looks up values using a map.
  /// If the map is null, then null will be returned from every lookup.
  /// The map result object is converted to a string using toString().
  static StrLookup mapLookup(Map? map) {
    return MapStrLookup(map: map);
  }

  /// Looks up a String key to a String value.
  /// The internal implementation may use any mechanism to return the value.
  /// The simplest implementation is to use a Map. However, virtually any
  /// implementation is possible.
  String? lookup(String? key);
}

/// Lookup implementation that uses a Map.
class MapStrLookup extends StrLookup {

  /// The map to use for lookups.
  final Map? map;

  /// Create a new instance with the given map.
  MapStrLookup({required this.map});

  @override
  String? lookup(String? key) {
    if (map == null) {
      return null;
    }
    if (key == null) {
      return null;
    }
    Object? obj = map![key];
    if (obj == null) {
      return null;
    }
    return obj.toString();
  }
}
