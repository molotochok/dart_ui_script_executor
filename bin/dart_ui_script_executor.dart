import 'dart:io';
import 'package:process_run/shell.dart';

const String testName = "Executing target script via widget test";
const String targetScriptName = "target";

String testCode() {
  return 
'''
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import './$targetScriptName.dart' as $targetScriptName;

class _MyHttpOverrides extends HttpOverrides {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // This is needed to prevent mocking of http requests.
  HttpOverrides.global = _MyHttpOverrides();

  testWidgets('$testName', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await $targetScriptName.main();
    });
  });
}
''';
}

Future main(args) async {
  final dir = await Directory.systemTemp.createTemp("dart_ui_script_executor");

  try {
    final targetScriptPath = "${dir.path}/$targetScriptName.dart";
    print("Copying target script to temp file: $targetScriptPath");
    await File(args[0]).copy(targetScriptPath);

    print("Creating a test that will execute the script.");
    final testFile = File('${dir.path}/test.dart');
    await testFile.writeAsString(testCode());

    print("Running the test.");
    await Shell().run('flutter test ${testFile.path}');
  } catch (e) {
    print("An error occured while executing the script.");
    print(e.toString());
  } finally {
    await dir.delete(recursive: true);
  }
}