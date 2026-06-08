import 'package:flutter_test/flutter_test.dart';
import 'package:top_jobs/core/network/api_response.dart';
import 'package:top_jobs/core/network/snake_case_mapper.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/image.dart';
import 'package:top_jobs/models/localized_text.dart';

void main() {
  test('snake case mapper normalizes nested payloads', () {
    final normalized = SnakeCaseMapper.normalizeBody({
      'userId': 1,
      'nestedValue': {
        'createdAt': '2026-06-08',
      },
      'itemsList': [
        {'fullName': 'John Doe'},
      ],
    });

    expect(normalized['user_id'], 1);
    expect(normalized['nested_value']['created_at'], '2026-06-08');
    expect(normalized['items_list'][0]['full_name'], 'John Doe');
  });

  test('api data response unwraps data envelope', () {
    final response = ApiDataResponse.fromJson(
      {
        'data': {
          'access_token': 'token',
          'refresh_token': 'refresh',
        },
      },
      (json) => json as Map<String, dynamic>,
    );

    expect(response.data, isA<Map<String, dynamic>>());
    expect(response.data?['access_token'], 'token');
  });

  test('api list response accepts camel and snake case pagination keys', () {
    final response = ApiListResponse.fromJson(
      {
        'items': [
          {'id': 1},
          {'id': 2},
        ],
        'totalCount': 2,
        'currentPageNumber': 3,
        'numItemsPerPage': 20,
      },
      (json) => json as Map<String, dynamic>,
    );

    expect(response.items, hasLength(2));
    expect(response.totalCount, 2);
    expect(response.currentPageNumber, 3);
    expect(response.numItemsPerPage, 20);
  });

  test('localized text resolves locale fallbacks', () {
    final text = LocalizedText.fromJson({
      'uz': 'Salom',
      'ru': 'Privet',
    });

    expect(text.resolve('uz'), 'Salom');
    expect(text.resolve('ru'), 'Privet');
    expect(text.resolve('en'), 'Salom');
  });

  test('api image and customer normalize dynamic payloads', () {
    final image = AppImage.fromJson('https://cdn.example.com/image.png');
    final customer = AdCustomer.fromJson({
      'id': 123,
      'full_name': 'Jane Doe',
      'phone_number': '+998901112233',
      'avatar': {
        'id': 7,
        'url': 'https://cdn.example.com/avatar.png',
      },
      'title': {
        'uz': 'Sarlavha',
      },
    });

    expect(image.urls['original'], 'https://cdn.example.com/image.png');
    expect(customer.id, '123');
    expect(customer.fullName, 'Jane Doe');
    expect(customer.avatar?.urls['original'], 'https://cdn.example.com/avatar.png');
    expect(customer.title?.resolve('uz'), 'Sarlavha');
  });
}
