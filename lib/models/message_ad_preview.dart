import 'package:equatable/equatable.dart';

class MessageAdPreview extends Equatable {
  final String id;
  final String type;
  final String? titleUz;
  final String? titleRu;
  final String? imageUrl;
  final double? price;
  final double? salaryMin;
  final String? salaryCurrency;

  const MessageAdPreview({
    required this.id,
    required this.type,
    this.titleUz,
    this.titleRu,
    this.imageUrl,
    this.price,
    this.salaryMin,
    this.salaryCurrency,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    titleUz,
    titleRu,
    imageUrl,
    price,
    salaryMin,
    salaryCurrency,
  ];

  factory MessageAdPreview.fromMap(Map<String, dynamic> data) {
    final title = data['title'];
    return MessageAdPreview(
      id: data['id']?.toString() ?? '',
      type: data['type']?.toString() ?? '',
      titleUz: title is Map ? title['uz']?.toString() : null,
      titleRu: title is Map ? title['ru']?.toString() : null,
      imageUrl: data['image']?.toString(),
      price: (data['price'] as num?)?.toDouble(),
      salaryMin: (data['salary_min'] as num?)?.toDouble(),
      salaryCurrency: data['salary_currency']?.toString(),
    );
  }
}
