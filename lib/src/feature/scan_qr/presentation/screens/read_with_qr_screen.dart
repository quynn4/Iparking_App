import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/complete_info_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/payment_transaction_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/update_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/presentation/bloc/scan_qr_bloc.dart';
import 'package:ipacking_app/src/shared/component/app_dialog.dart';
import 'package:ipacking_app/src/shared/component/input_text_field.dart';
import 'package:ipacking_app/src/shared/config/routes/routes.dart';
import 'package:ipacking_app/src/shared/constants/colors_constans.dart';
import 'package:ipacking_app/src/shared/constants/dimens_constants.dart';
import 'package:ipacking_app/src/shared/constants/enums_constants.dart';
import 'package:ipacking_app/src/shared/constants/text_style_constants.dart';
import 'package:ipacking_app/src/shared/entitis/user_info.dart';
import 'package:ipacking_app/src/shared/widgets/pop_scope_scaffold.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minio_new/io.dart';
import 'package:minio_new/minio.dart';

import '../../../../../injection_container.dart';
import '../../../../shared/component/app_button_super_small.dart';
import '../../../../shared/config/routes/route_names.dart';
import '../../../../shared/utils/enum_extension.dart';
import '../../../../shared/utils/utils.dart';
import '../../domain/usecases/create_card_by_id_dto.dart';
import '../widgets/complete_info_widget.dart';
import '../widgets/vehicle_in_info_widget.dart';

class ReadWithQRScreen extends StatelessWidget {
  final SystemConfig systemConfig;
  final String scanCode;
  final String laneId;

  const ReadWithQRScreen(
      {Key? key,
      required this.scanCode,
      required this.systemConfig,
      required this.laneId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanQRBloc>(
      create: (context) => getIt(),
      child: ReadWithQRView(
        systemConfig: systemConfig,
        scanCode: scanCode,
        laneId: laneId,
      ),
    );
  }
}

class ReadWithQRView extends StatefulWidget {
  final String scanCode;
  final SystemConfig systemConfig;
  final String laneId;

  const ReadWithQRView(
      {Key? key,
      required this.scanCode,
      required this.systemConfig,
      required this.laneId})
      : super(key: key);

  @override
  State<ReadWithQRView> createState() => _ReadWithQRViewState();
}

class _ReadWithQRViewState extends State<ReadWithQRView> {
  late PackingVehiceByCardNumber packingVehice;
  CompleteInfoByCardNumber? completeInfo;
  bool isShowBtnConfirm = true;
  bool isShowBtnTakePicture = true;
  UserInfo? userInfo;

  TakePictureType takePictureType = TakePictureType.plate;
  final ImagePicker imgPicker = ImagePicker();
  TextEditingController emailTextCtrl = TextEditingController();
  bool isLandOut = false;
  late String setPlate = "";

  List<XFile> imageFiles = [];
  List<File> images = [];
  List<ImageClass> listImageIn = [];
  List<ImageClass> listImageOut = [];
  List<String> listUrl = [];
  late Minio minio;
  late String bucket;

  @override
  void initState() {
    getUserInfo();
    initMinio();
    _addListeners();
    context.read<ScanQRBloc>().add(CompleteInfoSubmitted(widget.scanCode));

    super.initState();
  }

  _addListeners() {
    emailTextCtrl.addListener(() {
      setState(() {});
    });
  }

  void checkLanId() async {
    if (widget.laneId == "") {
      await showErrDialogApp(
          context: context,
          title: "Thông báo!",
          content: "Thẻ không tồn tại",
          defaultActionText: 'OK');
      Routes.instance.pop();
    }
  }

  void initMinio() async {
    minio = Minio(
      endPoint:
          getEndPointFromUrl(widget.systemConfig.physicalFileSetting.endpoint),
      port: int.parse(
          getPortFromUrl(widget.systemConfig.physicalFileSetting.endpoint)),
      useSSL: false,
      accessKey: widget.systemConfig.physicalFileSetting.accessKey,
      secretKey: widget.systemConfig.physicalFileSetting.secretKey,
    );
    bucket = widget.systemConfig.physicalFileSetting.imageBucketName;
    if (!await minio.bucketExists(bucket)) {
      await minio.makeBucket(bucket);
      print('bucket $bucket created');
    } else {
      print('bucket $bucket already exists');
    }
  }

