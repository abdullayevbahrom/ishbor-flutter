import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:top_jobs/core/exceptions/exception_listener.dart';
import 'package:top_jobs/core/helpers/debouncer.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/services/web_socket_client.dart';
import 'package:top_jobs/feature/ads_form/data/datasource/vacancy_form_datasource.dart';
import 'package:top_jobs/feature/ads_form/data/repository/vacancy_form_repository_impl.dart';
import 'package:top_jobs/feature/ads_form/presentation/cubits/vacancy_form_cubit/vacancy_form_cubit.dart';
import 'package:top_jobs/feature/ads_view/data/datasource/ads_contact_datasource.dart';
import 'package:top_jobs/feature/ads_view/data/datasource/ads_view_datasource.dart';
import 'package:top_jobs/feature/ads_view/data/datasource/report_datasource.dart';
import 'package:top_jobs/feature/ads_view/data/repository/ads_contact_repository_impl.dart';
import 'package:top_jobs/feature/ads_view/data/repository/ads_view_repository_impl.dart';
import 'package:top_jobs/feature/ads_view/data/repository/reports_repository_impl.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_contact_repository.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_view_repository.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/reports_repository.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/ads_contact_cubit/ads_contact_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/service_view_cubit/service_view_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/task_view_cubit/task_view_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/vacancy_view_cubit/vacancy_view_cubit.dart';
import 'package:top_jobs/feature/auth/data/datasource/auth_data_source.dart';
import 'package:top_jobs/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:top_jobs/feature/auth/domain/repository/auth_repository.dart';
import 'package:top_jobs/feature/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:top_jobs/feature/common/data/datasource/category_datasource.dart';
import 'package:top_jobs/feature/common/data/datasource/cities_datasource.dart';
import 'package:top_jobs/feature/common/data/datasource/contact_click_datasource.dart';
import 'package:top_jobs/feature/common/data/datasource/feedback_datasource.dart';
import 'package:top_jobs/feature/common/data/datasource/notification_datasource.dart';
import 'package:top_jobs/feature/common/data/datasource/user_data_source.dart';
import 'package:top_jobs/feature/common/data/repository/category_repository_impl.dart';
import 'package:top_jobs/feature/common/data/repository/cities_repository_impl.dart';
import 'package:top_jobs/feature/common/data/repository/contact_click_repository.dart';
import 'package:top_jobs/feature/common/data/repository/feedback_repository_impl.dart';
import 'package:top_jobs/feature/common/data/repository/notification_repository_impl.dart';
import 'package:top_jobs/feature/common/data/repository/user_repository_impl.dart';
import 'package:top_jobs/feature/common/domain/repository/category_repository.dart';
import 'package:top_jobs/feature/common/domain/repository/cities_repository.dart';
import 'package:top_jobs/feature/common/domain/repository/contact_click_repository.dart';
import 'package:top_jobs/feature/common/domain/repository/feedback_repository.dart';
import 'package:top_jobs/feature/common/domain/repository/notification_repository.dart';
import 'package:top_jobs/feature/common/domain/repository/user_repository.dart';
import 'package:top_jobs/feature/common/presentation/cubits/ask_question_cubit/ask_question_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/cities_cubit/cities_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/feedback_cubit/feedback_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/location_filter_cubit/location_filter_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/notification_details/notification_details_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/main/presentation/cubit/main_cubit/main_cubit.dart';
import 'package:top_jobs/feature/map/data/datasource/location_info_datasource.dart';
import 'package:top_jobs/feature/map/data/datasource/yandex_datasource.dart';
import 'package:top_jobs/feature/map/data/repository/location_info_repository_impl.dart';
import 'package:top_jobs/feature/map/data/repository/yandex_repository_impl.dart';
import 'package:top_jobs/feature/map/domain/repository/location_info.dart';
import 'package:top_jobs/feature/map/domain/repository/yandex_repository.dart';
import 'package:top_jobs/feature/map/presentation/cubits/expanded_view_cubit/expanded_view_cubit.dart';
import 'package:top_jobs/feature/map/presentation/cubits/location_cubit/location_info_cubit.dart';
import 'package:top_jobs/feature/map/presentation/cubits/map_view_cubit/map_view_cubit.dart';
import 'package:top_jobs/feature/map/presentation/cubits/suggestions_cubit/suggestions_cubit.dart';
import 'package:top_jobs/feature/map/presentation/cubits/yandex_map_cubit/yandex_map_cubit.dart';
import 'package:top_jobs/feature/messages/presentation/cubits/message_cubit/message_cubit.dart';
import 'package:top_jobs/feature/others_profile/presentation/cubits/other_profile_cubit/other_profile_cubit.dart';
import 'package:top_jobs/feature/performers_view/data/datasource/task_request_datasource.dart';
import 'package:top_jobs/feature/performers_view/data/repository/task_requests_repository_impl.dart';
import 'package:top_jobs/feature/performers_view/domain/repository/task_requests_repository.dart';
import 'package:top_jobs/feature/performers_view/presentation/cubits/task_requests_cubit/task_requests_cubit.dart';
import 'package:top_jobs/feature/profile/data/datasource/favorites_datasource.dart';
import 'package:top_jobs/feature/messages/data/datasource/messages_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/my_services_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/my_tasks_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/my_vacancies_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/payment_datasource.dart';
import 'package:top_jobs/feature/profile/data/repository/favorites_repository_impl.dart';
import 'package:top_jobs/feature/messages/data/repository/messages_repository_impl.dart';
import 'package:top_jobs/feature/profile/data/repository/my_services_repository_impl.dart';
import 'package:top_jobs/feature/profile/data/repository/my_tasks_repository_impl.dart';
import 'package:top_jobs/feature/profile/data/repository/my_vacancies_repository_impl.dart';
import 'package:top_jobs/feature/profile/data/repository/payment_repository_impl.dart';
import 'package:top_jobs/feature/profile/domain/repository/favorites_repository.dart';
import 'package:top_jobs/feature/messages/domain/repository/messages_repository.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_service_repository.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_task_repository.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_vacancies_repository.dart';
import 'package:top_jobs/feature/profile/domain/repository/payment_repository.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_services_cubit/my_services_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/my_tasks_cubit/my_tasks_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/payment_cuubit/payment_cubit.dart';
import 'package:top_jobs/feature/services/data/datasource/service_datasource.dart';
import 'package:top_jobs/feature/services/data/repository/service_repository_impl.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/services/presentation/cubits/service_cubit/service_cubit.dart';
import 'package:top_jobs/feature/tasks/data/datasource/task_datasource.dart';
import 'package:top_jobs/feature/tasks/data/repository/task_repository_impl.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/tasks/presentation/cubits/task_cubit/task_cubit.dart';
import 'package:top_jobs/feature/vacancies/data/data_source/vacancy_datasource.dart';
import 'package:top_jobs/feature/vacancies/data/repository/vacancy_repository_impl.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:top_jobs/feature/vacancies/presentation/cubits/create_vacancy_cubit/create_vacancy_cubit.dart';
import 'package:top_jobs/feature/vacancies/presentation/cubits/vacancy_cubit/vacancy_cubit.dart';

