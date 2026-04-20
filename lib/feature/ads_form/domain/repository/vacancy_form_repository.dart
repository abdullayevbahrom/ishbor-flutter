import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../models/vacancy.dart';
import '../../data/models/request/vacancy_params.dart';
import '../../data/models/response/chatgpt_response.dart';

abstract class VacancyFormRepository{
  Future<Either<Failure, NewChatGptResponse>> generateVacancyBody({
    required String prompt,
  });

  Future<Either<Failure, String>> generateVacancyDesc({required String prompt});


  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyParams vacancyParams,
  });

  Stream<Either<Failure, String>> generateVacancyDescription({
    required String prompt,
  });


}