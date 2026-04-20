import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/user.dart';

abstract class AdRequest extends Equatable {

  final int id;
  final User performer;
  final String status;
  final String? message;
  final DateTime createdAt;

  AdRequest({
    required this.id,
    required this.performer,
    required this.status,
    this.message,
    required this.createdAt
  });
}
