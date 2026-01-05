import 'package:fakestorefake/graphql/dio_service.dart';
import 'package:fakestorefake/graphql/graphql_mutuations.dart';

import '../data_state.dart' show DataError, DataSuccess, Result;

abstract class LoginInterface {
  Future<Result> login(String email, String password);
}

class LoginRepo implements LoginInterface {
  LoginRepo(this._graphqlDioService);
  final GraphqlDioService _graphqlDioService;
  @override
  Future<Result> login(String email, String password) async {
    final loginMap = {"email": email, "password": password};
    final response = await _graphqlDioService.execute(() {
      return _graphqlDioService.mutate(
        GraphqlMutuations.login(),
        variables: loginMap,
      );
    });
    switch (response) {
      case DataSuccess():
        return Result.success(
          response.data,
          message: "Just checking success from login",
        );
      case DataError():
      default:
        return Result.failure(response.error);
    }
  }
}
