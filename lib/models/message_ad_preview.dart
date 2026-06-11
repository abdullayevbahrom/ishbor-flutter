import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/localized_text.dart';

class MessageAdPreview extends Equatable {
  final String id;
  final String type;
  final LocalizedText title;
  final String? imageUrl;
  final double? price;
  final double? salaryMin;
  final String? salaryCurrency;

  const MessageAdPreview({
    required this.id,
    required this.type,
    required this.title,
    this.imageUrl,
    this.price,
    this.salaryMin,
    this.salaryCurrency,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    imageUrl,
    price,
    salaryMin,
    salaryCurrency,
  ];

  factory MessageAdPreview.fromMap(Map<String, dynamic> data) {
    return MessageAdPreview(
      id: data['id']?.toString() ?? '',
      type: data['type']?.toString() ?? '',
      title: LocalizedText.fromJson(data['title']),
      imageUrl: data['image']?.toString(),
      price: (data['price'] as num?)?.toDouble(),
      salaryMin: (data['salary_min'] as num?)?.toDouble(),
      salaryCurrency: data['salary_currency']?.toString(),
    );
  }
}
