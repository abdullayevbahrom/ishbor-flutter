import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/core/constants/easy_locale.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/theme/app_theme.dart';
import 'package:top_jobs/feature/ads_form/presentation/cubits/vacancy_form_cubit/vacancy_form_cubit.dart';
import 'package:top_jobs/feature/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/ask_question_cubit/ask_question_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/cities_cubit/cities_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/main/presentation/cubit/main_cubit/main_cubit.dart';
import 'package:top_jobs/feature/messages/presentation/cubits/message_cubit/message_cubit.dart';
import 'package:top_jobs/injection_container.dart' as di;
import 'package:top_jobs/injection_container.dart';

import 'firebase_options.dart';

late AppLinks _appLinks;
String? initialLink;

Future<void> _setupAppLinks() async {
  _appLinks = AppLinks();

  try {
    initialLink = await _appLinks.getInitialLinkString();
  } catch (e) {
    log(e.toString());
  }
}

Future<void> main() async {
  runZonedGuarded(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      if (kDebugMode) {
        HttpOverrides.global = MyHttpOverrides();
      }
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      await Future.wait([
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        ScreenUtil.ensureScreenSize(),
        EasyLocalization.ensureInitialized(),
        Hive.openBox(AppLocaleKeys.appName),
      ]);
      di.init();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      await _setupAppLinks();
      FlutterNativeSplash.remove();

      runApp(
          EasyLocalization(
            saveLocale: true,
            fallbackLocale: EasyLocale.all.first,
            startLocale: EasyLocale.all.last,
            path: AppLocaleKeys.localePath,
            supportedLocales: EasyLocale.all,
            child: BlocProvider(
              create: (context) => sl<LocaleCubit>(),
              child: const MyApp(),
            ),
          )
      );
    },
    (error, stack) {
      Logger().w(
        "Error by runZoneGuard: ${error.toString()} ${stack.toString()}",
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 1001),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
        builder:
            (context) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<MainCubit>()),
                BlocProvider(
                  create: (context) => sl<CategoryCubit>()..fetchCategories(),
                ),
                BlocProvider(create: (context) => sl<NotificationCubit>()),
                BlocProvider(create: (context) => sl<AuthCubit>()),
                BlocProvider(create: (context) => sl<UserCubit>()),
                BlocProvider(create: (context) => sl<CitiesCubit>()),
                BlocProvider(create: (context) => sl<AskQuestionCubit>()),
                BlocProvider(create: (context) => sl<MessageCubit>()),
                BlocProvider(create: (context) => sl<VacancyFormCubit>()),
              ],
              child: BlocBuilder<LocaleCubit, LocaleState>(
                bloc: sl<LocaleCubit>()..changeLocale(context.locale, context),
                builder: (context, state) {
                  return ToastificationWrapper(
                    child: MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      title: "Ish Bor",
                      localizationsDelegates: context.localizationDelegates,
                      locale: state.locale,
                      supportedLocales: context.supportedLocales,
                      theme: AppTheme.lightTheme,
                      routerConfig: sl<AppRoutes>().router,
                    ),
                  );
                },
              ),
            ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    if (kDebugMode) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    }
    return client;
  }
}
