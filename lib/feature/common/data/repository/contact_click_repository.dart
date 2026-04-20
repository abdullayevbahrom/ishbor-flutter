import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../domain/repository/contact_click_repository.dart';
import '../datasource/contact_click_datasource.dart';
import '../models/contact_click_params.dart';

class ContactClickRepositoryImpl extends ContactClickRepository {
  final ContactClickDatasource _clickDatasource;

  ContactClickRepositoryImpl(this._clickDatasource);

  @override
  Future<Either<Failure, void>> addContactClick({required ContactClickParams contactClickParams}) async{
    final response = await _clickDatasource.addContactClick(
      contactClickParams: contactClickParams,
    );

    return response.fold(
          (l) {
        return Left(Failure(message: l.message));
      },
          (r) {
        return Right(r);
      },
    );
  }


}
