[![Release](https://img.shields.io/badge/Version-^0.0.25-success.svg?style=for-the-badge)](https://shields.io/)
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
  dart_fcm: ^0.0.25
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Lastly:

Import it like so:

```dart
import 'package:dart_fcm/src/fcm.dart';

```

## Usage

Lets take a look at how to hook-up your application to use `dart_fcm`.

```dart
import 'package:dart_fcm/dart_fcm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const YourAppName());
}

/// [YourAppName] marks as the entry point to your application.
class YourAppName extends StatefulWidget {
  const YourAppName({Key? key}) : super(key: key);

  @override
  _YourAppNameState createState() => _YourAppNameState();
}

class _YourAppNameState extends State<YourAppName> {
  bool hasFinishedLaunching = false;

  @override
  void didChangeDependencies() {
    if (!hasFinishedLaunching) {
      /// [configure] is responsible for correctly setting
      /// up local notifications ( and asking for permission if needed) and wiring-up
      /// firebase messaging [onMessage] callback to show fcm messages
      SILFCM().configure(context: context);
      hasFinishedLaunching = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          // Your application
          ),
    );
  }
}

```

With the above snippet, we have successfully hooked up our application to use `dart_fcm`.
You have now bootstraped local notifications to your application for Android, iOS and macOS settings.
This will create notification channels and prompt the user for notification permissions. 
Your application has now enabled foreground notifications so that they can be visible while the app is in the foreground

Provided [here](https://github.com/savannahghi/dart_fcm/tree/main/example) is a more detailed snippet, on how to use the package.

## Dart & Flutter Version

- Dart 2: >= 2.12
- Flutter: >=2.0.0

## Developing & Contributing

First off, thanks for taking the time to contribute!

Be sure to check out detailed instructions on how to contribute to this project [here](https://github.com/savannahghi/dart_fcm/blob/main/CONTRIBUTING.md) and go through out [Code of Conduct](https://github.com/savannahghi/dart_fcm/blob/main/CONTRIBUTING.md).

GPG Signing: 
As a contributor, you need to sign your commits. For more details check [here](https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/signing-commits)

## License

This library is distributed under the MIT license found in the [LICENSE](https://github.com/savannahghi/dart_fcm/blob/main/LICENSE) file.