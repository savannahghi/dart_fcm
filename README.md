[![Release](https://img.shields.io/badge/Version-^0.0.20-success.svg?style=for-the-badge)](https://shields.io/)
[![Maintained](https://img.shields.io/badge/Maintained-Actively-informational.svg?style=for-the-badge)](https://shields.io/)

# dart_fcm

`dart_fcm` is an open source project &mdash; it's one among many other shared libraries that make up the wider ecosystem of software made and open sourced by `Savannah Informatics Limited`.

dart_fcm is a wrapper package for setting up and consuming cloud notifications from firebase

## Installation Instructions

Use this package as a library by depending on it

Run this command:

- With Flutter:

```dart
$ flutter pub add dart_fcm
```

This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):

```dart
dependencies:
  dart_fcm: ^0.0.20
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Lastly:

Import it like so:

```dart
import 'package:dart_fcm/src/fcm.dart';

```