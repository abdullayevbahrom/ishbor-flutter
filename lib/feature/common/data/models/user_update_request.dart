import 'package:top_jobs/export.dart';

class UserProfileUpdateRequest {
  final String? firstName;
  final String? lastName;
  final String? birthDay;
  final String? email;
  final String? city;
  final String? gender;
  final String? aboutMe;
  final List<int>? categories;

  UserProfileUpdateRequest({
    this.firstName,
    this.lastName,
    this.birthDay,
    this.email,
    this.city,
    this.gender,
    this.aboutMe,
    this.categories,
  });

  Map<String, dynamic> toJson() {
    final parsedBirthDay =
        (birthDay ?? '').isNotEmpty
            ? DateTime.tryParse(birthDay!.replaceAll('/', '-'))
            : null;

    return {
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (parsedBirthDay != null)
        'birthDay': DateFormat(
          'yyyy/MM/dd',
        ).format(parsedBirthDay),
      if (email != null && (email ?? '').isNotEmpty) 'email': email,
      if (city != null && (city ?? '').isNotEmpty) 'city': city ?? '',
      if (gender != null && (gender ?? '').isNotEmpty) 'gender': gender,
      if (aboutMe != null && (aboutMe ?? '').isNotEmpty) 'aboutMe': aboutMe,
      if (categories != null && (categories ?? []).isNotEmpty)
        'categories': categories,
    };
  }
}
