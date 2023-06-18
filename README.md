This is a package that allows you to run Dart scripts that have Flutter-specific dependencies such as "dart:ui".

## Features
If you tried to run a script which has a dependency on "dart:ui" you may encountered a lot of errors. It happens because of Flutter-specific dependencies. 

This package aims to solve this issue. It uses a hacky solution to execute the target script as a part of a widget unit test.

## Getting started
1. To start using the package install it by running:
```
flutter pub add dart_ui_script_executor
```
2. Create a Dart script that you want to run with the entrypoint function `main`.

## Usage
To run your script you need to execute the wrapper called `dart_ui_script_executor` and pass as an input the file path of your script together with the arguments.

Command template:
```
 dart run dart_ui_script_executor <path to your script> [<list of arguments>]
```
or:
```
 flutter packages pub run dart_ui_script_executor <path-to-your-script> [<list of arguments>]
```

Examples:
```
flutter packages pub run dart_ui_script_executor lib/scripts/script_with_0_args.dart
```

```
flutter packages pub run dart_ui_script_executor lib/scripts/script_with_2_args.dart arg1 arg2
```
