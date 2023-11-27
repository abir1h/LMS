import '../mapper/auth_response_mapper.dart';
import '../data_sources/remote/auth_data_source.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp({required this.authRemoteDataSource});

  @override
  Future<AuthResponseEntity> userLogin(String pdsID, String password) async{
    return (await authRemoteDataSource.userLoginAction(pdsID, password)).toAuthResponseEntity;
  }
}
