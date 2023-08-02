import 'dart:io' show Platform, sleep;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ipacking_app/injection_container.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/lane_class.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/feature/home/presentation/bloc/home_bloc.dart';
import 'package:ipacking_app/src/shared/component/app_dialog.dart';
import 'package:ipacking_app/src/shared/config/routes/route_names.dart';
import 'package:ipacking_app/src/shared/config/routes/routes.dart';
import 'package:ipacking_app/src/shared/constants/text_style_constants.dart';
import 'package:ipacking_app/src/shared/widgets/pop_scope_scaffold.dart';

import '../../../../../generated/l10n.dart';
import '../../../../shared/blocs_app/bloc/authentication_bloc.dart';
import '../../../../shared/component/app_action_sheet.dart';
import '../../../../shared/constants/colors_constans.dart';
import '../../../../shared/constants/imgs_constants.dart';
import '../../../../shared/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => getIt<HomeBloc>(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  NFCTag? _tag;
  SystemConfig? systemConfig;
  List<LaneClass>? list;
  String laneId = "";
  bool isSystem = false;
  String platformVersion = '';
  NFCAvailability availability = NFCAvailability.not_supported;
  String? result;

  @override
  void initState() {
    initPlatformState();
    context.read<HomeBloc>().add(const GetSystemConfigEvent());
    if (!kIsWeb) {
      platformVersion =
          '${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
    } else {
      platformVersion = 'Web';
    }
    super.initState();
  }

  Future<void> initPlatformState() async {
    NFCAvailability availability;
    try {
      availability = await FlutterNfcKit.nfcAvailability;
    } on PlatformException {
      availability = NFCAvailability.not_supported;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
      availability = availability;
    });
  }

  @override
  Widget build(BuildContext context) {
    final signature = Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          "Bản quyền thuộc về Kztek.net Việt Nam",
          style: AppTextStyle.caption1Bold.copyWith(
            color: AppColors.backgroundButtonColor,
          ),
        ),
      ),
    );
    final logo = Image.asset(
      AppImg.imageLogo,
      fit: BoxFit.cover,
      height: 40,
    );
    final gridViewWidget = SizedBox(
      height: 250,
      child: GridView.count(
        crossAxisCount: 2,
        primary: false,
        padding: const EdgeInsets.all(24),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          gridItem(
              onTap: () {
                Map<String, dynamic> mapData = {
                  "systemConfig": systemConfig,
                  "laneId": laneId,
                };
                Routes.instance
                    .navigateTo(RouteNames.scanQRScreen, arguments: mapData);
              },
              icon: Icons.qr_code_scanner_outlined,
              title: "Quét mã QR"),
          gridItem(
              onTap: onReadCardTap, icon: Icons.add_card_outlined, title: "Quẹt thẻ"),
        ],
      ),
    );
    final btnLogout = InkWell(
      onTap: () {
        List<Widget> actions = [
          CupertinoActionSheetAction(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
              child: Text(
                S.current.lbl_logout,
                style: AppTextStyle.heading1Bold
                    .copyWith(fontSize: 16, color: AppColors.errColor),
              ))
        ];
        showActionSheetApp(context,
            message: S.current.lbl_content_action_sheet_logout,
            actions: actions);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          Icons.logout_outlined,
          color: AppColors.backgroundButtonColor,
          size: 24,
        ),
      ),
    );
    final textApp = Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 32),
      child: Text(
        "IParking App",
        style: AppTextStyle.heading1Bold
            .copyWith(color: AppColors.backgroundButtonColor, fontSize: 32),
      ),
    );
    return BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
      if (state is GetLaneSuccess) {
        return PopScopeScaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: logo,
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              btnLogout,
            ],
          ),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  textApp,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AppImg.imageCar),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                  ),
                  gridViewWidget,
                ],
              ),
              signature,
            ],
          ),
        );
      } else {
        return PopScopeScaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: logo,
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              btnLogout,
            ],
          ),
          body: const Center(
            child: Text("No data"),
          ),
        );
      }
    }, listener: (context, state) async {
      if (state is GetSystemConfigSuccess) {
        setState(() {
          systemConfig = state.systemConfig;
        });
        context.read<HomeBloc>().add(const GetLaneEvent());
      } else if (state is GetLaneSuccess) {
        setState(() {
          list = state.list;
          laneId = state.list.firstWhere((element) => element.laneType == 7,
              orElse: () {
            return LaneClass(id: "", laneId: "", laneType: 0);
          }).laneId;
        });
      } else if (state is GetSystemConfigFailure) {
        context.read<HomeBloc>().add(const HomeStatusChanged());
        await showErrDialogApp(
            context: context,
            content: state.message,
            title: "Lỗi",
            defaultActionText: 'OK');
      }
    });
  }

  void onTap() {
    Map<String, dynamic> mapData = {
      "scanCode": "9B508750",
      "systemConfig": systemConfig,
      "laneId": laneId,
    };
    Routes.instance.navigateTo(RouteNames.readWithQRScreen, arguments: mapData);
  }

  void onReadCardTap() async {
    showDialogApp();
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      Map<String, dynamic> mapData = {
        "scanCode": formatCardId(tag.id.toString()),
        "systemConfig": systemConfig,
        "laneId": laneId,
      };
      Routes.instance
          .navigateTo(RouteNames.readWithQRScreen, arguments: mapData)
          .then((value) {
        Routes.instance.pop();
      });
      await FlutterNfcKit.setIosAlertMessage("Working on it...");
      if (tag.standard == "ISO 14443-4 (Type B)") {
        String result1 = await FlutterNfcKit.transceive("00B0950000");
        String result2 =
            await FlutterNfcKit.transceive("00A4040009A00000000386980701");
        setState(() {
          result = '1: $result1\n2: $result2\n';
        });
      } else if (tag.type == NFCTagType.iso18092) {
        String result1 = await FlutterNfcKit.transceive("060080080100");
        setState(() {
          result = '1: $result1\n';
        });
      } else if (tag.type == NFCTagType.mifare_ultralight ||
          tag.type == NFCTagType.mifare_classic ||
          tag.type == NFCTagType.iso15693) {
        var ndefRecords = await FlutterNfcKit.readNDEFRecords();
        var ndefString = '';
        for (int i = 0; i < ndefRecords.length; i++) {
          ndefString += '${i + 1}: ${ndefRecords[i]}\n';
        }
        setState(() {
          result = ndefString;
        });
      } else if (tag.type == NFCTagType.webusb) {
        var r = await FlutterNfcKit.transceive("00A4040006D27600012401");
        print(r);
      }
    } catch (e) {
      setState(() {
        result = 'error: $e';
      });
    }

    // Pretend that we are working
    if (!kIsWeb) sleep(const Duration(seconds: 1));
    await FlutterNfcKit.finish(iosAlertMessage: "Finished!");
  }

  Widget gridItem(
      {required VoidCallback onTap,
      required String title,
      required IconData icon}) {
    return InkWell(
        onTap: onTap,
        child: Card(
          elevation: 8,
          color: AppColors.backgroundButtonColor,
          shadowColor: AppColors.backgroundButtonColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 64,
                color: AppColors.backgroundColorPure,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                title,
                style: AppTextStyle.heading2Bold
                    .copyWith(color: AppColors.backgroundColorPure),
              ),
            ],
          ),
        ));
  }

  Future<dynamic> showDialogApp() {
    return showSimpleDialogApp(
      context,
      CupertinoAlertDialog(
        title: Text(
          "Thông báo",
          style: AppTextStyle.body1Bold,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            "Vui lòng đưa thẻ vào máy quẹt thẻ",
            style: AppTextStyle.body1Medium,
          ),
        ),
      ),
    );
  }
}
