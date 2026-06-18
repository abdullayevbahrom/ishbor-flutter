import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/app_state.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/vacancy_form_page.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/w_generate_vacancy.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/task_view_cubit/task_view_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/service_view_page/service_view_page.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/task_view_page/task_view_page.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/vacancy_view_page/vacancy_view_page.dart';
import 'package:top_jobs/feature/auth/data/models/auth_success.dart';
import 'package:top_jobs/feature/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:top_jobs/feature/auth/presentation/pages/register_page/register_page.dart';
import 'package:top_jobs/feature/auth/presentation/pages/restore_password_page/restore_password_page.dart';
import 'package:top_jobs/feature/common/presentation/pages/map_filter_page/map_filter_page.dart';
import 'package:top_jobs/feature/common/presentation/pages/new_version_page/new_version_page.dart';
import 'package:top_jobs/feature/common/presentation/pages/notification_details/notifications_detail.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/main_page.dart';
import 'package:top_jobs/feature/map/presentation/pages/map_view_page/map_page.dart';
import 'package:top_jobs/feature/map/presentation/pages/map_view_page/widget/w_expanded_view.dart';
import 'package:top_jobs/feature/map/presentation/pages/yandex_map_page/yandex_map_page.dart';
import 'package:top_jobs/feature/map/presentation/pages/yandex_map_view/yandex_map_view_page.dart';
import 'package:top_jobs/feature/onboarding/presentation/pages/splash_page/splash_page.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/others_profile_page.dart';
import 'package:top_jobs/feature/performers_view/presentation/pages/task_performers/task_performers_page.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/payment_cuubit/payment_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/edit_profile.dart';
import 'package:top_jobs/feature/profile/presentation/pages/favorites/favorites_page.dart';
import 'package:top_jobs/feature/profile/presentation/pages/info/profile_info/profile_info.dart';
import 'package:top_jobs/feature/profile/presentation/pages/payment_page/payment_page.dart';
import 'package:top_jobs/feature/profile/presentation/pages/services/profile_services.dart';
import 'package:top_jobs/feature/profile/presentation/pages/tasks/profile_tasks.dart';
import 'package:top_jobs/feature/profile/presentation/pages/vacancies/profile_vacancies.dart';
import 'package:top_jobs/feature/services/presentation/pages/create_service_page/create_service_page.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/feature/tasks/presentation/pages/create_task_page/create_task_page.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/create_vacancy_page/create_vacancy_page.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/filter_form/filter_form.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/filter_form/widget/w_categories_page.dart';
import '../../feature/ads_view/presentation/cubits/vacancy_view_cubit/vacancy_view_cubit.dart';
import '../../feature/messages/presentation/pages/chat/chat_page.dart';
import '../../feature/services/data/models/service.dart' show ServiceModel;
import '../../injection_container.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../../models/vacancy.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

String? _tryParseId(GoRouterState state) {
  final rawId = state.uri.queryParameters['id'];
  return rawId;
}

DateTime? _tryParseExpiresAt(Uri uri) {
  final rawValue = uri.queryParameters['expires_at'];
  if (rawValue != null) {
    final parsed = DateTime.tryParse(rawValue);
    if (parsed != null) {
      return parsed;
    }
    final formattedValue = rawValue.replaceAll(' ', 'T');
    final parsed2 = DateTime.tryParse(formattedValue);
    if (parsed2 != null) {
      return parsed2;
    }
  }

  final expiresInRaw = uri.queryParameters['expires_in'];
  if (expiresInRaw != null) {
    final seconds = int.tryParse(expiresInRaw);
    if (seconds != null) {
      return DateTime.now().add(Duration(seconds: seconds));
    }
  }

  return DateTime.now().add(const Duration(days: 30));
}