import 'core/network/dio_client.dart';
import 'core/network/network_status_manager.dart';
import 'core/services/storage_service.dart';
import 'feature/ads_form/domain/repository/vacancy_form_repository.dart';
import 'feature/messages/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'feature/profile/presentation/cubits/my_vacancies_cubit/my_vacancies_cubit.dart';
import 'feature/services/presentation/cubits/create_service/create_service_cubit.dart';
import 'feature/tasks/presentation/cubits/create_task_cubit/create_task_cubit.dart';

final sl = GetIt.instance;

void init() {
  initCubits();
  initRepositories();
  initDataSources();

  sl.registerLazySingleton(() => WebsocketClient());

  ///Exception listener
  sl.registerLazySingleton(
        () =>
        ExceptionListener(

          isDebug: kDebugMode,
          chatIds: ["1990405913", "3095460", "211490240", "1147507400"],
          botToken: "7423169472:AAFqBFAgc7mQpR4AHFgwBrOWXkCoWi6sANk",
        ),
  );

  ///Routes
  sl.registerLazySingleton(() => AppRoutes());

  ///Dio
  sl.registerLazySingleton<Dio>(
        () => DioClient(storageService: sl()).provideDio(),
  );

  ///Storage
  sl.registerSingleton<StorageService>(StorageService.instance);

  ///Network status manager
  sl.registerLazySingleton<NetworkStatusManager>(() => NetworkStatusManager());

  ///Debounce
  sl.registerLazySingleton<Debounce>(() => Debounce());
}

