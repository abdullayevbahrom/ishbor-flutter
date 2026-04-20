import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../data/models/contact_click_params.dart';

abstract class ContactClickRepository {
  Future<Either<Failure, void>> addContactClick({
    required ContactClickParams contactClickParams,
  });
}