class AppRoutes {
  final GoRouter router = GoRouter(
    initialLocation: _getInitialRoute(),
    // initialLocation: Routes.vacancyForm,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) {
          return fadeTransitionPage(child: SplashPage());
        },
      ),
      GoRoute(
        path: '/splash/:payload',
        pageBuilder: (context, state) {
          final String? encodedData = state.pathParameters['payload'];
          Map<String, dynamic>? deepLinkData;

          if (encodedData != null) {
            try {
              deepLinkData = jsonDecode(encodedData);
            } catch (e) {
              deepLinkData = null;
            }
          }

          return fadeTransitionPage(child: SplashPage(payload: deepLinkData));
        },
      ),
      GoRoute(
        path: Routes.main,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: MainPage(payload: state.extra as Map<String, dynamic>?),
            ),
      ),
      GoRoute(
        path: '/main/:payload',
        pageBuilder: (context, state) {
          final String? encodedData = state.pathParameters['payload'];
          Map<String, dynamic>? deepLinkData;

          if (encodedData != null) {
            try {
              deepLinkData = jsonDecode(encodedData);
            } catch (e) {
              deepLinkData = null;
            }
          }
          return CupertinoPage(child: MainPage(payload: deepLinkData));
        },
      ),
      GoRoute(
        path: Routes.profileInfo,
        pageBuilder: (context, state) => CupertinoPage(child: ProfileInfo()),
      ),
      GoRoute(
        path: Routes.profileVacancies,
        routes: [],
        pageBuilder:
            (context, state) =>
                CupertinoPage(canPop: true, child: ProfileVacancies()),
      ),
      GoRoute(
        path: Routes.profileServices,
        pageBuilder:
            (context, state) => CupertinoPage(child: ProfileServices()),
      ),
      GoRoute(
        path: Routes.profileTasks,
        pageBuilder: (context, state) => CupertinoPage(child: ProfileTasks()),
      ),

      GoRoute(
        path: Routes.chat,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: ChatPage(messageId: state.extra?.toString() ?? ''),
            ),
      ),
      GoRoute(
        path: Routes.filterForm,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: FilterForm(
                queryParams: state.extra as QueryParams? ?? QueryParams.empty(),
              ),
            ),
      ),
      GoRoute(
        path: Routes.map,
        pageBuilder:
            (context, state) =>
                CupertinoPage(child: MapPage(type: state.extra as String)),
      ),

      GoRoute(
        path: Routes.createVacancy,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: CreateVacancyPage(vacancy: state.extra as Vacancy?),
            ),
      ),
      GoRoute(
        path: Routes.createService,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: CreateServicePage(service: state.extra as ServiceModel?),
            ),
      ),
      GoRoute(
        path: Routes.register,
        pageBuilder: (context, state) => CupertinoPage(child: RegisterPage()),
      ),
      GoRoute(
        path: Routes.createTask,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: CreateTaskPage(task: state.extra as TaskModel?),
            ),
      ),
      GoRoute(
        path: Routes.othersProfile,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: OthersProfilePage(user: state.extra as User),
            ),
      ),
      GoRoute(
        path: Routes.yandexMap,
        pageBuilder: (context, state) => CupertinoPage(child: YandexMapPage()),
      ),
      GoRoute(
        path: Routes.restorePassword,
        pageBuilder:
            (context, state) => CupertinoPage(child: RestorePassword()),
      ),
      GoRoute(
        path: Routes.myFavorites,
        pageBuilder: (context, state) => CupertinoPage(child: FavoritesPage()),
      ),
      GoRoute(
        path: Routes.yandexMapView,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: YandexMapViewPage(
                locations: state.extra as Map<String, dynamic>,
              ),
            ),
      ),
      GoRoute(
        path: Routes.mapFilter,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: MapFilterPage(type: state.extra as String),
            ),
      ),
      GoRoute(
        path: Routes.expandedView,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: WExpandedViewPage(
                list: state.extra as Map<String, dynamic>,
              ),
            ),
      ),
      GoRoute(
        path: Routes.notificationDetails,
        pageBuilder:
            (context, state) => CupertinoPage(
              child: NotificationsDetail(
                params: state.extra as Map<String, dynamic>,
              ),
            ),
      ),
      GoRoute(
        path: Routes.vacancy_view,
        pageBuilder: (context, state) {
          final vacancyId = _tryParseId(state);
          if (vacancyId == null) {
            return fadeTransitionPage(child: SplashPage());
          }
          return CupertinoPage(
            child: BlocProvider(
              create: (context) => sl<VacancyViewCubit>()..fetchData(vacancyId),
              child: WVacancyViewPage(vacancyId: vacancyId),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.service_view,
        pageBuilder: (context, state) {
          final serviceId = _tryParseId(state);
          if (serviceId == null) {
            return fadeTransitionPage(child: SplashPage());
          }
          return CupertinoPage(child: WServiceViewPage(serviceId: serviceId));
        },
      ),
      GoRoute(
        path: Routes.task_view,
        pageBuilder: (context, state) {
          final taskId = _tryParseId(state);
          if (taskId == null) {
            return fadeTransitionPage(child: SplashPage());
          }
          return CupertinoPage(
            child: BlocProvider(
              create: (context) => sl<TaskViewCubit>()..fetchData(taskId),
              child: WTaskViewPage(taskId: taskId),
            ),
          );
        },
      ),

      GoRoute(
        path: Routes.vacancyForm,
        pageBuilder: (context, state) {
          return CupertinoPage(
            canPop: true,
            allowSnapshotting: true,
            child: VacancyFormPage(
              params: state.extra as Map<String, dynamic>?,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.payment,
        pageBuilder: (context, state) {
          final transactionId = state.uri.queryParameters['transaction_id'];
          return CupertinoPage(
            child: BlocProvider(
              create: (context) => sl<PaymentCubit>(),
              child: PaymentPage(transactionId: transactionId),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.task_performers,
        pageBuilder: (context, state) {
          return CupertinoPage(
            child: TaskPerformersPage(taskModel: state.extra as TaskModel),
          );
        },
      ),
      GoRoute(
        path: Routes.edit_profile,
        pageBuilder: (context, state) {
          return CupertinoPage(child: EditProfile());
        },
      ),
      GoRoute(
        path: Routes.wGenerateVacancy,
        pageBuilder: (context, state) {
          return CupertinoPage(child: WGenerateVacancy());
        },
      ),
      GoRoute(
        path: Routes.newVersion,
        pageBuilder: (context, state) {
          return CupertinoPage(
            child: NewVersionPage(storeLink: state.extra as String),
          );
        },
      ),
      GoRoute(
        path: Routes.categoriesPage,
        pageBuilder: (context, state) {
          return CupertinoPage(
            child: WCategoriesPage(categories: state.extra as List<String>),
          );
        },
      ),
    ],
    redirect: (context, state) {
      final uri = state.uri;

      final url = uri.toString();

      if (url.contains("/vacancy-view") && uri.queryParameters['id'] != null) {
        if (AppState.isActive) {
          return "/vacancy-view?id=${uri.queryParameters['id']}";
        } else {
          return "/splash/${jsonEncode({"vacancyId": uri.queryParameters['id']})}";
        }
      }
      if (url.contains("/service-view") && uri.queryParameters['id'] != null) {
        if (AppState.isActive) {
          return "/service-view?id=${uri.queryParameters['id']}";
        } else {
          return "/splash/${jsonEncode({"serviceId": uri.queryParameters['id']})}";
        }
      }
      if (url.contains("/task-view") && uri.queryParameters['id'] != null) {
        if (AppState.isActive) {
          return "/task-view?id=${uri.queryParameters['id']}";
        } else {
          return "/splash/${jsonEncode({"taskId": uri.queryParameters['id']})}";
        }
      }
      if (url.contains("/main") && uri.queryParameters['token'] != null) {
        final expiresAt = _tryParseExpiresAt(uri);
        if (AppState.isActive) {
          if (navigatorKey.currentContext?.canPop() ?? false) {
            navigatorKey.currentContext?.pop();
          }
          navigatorKey.currentContext?.read<AuthCubit>().logInWithTelegram(
            AuthSuccess(
              accessToken: uri.queryParameters['token'],
              refreshToken: uri.queryParameters['refresh_token'],
              expiresIn: null,
              expiresAt: expiresAt,
            ),
          );
          return "/main/${jsonEncode({'token': uri.queryParameters['token'], 'expires_at': uri.queryParameters['expires_at']})}";
        } else {
          return "/splash/${jsonEncode({'token': uri.queryParameters['token'], 'expires_at': uri.queryParameters['expires_at']})}";
        }
      }
      if (url.contains("/main") && uri.queryParameters['access_token'] != null) {
        final expiresAt = _tryParseExpiresAt(uri);
        final expiresInStr = uri.queryParameters['expires_in'];
        final expiresIn = expiresInStr != null ? int.tryParse(expiresInStr) : null;
        if (AppState.isActive) {
          if (navigatorKey.currentContext?.canPop() ?? false) {
            navigatorKey.currentContext?.pop();
          }
          navigatorKey.currentContext?.read<AuthCubit>().logInWithTelegram(
            AuthSuccess(
              accessToken: uri.queryParameters['access_token'],
              refreshToken: uri.queryParameters['refresh_token'],
              expiresIn: expiresIn,
              expiresAt: expiresAt,
            ),
          );
          return "/main/${jsonEncode({
            'access_token': uri.queryParameters['access_token'],
            'refresh_token': uri.queryParameters['refresh_token'],
            'expires_in': uri.queryParameters['expires_in'],
            'expires_at': expiresAt?.toIso8601String(),
          })}";
        } else {
          return "/splash/${jsonEncode({
            'access_token': uri.queryParameters['access_token'],
            'refresh_token': uri.queryParameters['refresh_token'],
            'expires_in': uri.queryParameters['expires_in'],
            'expires_at': expiresAt?.toIso8601String(),
          })}";
        }
      }
      if (url.contains("/payment") &&
          uri.queryParameters['transaction_id'] != null) {
        return "/payment?transaction_id=${uri.queryParameters['transaction_id']}";
      }
      return null;
    },
  );
}

