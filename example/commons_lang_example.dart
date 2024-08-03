import 'package:commons_lang/commons_lang.dart';

void main() {
  print(BoolUtils.fromString('y')); // true
  print(BoolUtils.fromString('t')); // true
  print(BoolUtils.fromString('Y')); // true
  print(BoolUtils.fromString('T')); // true
  print('');
  print(BoolUtils.fromString('n')); // false
  print(BoolUtils.fromString('N')); // false
  print(BoolUtils.fromString('f')); // false
  print(BoolUtils.fromString('F')); // false
  print('');
  print(BoolUtils.fromString('on')); // true
  print(BoolUtils.fromString('ON')); // true
  print(BoolUtils.fromString('On')); // true
  print('');
  print(BoolUtils.fromString('no')); // false
  print(BoolUtils.fromString('NO')); // false
  print(BoolUtils.fromString('No')); // false
  print('');
  print(BoolUtils.fromString('yes')); // true
  print(BoolUtils.fromString('YES')); // true
  print(BoolUtils.fromString('Yes')); // true
  print('');
  print(BoolUtils.fromString('Off')); // false
  print(BoolUtils.fromString('OFF')); // false
  print(BoolUtils.fromString('Off')); // false
  print('');
  print(BoolUtils.fromString('true')); // true
  print(BoolUtils.fromString('TRUE')); // true
  print(BoolUtils.fromString('True')); // true
  print('');
  print(BoolUtils.fromString('false')); // false
  print(BoolUtils.fromString('FALSE')); // false
  print(BoolUtils.fromString('False')); // false
}
