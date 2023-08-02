import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../injection_container.dart';
import '../../../../shared/blocs_app/bloc/authentication_bloc.dart';
import '../../../../shared/blocs_app/loading_cubit/loading_cubit.dart';
import '../../../../shared/config/routes/route_names.dart';
import '../../../../shared/config/routes/routes.dart';
import '../../../../shared/constants/colors_constans.dart';
import '../../../../shared/constants/enums_constants.dart';
import '../../../../shared/constants/imgs_constants.dart';
import '../../../../shared/widgets/pop_scope_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      context
          .read<AuthenticationBloc>()
          .add(AuthenticationCheckStatusRequested());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        getIt<LoadingCubit>().hideLoading();
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            Routes.instance.navigateAndRemove(RouteNames.homeScreen,
                 routeStopName: RouteNames.splashScreen);
            break;
          case AuthenticationStatus.unauthenticated:
            Routes.instance.navigateAndRemove(RouteNames.loginScreen,
                routeStopName: RouteNames.splashScreen);
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return PopScopeScaffold(
              backgroundColor: AppColors.backgroundColorBase,
              body: Center(
                child: Container(
                  height: 100.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImg.imageLogo),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
