import 'package:build_config/build_config.dart';
import 'package:drift_dev/src/analyzer/options.dart';

Future<DriftOptions> fromRootDir(String path) async {
  final options = await BuildConfig.fromPackageDir(path);
  return readOptionsFromConfig(options);
}

DriftOptions readOptionsFromConfig(BuildConfig config) {
  final options = config.buildTargets.values
      .map((t) {
        return t.builders['moor_generator:moor_generator']?.options ??
            t.builders['drift_dev:drift_dev']?.options;
      })
      .whereType<Map>()
      .map((json) => DriftOptions.fromJson(json));

  final iterator = options.iterator;
  return iterator.moveNext() ? iterator.current : const DriftOptions.defaults();
}
