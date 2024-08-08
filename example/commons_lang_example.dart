import 'package:commons_lang/commons_lang.dart';

void main() {
  Map map = {"animal": "quick brown fox", "target": "lazy dog"};
  StrSubstitutor sub = StrSubstitutor.fromMap(map);

  // The quick brown fox jumps over the lazy dog.
  print(sub.replace('The \${animal} jumps over the \${target}.'));

  // The ${person} jumps over the lazy dog.
  print(sub.replace('The \${person} jumps over the \${target}.'));

  // Use \$ as an escape character
  // The ${animal} jumps over the lazy dog.
  print(sub.replace('The \$\${animal} jumps over the \${target}.'));

  // Variable substitution still occurs in escaped variables
  // The ${quick brown fox} jumps over the lazy dog.
  print(sub.replace('The \$\${\${animal}} jumps over the \${target}.'));

  sub.setVariablePrefix('#[');
  sub.setVariableSuffix(']');
  sub.escapeChar = '@';

  // The quick brown fox jumps over the lazy dog.
  print(sub.replace('The #[animal] jumps over the #[target].'));

  // Use @ as an escape character
  // The #[animal] jumps over the lazy dog.
  print(sub.replace('The @#[animal] jumps over the #[target].'));
}
