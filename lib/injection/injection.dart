import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart'; // Needed for the extension

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
