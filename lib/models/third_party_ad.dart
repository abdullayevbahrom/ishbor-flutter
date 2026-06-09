import 'package:equatable/equatable.dart';

class ThirdPartyAd extends Equatable {
  final String id;
  final String? title;
  final String? url;
  final String? imageUrl;

  const ThirdPartyAd({
    required this.id,
    this.title,
    this.url,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, url, imageUrl];

  factory ThirdPartyAd.fromMap(Map<String, dynamic> map) {
    return ThirdPartyAd(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString(),
      url: map['url']?.toString(),
      imageUrl: map['image_url']?.toString() ?? map['image']?.toString(),
    );
  }
}
