# Commons Lang

Commons Lang provides a host of helper utilities for Dart / Flutter applications, most notably String manipulation methods and basic numerical methods.

Note that this project is still in its early stages and so may not yet provide complete/full functionality. We will be building up functionality over the next few months through numerous small iterative releases.

## Table of Contents
- [Commons Lang](#commons-lang)
  - [Table of Contents](#table-of-contents)
  - [About The Project](#about-the-project)
    - [Features](#features)
  - [Getting Started](#getting-started)
    - [Installation](#installation)
    - [Import Package](#import-package)
  - [Usage](#usage)
  - [Roadmap](#roadmap)
  - [Contributing](#contributing)
  - [License](#license)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)
  - [Limitation of Liability](#limitation-of-liability)

## About The Project

### Features
- Extremely powerful and flexible String interpolation.
- Utility methods for working with Strings.
- Utility method for working with bool.


## Getting Started

Add the package as a dependency.

### Installation
Add the package to your dependencies.

```
pub add commons_lang
```

### Import Package

Import the library in your code.

```Dart
import 'package:commons_lang/commons_lang.dart';
```

## Usage

See the [User Guide](doc/user-guide.md) for detailed information.

### StrSubstitutor (String Interpolation)

The StrSubstitutor provides extremely powerful and flexible interpolation for advanced use cases. It supports nested variables, recursive lookup and escaping variables.

Consider the following example:
```Dart
Map map = {
  "animal": "\${critter}",
  "target": "\${pet}",
  "pet": "\${petCharacteristic} dog",
  "petCharacteristic": "lazy",
  "critter": "\${critterSpeed} \${critterColor} \${critterType}",
  "critterSpeed": "quick",
  "critterColor": "brown",
  "critterType": "fox",
};
StrSubstitutor sub = StrSubstitutor.fromMap(map);

print(sub.replace('The \${animal} jumps over the \${target}.'));
```
The output from the above will be
```
The quick brown fox jumps over the lazy dog.
```

Now consider this variable that is also escaped (the default escape character is $).
```Dart
print(sub.replace('The \$\${\${animal}} jumps over the \${target}.'));
```

The output from the above will be
```
The \${quick brown fox} jumps over the lazy dog.
```

This demonstrates the true power and flexibility of the interpolation provided here. For full details see the [User Guide](doc/user-guide.md). 

## Roadmap

See the [open issues](https://github.com/Limeslice-Software-Foundation/commons-lang/issues) for a full list of proposed features (and known issues).


## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## License

Distributed under the MIT License. See `LICENSE` for more information.


## Contact

Limeslice Software Foundation [https://limeslice.org](https://limeslice.org)


## Acknowledgments

We would like to thank the authors of the Apache Commons Lang package which has formed the basis of this package.


## Limitation of Liability

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.