String _getInitialRoute() {
  if (AppState.isActive) {
    return Routes.main;
  }

  if (initialLink != null && initialLink!.isNotEmpty) {
    final uri = Uri.parse(initialLink!);
    if (initialLink!.contains("/vacancy-view") &&
        uri.queryParameters['id'] != null) {
      return "/splash/${jsonEncode({"vacancyId": uri.queryParameters['id']})}";
    }

    if (initialLink!.contains("/service-view") &&
        uri.queryParameters['id'] != null) {
      return "/splash/${jsonEncode({"serviceId": uri.queryParameters['id']})}";
    }

    if (initialLink!.contains("/task-view") &&
        uri.queryParameters['id'] != null) {
      return "/splash/${jsonEncode({"taskId": uri.queryParameters['id']})}";
    }

    if (initialLink!.contains("/main") &&
        uri.queryParameters['token'] != null &&
        _tryParseExpiresAt(uri) != null) {
      return "/splash/${jsonEncode({'token': uri.queryParameters['token'], 'expires_at': uri.queryParameters['expires_at']})}";
    }

    if (initialLink!.contains("/main") &&
        uri.queryParameters['access_token'] != null) {
      final expiresAt = _tryParseExpiresAt(uri);
      return "/splash/${jsonEncode({
        'access_token': uri.queryParameters['access_token'],
        'refresh_token': uri.queryParameters['refresh_token'],
        'expires_in': uri.queryParameters['expires_in'],
        'expires_at': expiresAt?.toIso8601String(),
      })}";
    }
  }

  return '/splash'; // Default route
}

CustomTransitionPage<T> fadeTransitionPage<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: TimeDelayCons.durationMill400,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

Page<void> cupertinoPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: true,

        child: child,
      );
    },
  );
}

CustomTransitionPage<T> buildCupertinoPage<T>(Widget child) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: true,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
