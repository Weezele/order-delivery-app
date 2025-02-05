// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:delivery_app/data/api_client.dart' as _i38;
import 'package:delivery_app/data/product_repository.dart' as _i865;
import 'package:delivery_app/injection/injection_module.dart' as _i573;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i38.ApiClient>(() => registerModule.apiClient);
    gh.lazySingleton<_i865.ProductRepository>(
        () => _i865.ProductRepository(gh<_i38.ApiClient>()));
    return this;
  }
}

class _$RegisterModule extends _i573.RegisterModule {}