  getUserInfo() async {
    userInfo = await getCurrentUser();
    setState(() {});
  }

  Future getImage() async {
    try {
      final XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
      if (image != null) {
        setState(() {
          imageFiles.add(image);
          images.add(File(image.path));
          listImageIn.add(ImageClass(
              filePath:
                  "IN/${formatDateMinio(DateTime.now())}/${getExtensionFromUrl(image.path)}",
              displayIndex: imageFiles.length - 1,
              description: ""));
          listImageOut.add(ImageClass(
              filePath:
                  "OUT/${formatDateMinio(DateTime.now())}/${getExtensionFromUrl(image.path)}",
              displayIndex: imageFiles.length - 1,
              description: ""));
          if (imageFiles.length == 3) {
            isShowBtnConfirm = true;
            isShowBtnTakePicture = false;
          } else if (imageFiles.length == 2) {
            takePictureType = TakePictureType.person;
          } else if (imageFiles.length == 1) {
            isShowBtnConfirm = true;
            takePictureType = TakePictureType.vehicle;
          }
        });
      }
    } on PlatformException catch (e) {
      print('Faled to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(
      height: 45,
    );
    const smallPadding = SizedBox(
      height: AppDimensPadding.normalPadding,
    );
    final listCaptureImage = imageFiles != []
        ? Wrap(
            children: imageFiles.map((imageOne) {
              return Card(
                child: SizedBox(
                  height: 160,
                  width: 160,
                  child: Image.file(
                    File(imageOne.path),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          )
        : Container();
    return BlocConsumer<ScanQRBloc, ScanQRState>(
      listener: (context, state) async {
        print("DateTime${DateTime.now().toIso8601String()}");
        if (state is GetCompleteInfoState) {
          if (widget.laneId == "") {
            await showErrDialogApp(
                context: context,
                title: "Thông báo!",
                content: "Không có thông tin làn xe",
                defaultActionText: 'OK');
            Routes.instance.pop();
          } else {
            context
                .read<ScanQRBloc>()
                .add(PackingVehiceSubmitted(widget.scanCode));
            setState(() {
              completeInfo = state.completeInfoByCardNumber;
            });
          }
        } else if (state is GetPackingVehiceInfoState) {
          setState(() {
            packingVehice = state.packingVehiceByCardNumber;
            isLandOut = true;
          });
          for (int i = 0;
              i < state.packingVehiceByCardNumber.imagesIn.length;
              i++) {
            String url = await minio.presignedGetObject(
                bucket, state.packingVehiceByCardNumber.imagesIn[i].filePath);
            listUrl.add(url);
          }
        } else if (state is GetPackingVehiceInfoFailure) {
          print("fail");
          await showErrDialogApp(
              context: context,
              title: "Thông báo!",
              content:
                  "Không có dữ liệu xe vào. Vui lòng xác nhận để cho xe vào bãi đỗ!",
              defaultActionText: 'OK');
        } else if (state is GetCompleteInfoFailure) {
          await showErrDialogApp(
              context: context,
              title: "Thông báo!",
              content: "Thẻ không tồn tại",
              defaultActionText: 'OK');
          Routes.instance.pop();
        } else if (state is GetPackingVehiceInfoFailure) {
          context.read<ScanQRBloc>().add(const ScanQRStatusChanged());
        } else if (state is ValidatePlateState) {
          if (state.plateRecognizeResponse.results!.isNotEmpty) {
            final String rawPlate =
                state.plateRecognizeResponse.results![0].plate ?? "";

            final String plate = getPlateVehicle(completeInfo!, rawPlate);
            setState(() {
              setPlate = rawPlate.toUpperCase();
            });
            if (isLandOut == true) {
              await showDialogApp(
                  context: context,
                  title: "Biển số xe: $setPlate",
                  content: packingVehice.plateIn == rawPlate.toUpperCase()
                      ? "Biển số xe đúng, Hãy xác nhận để xe ra khỏi bãi! "
                      : "Biển số xe không đúng, Hãy xác nhận để xe ra khỏi bãi!",
                  defaultActionText: "Huỷ",
                  deleteActionText: "Xác nhận",
                  onDeletePressed: () {
                    context.read<ScanQRBloc>().add(
                        PaymentTransactionSubmitted(paymentTransactionDto()));
                    Routes.instance.pop();
                  },
                  onDefaultPressed: () {
                    Routes.instance.pop();
                    setState(() {
                      imageFiles.clear();
                      isShowBtnConfirm = true;
                      isShowBtnTakePicture = true;
                      takePictureType = TakePictureType.plate;
                    });
                  });
            } else {
              await showDialogApp(
                  context: context,
                  title: "Biển số xe: $setPlate",
                  content: "Ấn xác nhận để xe vào bãi",
                  defaultActionText: "Xác nhận",
                  onDefaultPressed: () {
                    context.read<ScanQRBloc>().add(CreateCardByIdSubmitted(
                        createCardByIdDTO(rawPlate.toUpperCase())));
                    Routes.instance.pop();
                  });
            }
          } else {
            if (isLandOut == true) {
              await showDialogApp(
                  context: context,
                  title: "Thông báo",
                  content:
                      "Không đọc được biển số. Ấn xác nhận để xe ra khỏi bãi",
                  defaultActionText: "Huỷ",
                  deleteActionText: "Xác nhận",
                  onDeletePressed: () {
                    context.read<ScanQRBloc>().add(
                        PaymentTransactionSubmitted(paymentTransactionDto()));
                    Routes.instance.pop();
                  },
                  onDefaultPressed: () {
                    Routes.instance.pop();
                    setState(() {
                      imageFiles.clear();
                      isShowBtnTakePicture = true;
                      takePictureType = TakePictureType.plate;
                    });
                  });
            } else {
              showDialogInputPlate();
              // await showDialogApp(
              //     context: context,
              //     title: "Thông báo",
              //     content: "Không đọc được biển số. Ấn xác nhận để xe vào bãi",
              //     defaultActionText: "Huỷ",
              //     deleteActionText: "Xác nhận",
              //     onDefaultPressed: () {
              //       Routes.instance.pop();
              //       setState(() {
              //         imageFiles.clear();
              //         isShowBtnTakePicture = true;
              //         takePictureType = TakePictureType.plate;
              //       });
              //     },
              //     onDeletePressed: () {
              //       context
              //           .read<ScanQRBloc>()
              //           .add(CreateCardByIdSubmitted(createCardByIdDTO(setPlate)));
              //       Routes.instance.pop();
              //     });
            }
          }
        } else if (state is PaymentTransactionState) {
          context
              .read<ScanQRBloc>()
              .add(UpdateCardByIdSubmitted(updateCardByIdDTO(setPlate)));
        } else if (state is PaymentTransactionFailure) {
          context.read<ScanQRBloc>().add(const ScanQRStatusChanged());
          await showErrDialogApp(
              context: context,
              title: "Thông báo!",
              content: state.message,
              defaultActionText: 'OK');
        } else if (state is UpdateCardByIdFailure) {
          context.read<ScanQRBloc>().add(const ScanQRStatusChanged());
          await showErrDialogApp(
              context: context,
              title: "Thông báo!",
              content: state.message,
              defaultActionText: 'OK');
        } else if (state is UpdateCardByIdState) {
          context.read<ScanQRBloc>().add(const UploadImageSubmitted());
          for (int i = 0; i < images.length; i++) {
            await minio.fPutObject(
                bucket, listImageOut[i].FilePath ?? "", images[i].path);
          }
        } else if (state is CreateCardByIdState) {
          context.read<ScanQRBloc>().add(const UploadImageSubmitted());
          for (int i = 0; i < images.length; i++) {
            await minio.fPutObject(
                bucket, listImageIn[i].FilePath ?? "", images[i].path);
          }
        } else if (state is UploadImageState) {
          await showDialogApp(
              context: context,
              title: "Thành công",
              content: isLandOut
                  ? "Xác nhận xe ra khỏi bãi"
                  : "Xác nhận xe vào bãi đỗ",
              defaultActionText: "Về trang chủ",
              onDefaultPressed: () {
                Routes.instance.navigateAndRemove(RouteNames.homeScreen,
                    routeStopName: RouteNames.splashScreen);
              });
        }
      },
      builder: (context, state) {
        if (completeInfo != null) {
          final btnConfirm = isShowBtnConfirm
              ? SizedBox(
                  width: 150,
                  height: 40,
                  child: AppButtonSuperSmall(
                    backgroundColor: AppColors.systemBlueLight,
                    textColor: AppColors.backgroundColorPure,
                    title: "Xác nhận",
                    onPressed: imageFiles.isNotEmpty
                        ? () {
                            context.read<ScanQRBloc>().add(
                                ValidatePlateSubmitted(imageFiles[0].path));
                          }
                        : isLandOut == true
                            ? (packingVehice.moneys -
                                        packingVehice.feePaid -
                                        packingVehice.discount) <=
                                    0
                                ? () {
                                    context.read<ScanQRBloc>().add(
                                        PaymentTransactionSubmitted(
                                            paymentTransactionDto()));
                                  }
                                : () {
                                    context.read<ScanQRBloc>().add(
                                        UpdateCardByIdSubmitted(
                                            updateCardByIdDTO(setPlate)));
                                  }
                            : () {
                                showDialogInputPlate();
                                // context.read<ScanQRBloc>().add(
                                //     CreateCardByIdSubmitted(
                                //         createCardByIdDTO(setPlate)));
                              },
                  ),
                )
              : Container();
          final landInWidget = PopScopeScaffold(
            appBar: appBar("Xác nhận cho xe vào bãi"),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  padding,
                  pageWidget("Thông tin"),
                  CompleteInfoWidget(completeInfo: completeInfo!),
                  padding,
                  takePhotoButton(takePictureType),
                  pageWidget("Ảnh xe vào"),
                  listCaptureImage,
                  padding,
                  btnConfirm,
                  padding,
                ],
              ),
            ),
          );
          if (isLandOut == true) {
            final listImageIn = packingVehice.imagesIn != []
                ? Wrap(
                    children: listUrl.map((imageOne) {
                      return Card(
                        child: SizedBox(
                          height: 160,
                          width: 160,
                          child: Image.network(
                            imageOne,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Text(
                    "Không có dữ liệu vào",
                    style: AppTextStyle.buttonText,
                  );
            final landOutWidget = PopScopeScaffold(
              appBar: appBar("Xác nhận cho xe ra khỏi bãi"),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    pageWidget("Thông tin xe vào"),
                    CompleteInfoWidget(completeInfo: completeInfo!),
                    smallPadding,
                    VehicleInInfoWidget(packingVehice: packingVehice),
                    padding,
                    pageWidget("Ảnh xe vào"),
                    listImageIn,
                    takePhotoButton(takePictureType),
                    pageWidget("Ảnh xe ra"),
                    listCaptureImage,
                    padding,
                    btnConfirm,
                    padding,
                  ],
                ),
              ),
            );
            return landOutWidget;
          } else {
            return landInWidget;
          }
        } else {
          return PopScopeScaffold(
            body: Container(),
          );
        }
      },
    );
  }

  Widget pageWidget(String title) {
    return Column(
      children: [
        const Divider(),
        Text(
          title,
          style: AppTextStyle.heading2Bold,
        ),
        const Divider(),
      ],
    );
  }

  Widget takePhotoButton(TakePictureType type) {
    return isShowBtnTakePicture
        ? SizedBox(
            width: type == TakePictureType.plate ? 150 : 200,
            height: 40,
            child: AppButtonSuperSmall(
              backgroundColor: AppColors.systemBlueLight,
              textColor: AppColors.backgroundColorPure,
              title: getBtnName(type),
              onPressed: () {
                getImage();
              },
            ),
          )
        : Container();
  }

  String getPlateVehicle(
      CompleteInfoByCardNumber completeInfo, String rawPlate) {
    switch (completeInfo.vehicleGroupInfo.vehicleType) {
      case 1:
        return formatBikePlate(rawPlate);
      case 2:
        return formatCarPlate(rawPlate);
      default:
        return rawPlate;
    }
  }

  AppBar appBar(String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: AppTextStyle.buttonText,
      ),
      centerTitle: true,
      actions: [
        InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTap: () {
            Routes.instance.pop();
          },
          child: Container(
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.clear,
              color: Colors.black,
              size: 24,
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> showDialogInputPlate() {
    return showSimpleDialogApp(
      context,
      CupertinoAlertDialog(
        title: Text(
          "Không đọc được biển số. Vui lòng nhập biển số",
          style: AppTextStyle.body1Bold,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CommonInputTextFormField(
              hint: "Biển số",
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: emailTextCtrl),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Routes.instance.pop();
            },
            child: Text(
              "Huỷ",
              style: AppTextStyle.body1Medium
                  .copyWith(color: AppColors.selectedColor),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              context.read<ScanQRBloc>().add(CreateCardByIdSubmitted(
                  createCardByIdDTO(emailTextCtrl.text.trim().toUpperCase())));
              Routes.instance.pop();
            },
            child: Text(
              "Xác nhận",
              style: AppTextStyle.body1Bold
                  .copyWith(color: AppColors.selectedColor),
            ),
          ),
        ],
      ),
    );
  }

  UpdateCardByIdDTO updateCardByIdDTO(String plateOut) {
    return UpdateCardByIdDTO(
      getId: packingVehice.id,
      getName: completeInfo!.cardInfo.vehicleName1,
      getIsActivate: true,
      getIsDelete: packingVehice.isDelete,
      getEventCode: "2",
      getPlateIn: packingVehice.plateIn,
      getPlateOut: plateOut,
      getImageIn: packingVehice.imagesIn,
      getImageOut: listImageOut,
      getRegisterPlate: packingVehice.registedPlate,
      getCustomerName: packingVehice.customerName,
      getIsDeleted: packingVehice.isDelete,
      getCardNo: packingVehice.cardNo,
      getPaperTicketNumber: packingVehice.paperTicketNumber,
      getDateTimeIn: packingVehice.datetimeIn,
      getDateTimeOut: DateTime.now().toIso8601String(),
      getUserIDIn: packingVehice.userIDIn,
      getUserIDOut: userInfo!.id,
      getLaneIDIn: packingVehice.laneIDIn,
      getLaneIDOut: widget.laneId,
      getCardGroupID: completeInfo!.cardGroupInfo.id,
      getVehicleGroupID: completeInfo!.vehicleGroupInfo.id,
      getIsBlackList: packingVehice.isBlackList,
      getCardNumber: widget.scanCode,
      getIsIncludePaperTicket: packingVehice.isIncludePaperTicket,
      getMoneys: packingVehice.moneys,
    );
  }

  PaymentTransactionDto paymentTransactionDto() {
    return PaymentTransactionDto(
      getId: "",
      getParkingEventId: packingVehice.id,
      getPaymentMethod: 0,
      getType: 0,
      getDateCreate: DateTime.now().toIso8601String(),
      getUser: userInfo!.id,
      getLinkedTransaction: packingVehice.paymentTransactions != []
          ? packingVehice.paymentTransactions
          : null,
      getPayInformation: PayInformationDto(
        getFee: (packingVehice.moneys -
                packingVehice.feePaid -
                packingVehice.discount)
            .toInt(),
        getDiscount: 0,
        getPaid: (packingVehice.moneys -
                packingVehice.feePaid -
                packingVehice.discount)
            .toInt(),
      ),
      getVoucher: "",
      getIsDelete: false,
    );
  }

  CreateCardByIdDTO createCardByIdDTO(String plateIn) {
    return CreateCardByIdDTO(
      eventCode: "1",
      cardNo: completeInfo!.cardInfo.cardNo,
      registedPlate: completeInfo!.cardInfo.plate1,
      customerName: completeInfo!.customerGroupInfo.customerGroupName,
      plateIn: plateIn,
      imagesIn: listImageIn,
      datetimeIn: DateTime.now().toIso8601String(),
      userIDIn: userInfo!.id,
      laneIDIn: widget.laneId,
      cardGroupID: completeInfo!.cardGroupInfo.id,
      vehicleGroupID: completeInfo!.vehicleGroupInfo.id,
      customerGroupID: "",
      cardNumber: widget.scanCode,
    );
  }
}
