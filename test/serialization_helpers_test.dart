import 'package:flutter_test/flutter_test.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/network/api_response.dart';
import 'package:top_jobs/core/network/snake_case_mapper.dart';
import 'package:top_jobs/feature/common/data/models/cities_list.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/data/models/feedback_model.dart';
import 'package:top_jobs/feature/common/data/models/user_update_request.dart';
import 'package:top_jobs/feature/messages/data/models/paginated_chat_message.dart';
import 'package:top_jobs/feature/profile/data/model/ask_question_model.dart';
import 'package:top_jobs/feature/services/data/models/service_request_model.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/tasks/data/models/task_request_model.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/feedback.dart';
import 'package:top_jobs/models/file.dart';
import 'package:top_jobs/models/image.dart';
import 'package:top_jobs/models/localized_text.dart';
import 'package:top_jobs/models/message_record.dart';
import 'package:top_jobs/models/tag.dart';
import 'package:top_jobs/models/third_party_ad.dart';
import 'package:top_jobs/models/user.dart';

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

  test('multipart upload constants stay aligned with the vNext contract', () {
    expect(ServiceCreateRequest.uploadedImagesField, 'uploadedImages');
    expect(TaskRequestModel.uploadedImagesField, 'uploadedImages');
    expect(
      ApiConstants.uploadServiceImages('019e88b7-b706-7caa-bb84-dd2f0ebec201'),
      '/api/v1/services/019e88b7-b706-7caa-bb84-dd2f0ebec201/images',
    );
    expect(
      ApiConstants.uploadTaskImages('019e88b7-b706-7caa-bb84-dd2f0ebec202'),
      '/api/v1/tasks/019e88b7-b706-7caa-bb84-dd2f0ebec202/images',
    );
    expect(
      ApiConstants.deleteServiceImage('019e88b7-b706-7caa-bb84-dd2f0ebec201'),
      '/api/v1/services/019e88b7-b706-7caa-bb84-dd2f0ebec201/images',
    );
    expect(
      ApiConstants.deleteTaskImage('019e88b7-b706-7caa-bb84-dd2f0ebec202'),
      '/api/v1/tasks/019e88b7-b706-7caa-bb84-dd2f0ebec202/images',
    );
    expect(
      ApiConstants.deleteVacancyImage('019e88b7-b706-7caa-bb84-dd2f0ebec203'),
      '/api/v1/vacancies/019e88b7-b706-7caa-bb84-dd2f0ebec203/images',
    );
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

  test('cities list normalizes minimal payload and retains coordinates', () {
    final response = CitiesList.fromMap({
      'data': {
        'items': [
          {
            'id': 'city-1',
            'name': 'Toshkent',
            'coords': {'lat': 41.2995, 'lng': 69.2401},
          },
        ],
        'total_count': 1,
      },
    });

    expect(response.currentPageNumber, 1);
    expect(response.numItemsPerPage, 1);
    expect(response.totalCount, 1);
    expect(response.cities, hasLength(1));
    expect(response.cities.single.id, 'city-1');
    expect(response.cities.single.name, 'Toshkent');
    expect(response.cities.single.coords.lat, 41.2995);
    expect(response.cities.single.coords.lng, 69.2401);
  });

  test('tag and banner models normalize dynamic catalog payloads', () {
    final tag = TagModel.fromMap({
      'data': {
        'id': 'tag-1',
        'title': {'ru': 'Usta', 'uz': 'Usta'},
      },
    });
    final banner = ThirdPartyAd.fromMap({
      'id': 'banner-1',
      'title': {'ru': 'Aksiya', 'uz': 'Aksiya'},
      'url': 'https://example.com/banner',
      'image': {'original': 'https://cdn.example.com/banner.png'},
    });

    expect(tag.id, 'tag-1');
    expect(tag.name, 'Usta');
    expect(banner.id, 'banner-1');
    expect(banner.title, 'Aksiya');
    expect(banner.imageUrl, 'https://cdn.example.com/banner.png');
  });

  test('category list response normalizes minimal list payload', () {
    final response = CategoryListResponse.fromMap({
      'data': {
        'items': [
          {
            'id': '019e88b7-b706-7caa-bb84-dd2f0ebec901',
            'name': {'ru': 'Usta', 'uz': 'Usta'},
            'parent_id': null,
            'icon': 'https://cdn.example.com/category/icon.png',
            'icon_small': 'https://cdn.example.com/category/icon-small.png',
          },
        ],
        'total_count': 1,
      },
    });

    expect(response.currentPageNumber, 1);
    expect(response.numItemsPerPage, 1);
    expect(response.totalCount, 1);
    expect(response.items, hasLength(1));
    expect(response.items.single.translations[0].name, 'Usta');
    expect(response.items.single.translations[1].name, 'Usta');
    expect(
      response.items.single.iconUrls?['original'],
      'https://cdn.example.com/category/icon.png',
    );
    expect(
      response.items.single.iconSmallUrls?['original'],
      'https://cdn.example.com/category/icon-small.png',
    );
  });

  test('service list response normalizes minimal list payload', () {
    final response = PaginatedServiceResponse.fromMap({
      'data': {
        'items': [
          {
            'id': '019e88b7-b706-7caa-bb84-dd2f0ebec902',
            'status': 'published',
            'title': {'uz': 'Xizmat', 'ru': 'Xizmat'},
            'created_at': '2026-06-04T10:00:00+05:00',
            'customer': {
              'id': '019e88b7-b706-7caa-bb84-dd2f0ebec903',
              'phone_number': '998901112233',
            },
            'categories': [],
            'images': [],
            'price': 150000,
            'negotiable': false,
          },
        ],
        'total_count': 1,
      },
    });

    expect(response.currentPageNumber, 1);
    expect(response.numItemsPerPage, 1);
    expect(response.totalCount, 1);
    expect(response.items, hasLength(1));
    expect(response.items.single.id, '019e88b7-b706-7caa-bb84-dd2f0ebec902');
    expect(
      response.items.single.customer.id,
      '019e88b7-b706-7caa-bb84-dd2f0ebec903',
    );
  });

  test('task list response normalizes minimal list payload', () {
    final response = PaginatedTaskListResponse.fromJson({
      'data': {
        'items': [
          {
            'id': '019e88b7-b706-7caa-bb84-dd2f0ebec904',
            'status': 'published',
            'title': {'uz': 'Vazifa', 'ru': 'Vazifa'},
            'description': {'uz': 'Tavsif', 'ru': 'Tavsif'},
            'short_description': {'uz': 'Qisqa', 'ru': 'Qisqa'},
            'customer': {
              'id': '019e88b7-b706-7caa-bb84-dd2f0ebec905',
              'phone_number': '998901112244',
            },
            'lifted_up_at': '2026-06-04T10:00:00+05:00',
            'created_at': '2026-06-04T10:00:00+05:00',
            'updated_at': '2026-06-04T10:00:00+05:00',
            'categories': [],
            'addresses': [],
            'payment_methods': ['cash'],
            'images': [],
          },
        ],
        'total_count': 1,
      },
    });

    expect(response.currentPageNumber, 1);
    expect(response.numItemsPerPage, 1);
    expect(response.totalCount, 1);
    expect(response.items, hasLength(1));
    expect(response.items.single.id, '019e88b7-b706-7caa-bb84-dd2f0ebec904');
    expect(
      response.items.single.customer.id,
      '019e88b7-b706-7caa-bb84-dd2f0ebec905',
    );
  });

  test('file and user normalize verification doc string payloads', () {
    final file = File.fromJson('https://cdn.example.com/docs/verification.pdf');
    final user = User.fromMap({
      'id': '019e88b7-b706-7caa-bb84-dd2f0ebec756',
      'phone_number': '998901112233',
      'likes_count': 0,
      'dislikes_count': 0,
      'phone_verified': true,
      'verification_doc': 'https://cdn.example.com/docs/verification.pdf',
    });

    expect(file.url, 'https://cdn.example.com/docs/verification.pdf');
    expect(file.originalName, 'verification');
    expect(file.extension, 'pdf');
    expect(
      user.verificationDoc?.url,
      'https://cdn.example.com/docs/verification.pdf',
    );
    expect(user.verificationDoc?.originalName, 'verification');
    expect(user.verificationDoc?.extension, 'pdf');
  });

  test('user profile update request keeps category ids as strings', () {
    final request = UserProfileUpdateRequest(
      categories: ['019e88b7-b706-7caa-bb84-dd2f0ebec001'],
      city: 'Toshkent',
    );

    expect(request.toJson(), {
      'city': 'Toshkent',
      'categories': ['019e88b7-b706-7caa-bb84-dd2f0ebec001'],
    });
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

  test('message record parses dto payload without nested users', () {
    final record = MessageRecord.fromMap({
      'id': '019e88b7-b706-7caa-bb84-dd2f0ebec300',
      'message_id': '019e88b7-b706-7caa-bb84-dd2f0ebec301',
      'sender_id': '019e88b7-b706-7caa-bb84-dd2f0ebec302',
      'receiver_id': '019e88b7-b706-7caa-bb84-dd2f0ebec303',
      'read': false,
      'body': 'Hello',
      'file': 'https://cdn.example.com/chat/file.pdf',
      'created_at': '2026-06-04T10:00:00+05:00',
    });

    expect(record.id, '019e88b7-b706-7caa-bb84-dd2f0ebec300');
    expect(record.messageId, '019e88b7-b706-7caa-bb84-dd2f0ebec301');
    expect(record.sender.id, '019e88b7-b706-7caa-bb84-dd2f0ebec302');
    expect(record.receiver?.id, '019e88b7-b706-7caa-bb84-dd2f0ebec303');
    expect(record.file?.url, 'https://cdn.example.com/chat/file.pdf');
  });

  test('message list response unwraps data envelope and uuid ids', () {
    final response = PaginatedChatMessageResponse.fromJson({
      'data': {
        'items': [
          {
            'id': '019e88b7-b706-7caa-bb84-dd2f0ebec310',
            'sender_id': '019e88b7-b706-7caa-bb84-dd2f0ebec311',
            'receiver_id': '019e88b7-b706-7caa-bb84-dd2f0ebec312',
            'sender': {
              'id': '019e88b7-b706-7caa-bb84-dd2f0ebec311',
              'full_name': 'Sender User',
              'avatar': 'https://cdn.example.com/avatar.png',
            },
            'receiver': {
              'id': '019e88b7-b706-7caa-bb84-dd2f0ebec312',
              'full_name': 'Receiver User',
            },
            'ad_type': 'task',
            'ad_id': '019e88b7-b706-7caa-bb84-dd2f0ebec313',
            'ad_preview': {
              'id': '019e88b7-b706-7caa-bb84-dd2f0ebec313',
              'type': 'task',
              'title': {'uz': 'Task title', 'ru': 'Task title'},
              'image': 'https://cdn.example.com/task.png',
              'price': 150000,
            },
            'created_at': '2026-06-04T10:00:00+05:00',
          },
        ],
        'totalCount': 1,
        'currentPageNumber': 1,
        'numItemsPerPage': 10,
      },
    });

    expect(response.totalCount, 1);
    expect(response.items.single.id, '019e88b7-b706-7caa-bb84-dd2f0ebec310');
    expect(
      response.items.single.senderId,
      '019e88b7-b706-7caa-bb84-dd2f0ebec311',
    );
    expect(response.items.single.receiver?.fullName, 'Receiver User');
    expect(response.items.single.adPreview?.type, 'task');
    expect(
      response.items.single.adPreview?.imageUrl,
      'https://cdn.example.com/task.png',
    );
  });
}
