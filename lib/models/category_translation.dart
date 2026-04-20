import 'package:equatable/equatable.dart';

class CategoryTranslation extends Equatable {
  final int id;
  final String locale;
  final String name;

  CategoryTranslation({
      required this.id,
      required this.locale,
      required this.name
  });

  @override
  List<Object> get props => [id, locale, name];

  CategoryTranslation.clone(CategoryTranslation ct2) :
      this.id = ct2.id, this.locale = ct2.locale, this.name = ct2.name;

  static CategoryTranslation fromJson(dynamic json) {
    return CategoryTranslation(
      id: json['id'],
      locale: json['locale'],
      name: json['name']
    );
  }
}
