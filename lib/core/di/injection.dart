import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = AppCore.locator;

@InjectableInit()
void configureDependencies() => getIt.init();
