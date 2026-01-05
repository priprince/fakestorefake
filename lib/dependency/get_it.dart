import 'package:dio/dio.dart' show Dio;
import 'package:fakestorefake/graphql/dio_client.dart' show DioClient;
import 'package:fakestorefake/graphql/dio_service.dart' show GraphqlDioService;
import 'package:fakestorefake/repository/loginRepository/login_repo.dart';
import 'package:get_it/get_it.dart' show GetIt;

final getIt = GetIt.instance;

const String url = 'https://api.escuelajs.co/graphql';
Future<void> setupDI() async {
  getIt.registerLazySingleton<Dio>(() {
    return DioClient.create(baseUrl: url, getToken: () async => null);
  });

  getIt.registerLazySingleton<GraphqlDioService>(
    () => GraphqlDioService(getIt<Dio>()),
  );

  getIt.registerFactory<LoginRepo>(() => LoginRepo(getIt<GraphqlDioService>()));
}
