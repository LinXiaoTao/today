import 'dart:async';

import 'package:build/build.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

Builder copyBuilder(BuilderOptions options) => CopyBuilder();

class CopyBuilder implements Builder {
  Future build(BuildStep buildStep) async {
    /// Each [buildStep] has a single input.
    var inputId = buildStep.inputId;

    /// Create a new target [AssetId] based on the old one.
    var copy = inputId.addExtension('.copy');
    var contents = await buildStep.readAsString(inputId);

    /// Write out the new asset.
    ///
    /// There is no need to `await` here, the system handles waiting on these
    /// files as necessary before advancing to the next phase.
    buildStep.writeAsString(copy, contents);
  }

  /// Configure output extensions. All possible inputs match the empty input
  /// extension. For each input 1 output is created with `extension` appended to
  /// the path.
  Map<String, List<String>> get buildExtensions => {
        '.txt': ['.txt.copy'],
      };
}
