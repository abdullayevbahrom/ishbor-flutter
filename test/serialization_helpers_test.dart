import 'package:flutter_test/flutter_test.dart';
import 'package:top_jobs/core/network/api_response.dart';
import 'package:top_jobs/core/network/snake_case_mapper.dart';
import 'package:top_jobs/feature/common/data/models/feedback_model.dart';
import 'package:top_jobs/feature/profile/data/model/ask_question_model.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/feedback.dart';
import 'package:top_jobs/models/image.dart';
import 'package:top_jobs/models/localized_text.dart';

void main() {
  test('snake case mapper normalizes nested payloads', () {
    final normalized = SnakeCaseMapper.normalizeBody({
      'userId': 1,
      'nestedValue': {'createdAt': '2026-06-08'},
      'itemsList': [
        {'fullName': 'John Doe'},
      ],
    });

    expect(normalized['user_id'], 1);
    expect(normalized['nested_value']['created_at'], '2026-06-08');
    expect(normalized['items_list'][0]['full_name'], 'John Doe');
  });

  test('api data response unwraps data envelope', () {
    final response = ApiDataResponse.fromJson({
      'data': {'access_token': 'token', 'refresh_token': 'refresh'},
    }, (json) => json as Map<String, dynamic>);

    expect(response.data, isA<Map<String, dynamic>>());
    expect(response.data?['access_token'], 'token');
  });

  test('api list response accepts camel and snake case pagination keys', () {
    final response = ApiListResponse.fromJson({
      'items': [
        {'id': 1},
        {'id': 2},
      ],
      'totalCount': 2,
      'currentPageNumber': 3,
      'numItemsPerPage': 20,
    }, (json) => json as Map<String, dynamic>);

    expect(response.items, hasLength(2));
    expect(response.totalCount, 2);
    expect(response.currentPageNumber, 3);
    expect(response.numItemsPerPage, 20);
  });

  test('localized text resolves locale fallbacks', () {
    final text = LocalizedText.fromJson({'uz': 'Salom', 'ru': 'Privet'});

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
      'avatar': {'id': 7, 'url': 'https://cdn.example.com/avatar.png'},
      'title': {'uz': 'Sarlavha'},
    });

    expect(image.urls['original'], 'https://cdn.example.com/image.png');
    expect(customer.id, '123');
    expect(customer.fullName, 'Jane Doe');
    expect(
      customer.avatar?.urls['original'],
      'https://cdn.example.com/avatar.png',
    );
    expect(customer.title?.resolve('uz'), 'Sarlavha');
  });

  test('feedback request serializes receiver contract fields', () {
    final request = FeedbackRequestModel(
      receiverType: 'user',
      receiverId: '019e88b7-b706-7caa-bb84-dd2f0ebec756',
      like: true,
      message: 'Great service',
    );

    expect(request.toJson(), {
      'receiver_type': 'user',
      'receiver_id': '019e88b7-b706-7caa-bb84-dd2f0ebec756',
      'like': true,
      'message': 'Great service',
    });
  });

  test('feedback model parses dto payload without nested users', () {
    final feedback = FeedbackModel.fromMap({
      'id': '019e88b7-b706-7caa-bb84-dd2f0ebec123',
      'receiver_type': 'user',
      'receiver_id': '019e88b7-b706-7caa-bb84-dd2f0ebec756',
      'sender_id': '019e88b7-b706-7caa-bb84-dd2f0ebec111',
      'like': true,
      'dislike': false,
      'message': 'Great service',
      'status': 'published',
      'meta_data': null,
      'created_at': '2026-06-04T10:00:00+05:00',
    });

    expect(feedback.receiverType, 'user');
    expect(feedback.receiverId, '019e88b7-b706-7caa-bb84-dd2f0ebec756');
    expect(feedback.senderId, '019e88b7-b706-7caa-bb84-dd2f0ebec111');
    expect(feedback.message, 'Great service');
    expect(feedback.createdAt, isNotNull);
  });

  test('message request serializes ad contract fields', () {
    final request = SendMessageRequest(
      receiverId: '019e88b7-b706-7caa-bb84-dd2f0ebec222',
      adType: 'task',
      adId: '019e88b7-b706-7caa-bb84-dd2f0ebec999',
      body: 'Hello',
      messageId: '019e88b7-b706-7caa-bb84-dd2f0ebec777',
    );

    expect(request.toJson(), {
      'receiver_id': '019e88b7-b706-7caa-bb84-dd2f0ebec222',
      'ad_type': 'task',
      'ad_id': '019e88b7-b706-7caa-bb84-dd2f0ebec999',
      'body': 'Hello',
      'message_id': '019e88b7-b706-7caa-bb84-dd2f0ebec777',
    });
  });
}
