import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../shared/blocs_app/bloc/authentication_bloc.dart';
import '../../../../shared/component/app_button_super_small.dart';
import '../../../../shared/component/app_dialog.dart';
import '../../../../shared/component/input_text_field.dart';
import '../../../../shared/component/password_text_field.dart';
import '../../../../shared/constants/colors_constans.dart';
import '../../../../shared/constants/dimens_constants.dart';
import '../../../../shared/constants/enums_constants.dart';
import '../../../../shared/constants/imgs_constants.dart';
import '../../../../shared/constants/text_style_constants.dart';
import '../../../../shared/error/input_validate.dart';
import '../../../../shared/widgets/pop_scope_scaffold.dart';
import '../../domain/entities/login_dto.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => getIt<LoginBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailTextCtrl = TextEditingController();
  TextEditingController domainTextCtrl = TextEditingController();
  TextEditingController plateRecognizeCtrl = TextEditingController();
  TextEditingController passwordTextCtrl = TextEditingController();
  double btnWidth = 200;
  double btnHeight = 50;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _addListeners();
    super.initState();
  }

  _addListeners() {
    emailTextCtrl.addListener(() {
      setState(() {});
    });
    passwordTextCtrl.addListener(() {
      setState(() {});
    });
    domainTextCtrl.addListener(() {
      setState(() {});
    });
    plateRecognizeCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const screenPadding = SizedBox(
      height: AppDimensPadding.paddingItemHomeScreen,
    );
    const contentPadding = SizedBox(
      height: AppDimensPadding.contentPadding,
    );
    final titleLogin = Text(
      S.current.lbl_login_title,
      style: AppTextStyle.heading1Bold,
      textAlign: TextAlign.center,
    );
    final inputDomain = Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensPadding.contentPadding),
      child: CommonInputTextFormField(
          hint: S.current.lbl_domain,
          textInputAction: TextInputAction.next,
          onValidate: (value) {
            return InputValidate.validateEmpty(value);
          },
          controller: domainTextCtrl),
    );
    final inputPlateRecognize = Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensPadding.contentPadding),
      child: CommonInputTextFormField(
          hint: "Plate Domain",
          textInputAction: TextInputAction.next,
          onValidate: (value) {
            return InputValidate.validateEmpty(value);
          },
          controller: plateRecognizeCtrl),
    );
    final inputEmail = Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensPadding.contentPadding),
      child: CommonInputTextFormField(
          hint: S.current.lbl_email,
          textInputAction: TextInputAction.next,
          onValidate: (value) {
            return InputValidate.validateEmpty(value);
          },
          controller: emailTextCtrl),
    );
    final inputPassword = Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensPadding.contentPadding),
      child: CommonPasswordTextFormField(
          isVisiblePassword: false,
          hint: S.current.lbl_password,
          textInputAction: TextInputAction.done,
          onValidate: (value) {
            return InputValidate.validateEmpty(value);
          },
          controller: passwordTextCtrl),
    );
    final logo = Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.asset(
          AppImg.imageLogo,
          fit: BoxFit.cover,
          height: 40,
        ),
      ),
    );
    final signature = Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
        child: Text(
          "Bản quyền thuộc về Kztek.net Việt Nam",
          style: AppTextStyle.caption1Bold.copyWith(
            color: AppColors.backgroundButtonColor,
          ),
        ),
      ),
    );
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is StoreUrlSuccess) {
          context.read<LoginBloc>().add(LoginSubmitted(LoginDTO(
              emailTextCtrl.text.trim(), passwordTextCtrl.text.trim())));
        } else if (state is LoginSuccess) {
          getIt<AuthenticationBloc>().add(const AuthenticationStatusChanged(
              AuthenticationStatus.authenticated));
        } else if (state is LoginStateFailure) {
          context.read<LoginBloc>().add(const LoginStatusChanged());
          await showErrDialogApp(
              context: context,
              content: state.message,
              title: "Lỗi",
              defaultActionText: 'OK');
        }
      },
      builder: (context, state) {
        final btnAccept = SizedBox(
          width: btnWidth,
          height: btnHeight,
          child: AppButtonSuperSmall(
            title: S.current.lbl_accept,
            backgroundColor: AppColors.backgroundButtonColor,
            textColor: AppColors.backgroundColorPure,
            onPressed: _onButtonTap,
            isShowIcon: false,
          ),
        );
        return PopScopeScaffold(
          extendBody: true,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      logo,
                      SizedBox(height: 50,),
                      Center(
                        child: Container(
                          width: 400,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensPadding.contentPadding),
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppDimensPadding.contentPadding),
                          decoration: boxDecoration(),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                contentPadding,
                                titleLogin,
                                screenPadding,
                                inputDomain,
                                screenPadding,
                                inputPlateRecognize,
                                screenPadding,
                                inputEmail,
                                screenPadding,
                                inputPassword,
                                screenPadding,
                                btnAccept,
                                screenPadding,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                signature,
              ],
            ),
          ),
        );
      },
    );
  }

  _onButtonTap() {
    final validateResult = _formKey.currentState?.validate();
    if (validateResult != null && validateResult) {
      context.read<LoginBloc>().add(
          StoreUrl(domainTextCtrl.text.trim(), plateRecognizeCtrl.text.trim()));
    }
  }

  bool checkValidInfo(String email, String password) {
    bool isValidEmail = email.isNotEmpty;
    bool isValidPass = password.isNotEmpty;
    if (isValidPass && isValidEmail) {
      return true;
    }
    return false;
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
        color: AppColors.backgroundColorPure,
        borderRadius: BorderRadius.circular(AppDimensPadding.contentPadding),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]);
  }

  @override
  void dispose() {
    emailTextCtrl.dispose();
    passwordTextCtrl.dispose();
    plateRecognizeCtrl.dispose();
    domainTextCtrl.dispose();
    super.dispose();
  }
}
