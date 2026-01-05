// import 'package:fakestorefake/repository/data_state.dart';
// import 'package:fakestorefake/repository/loginRepository/login_repo.dart';

// class LoginService {
//   LoginService(this._loginRepo);
//   final LoginInterface _loginRepo;

//   Future<Result<DataState>> login(Map<String, dynamic> loginMap) async {
//     final response = await _loginRepo.login(loginMap);
//     switch (response) {
//       case DataSuccess():
//         return Result.success(response.data);
//       case DataError():
//       default:
//         return Result.failure(response.error);
//     }
//   }
// }