void initCubits() {
  sl.registerFactory(() => CreateVacancyCubit(sl(), sl()));
  sl.registerFactory(() => CreateServiceCubit(sl()));
  sl.registerFactory(() => CreateTaskCubit(sl()));
  sl.registerFactory(() => VacancyCubit(sl()));
  sl.registerFactory(() => LocationInfoCubit(sl()));
  sl.registerFactory<CategoryCubit>(() => CategoryCubit(sl()));
  sl.registerFactory(() => ServiceCubit(sl()));
  sl.registerFactory(() => TaskCubit(sl()));
  sl.registerFactory(() => NotificationCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => UserCubit(sl(), sl()));
  sl.registerFactory(() => MainCubit());
  sl.registerFactory(() => FeedbackCubit(sl()));
  sl.registerFactory(() => CitiesCubit(sl()));
  sl.registerFactory(() => MyVacanciesCubit(sl(), sl()));
  sl.registerFactory(() => MyServicesCubit(sl(), sl()));
  sl.registerFactory(() => MyTasksCubit(sl(), sl()));
  sl.registerFactory(() => NotificationDetailsCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => LocationFilterCubit(sl(), sl(), sl()));
  sl.registerFactory(() => LocaleCubit());
  sl.registerFactory(() => ChatCubit(sl()));
  sl.registerFactory(() => AskQuestionCubit(sl(), sl(), sl()));
  sl.registerFactory(() => OtherProfileCubit(sl(), sl(), sl()));
  sl.registerFactory(() => YandexMapCubit(sl()));
  sl.registerFactory<MapViewCubit>(() => MapViewCubit(sl(), sl(), sl()));
  sl.registerFactory<SuggestionsCubit>(() => SuggestionsCubit(sl()));
  sl.registerFactory<FavoritesCubit>(
        () => FavoritesCubit(sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(() => ExpandedViewCubit(sl(), sl(), sl()));
  sl.registerFactory(() => VacancyViewCubit(sl(), sl()));
  sl.registerFactory(() => ServiceViewCubit(sl(), sl()));
  sl.registerFactory(() => TaskViewCubit(sl(), sl(), sl()));
  sl.registerFactory(() => PaymentCubit(sl()));
  sl.registerFactory(() => TaskRequestsCubit(sl()));
  sl.registerFactory<MessageCubit>(() => MessageCubit(sl()));
  sl.registerFactory(() => VacancyFormCubit(sl(), sl(), sl()));
  sl.registerFactory<AdsContactCubit>(() => AdsContactCubit(sl(), sl()));
}

void initRepositories() {
  sl.registerLazySingleton<VacancyRepository>(
        () => VacancyRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LocationInfoRepository>(
        () => LocationInfoRepositoryImpl(locationInfoDataSource: sl()),
  );

  sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ServiceRepository>(
        () => ServiceRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationsRepository>(
        () => NotificationsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  sl.registerLazySingleton<FeedBackRepository>(
        () => FeedBackRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CitiesRepository>(() => CitiesRepositoryImpl(sl()));
  sl.registerLazySingleton<MessagesRepository>(
        () => MessagesRepositoryImpl(sl()),
  );
  sl.registerFactory<YandexRepository>(() => YandexRepositoryImpl(sl()));
  sl.registerLazySingleton<ContactClickRepository>(
        () => ContactClickRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<FavoritesRepository>(
        () => FavoritesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AdsViewRepository>(
        () => AdsViewRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<TaskRequestsRepository>(
        () => TaskRequestsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<VacancyFormRepository>(
        () => VacancyFormRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<MyVacanciesRepository>(
        () => MyVacanciesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<MyServiceRepository>(
        () => MyServicesRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<MyTasksRepository>(
        () => MyTasksRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ReportsRepository>(
        () => ReportsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AdsContactRepository>(
        () => AdsContactRepositoryImpl(sl()),
  );
}

void initDataSources() {
  sl.registerLazySingleton<VacancyDataSource>(
        () => VacancyDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<LocationInfoDataSource>(
        () => LocationInfoDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<CategoryDataSource>(
        () => CategoryDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<ServiceDataSource>(
        () => ServiceDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<TaskDataSource>(() => TaskDataSourceImpl(sl()));
  sl.registerLazySingleton<NotificationsDataSource>(
        () => NotificationsDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthDatasource>(() => AuthDataSourceImpl(sl()));

  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(sl()));
  sl.registerLazySingleton<FeedBackDataSource>(
        () => FeedBackDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<CitiesDataSource>(() => CitiesDataSourceImpl(sl()));
  sl.registerLazySingleton<MessagesDataSource>(
        () => MessagesDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<YandexDataSource>(() => YandexDataSourceImpl(sl()));
  sl.registerLazySingleton<ContactClickDatasource>(
        () => ContactClickDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FavoritesDataSource>(
        () => FavoritesDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AdsViewDataSource>(
        () => AdsViewDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PaymentDataSource>(
        () => PaymentDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<TaskRequestDataSource>(
        () => TaskRequestDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<VacancyFormDataSource>(
        () => VacancyFormDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MyVacanciesDataSource>(
        () => MyVacanciesDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MyServicesDataSource>(
        () => MyServicesDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MyTasksDataSource>(
        () => MyTasksDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ReportsDataSource>(
        () => ReportsDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AdsContactDataSource>(
        () => AdsContactDataSourceImpl(sl()),
  );
}
