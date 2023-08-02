import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/shared/component/app_dialog.dart';
import 'package:ipacking_app/src/shared/config/routes/route_names.dart';
import 'package:ipacking_app/src/shared/constants/colors_constans.dart';
import 'package:ipacking_app/src/shared/constants/dimens_constants.dart';
import 'package:ipacking_app/src/shared/constants/icons_constants.dart';
import 'package:ipacking_app/src/shared/constants/text_style_constants.dart';
import 'package:ipacking_app/src/shared/widgets/pop_scope_scaffold.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../shared/config/routes/routes.dart';

class ScanQRScreen extends StatefulWidget {
  final SystemConfig systemConfig;
  final String laneId;
  const ScanQRScreen({Key? key, required this.systemConfig, required this.laneId}) : super(key: key);

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  Barcode? result;
  QRViewController? controller;
  bool isFlashTurnOn = false;
  bool isScanSuccess = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  double positionButton = 419;

  @override
  void initState() {
    checkPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPositionButton(qrKey.currentContext?.size?.flipped.height);
    });
    super.initState();
  }



  getPositionButton(double? height) {
    const double padding = 48;
    if (height != null) {
      positionButton = height + padding + 17;
    }
    setState(() {});
  }

  Future<void> checkPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    } else {}
  }

  Future<void> foundQRCode(scanCode) async {
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
      await controller?.stopCamera();
    } else {
      controller!.pauseCamera();
    }
    try {
      if (result != null) {
        if (isScanSuccess == false) {
          Map<String, dynamic> mapData = {
            "scanCode": result!.code,
            "systemConfig": widget.systemConfig,
            "laneId": widget.laneId,
          };
          Routes.instance
              .navigateTo(RouteNames.readWithQRScreen, arguments: mapData)
              .then((value) async {
            isScanSuccess = false;
            await controller?.resumeCamera();
          });
        }
      } else {
        if (mounted) {
          await showErrDialogApp(
                  context: context,
                  title: "OPP!",
                  content: "QR code is wrong",
                  defaultActionText: "OK")
              .then((value) async {
            isScanSuccess = false;
            if (Platform.isAndroid) {
              await controller?.resumeCamera();
            } else {
              await controller?.resumeCamera();
            }
          });
        }
      }
    } catch (e) {
      if (mounted) {
        await showErrDialogApp(
                context: context,
                title: "OPP!",
                content: "QR code is wrong",
                defaultActionText: "OK")
            .then((value) async {
          isScanSuccess = false;
          if (Platform.isAndroid) {
            await controller?.resumeCamera();
          } else {
            await controller?.resumeCamera();
          }
        });
      }
    }
    isScanSuccess = true;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadiusBox = 12.0;
    final qrView = QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutBottomOffset: 96.5,
        borderLength: 70,
        cutOutHeight: 319,
        cutOutWidth: 319,
        borderColor: AppColors.buttonColorTertiary,
        borderWidth: 10,
        overlayColor: AppColors.textColorPrimary.withOpacity(0.7),
      ),
    );
    final tipTitle = Text(
      "Vui lòng đưa máy vào mã QR\n in trên mặt thẻ",
      style: AppTextStyle.caption1Medium
          .apply(color: AppColors.backgroundColorPure),
      textAlign: TextAlign.center,
      maxLines: 2,
    );
    final boxTip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 63, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusBox),
          color: AppColors.textColorPrimary),
      child: tipTitle,
    );
    const largePadding = SizedBox(
      height: AppDimensPadding.largePadding,
    );
    final content = Center(
      child: Column(
        children: [
          largePadding,
          boxTip,
          largePadding,
        ],
      ),
    );
    final flashButton = InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: _onButtonFlash,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: isFlashTurnOn
            ? AppColors.backgroundColorPure
            : AppColors.textColorDisabled,
        child: SvgPicture.asset(
            isFlashTurnOn ? AppIcons.iconFlash : AppIcons.iconFlashOff),
      ),
    );
    return PopScopeScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.textColorPrimary,
          centerTitle: true,
          title: Text(
            "Quét mã QR",
            style: AppTextStyle.body1Bold
                .apply(color: AppColors.backgroundColorPure),
          ),
          actions: [
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {
                Routes.instance.pop();
              },
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AppIcons.iconCloseWhite),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          qrView,
          content,
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: flashButton,
              )),
        ],
      ),
    );
  }

  void _onButtonFlash() async {
    await controller!.toggleFlash();
    setState(() {
      isFlashTurnOn = !isFlashTurnOn;
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      await foundQRCode(scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
