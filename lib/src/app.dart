import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipacking_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ipacking_app/src/shared/blocs_app/authentication.dart';
import 'package:ipacking_app/src/shared/blocs_app/loading_cubit/loading_cubit.dart';
import 'package:ipacking_app/src/shared/config/routes/route_names.dart';
import 'package:ipacking_app/src/shared/config/routes/routes.dart';
import 'package:ipacking_app/src/shared/config/themes/theme_app.dart';
import 'package:ipacking_app/src/shared/utils/screen_utils.dart';
import 'package:ipacking_app/src/shared/widgets/loading.dart';

import '../injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<BlocProvider> _getProviders() => [
    BlocProvider<LoadingCubit>(
      create: (_) => getIt<LoadingCubit>(),
    ),
    BlocProvider<AuthenticationBloc>(
        create: (_) => getIt<AuthenticationBloc>()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: _getProviders(),
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              navigatorKey: Routes.instance.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: "KZTekAds",
              onGenerateRoute: Routes.generateRoute,
              initialRoute: RouteNames.splashScreen,
              theme: getAppTheme(),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeListResolutionCallback: (locales, supportedLocales) {
                String currentLocale =
                    WidgetsBinding.instance.window.locale.languageCode;
                return const Locale.fromSubtags(languageCode: 'en');
              },
              supportedLocales: S.delegate.supportedLocales,
              builder: (context, widget) {
                ScreenUtils.init(context);
                return LoadingApp(
                    child: GestureDetector(
                      child: widget,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ));
              },
            );
          },
        ));
  }
}