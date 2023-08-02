import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ipacking_app/src/feature/scan_qr/data/models/card_event_response.dart';
import 'package:ipacking_app/src/feature/scan_qr/data/models/complete_info_by_card_number_response.dart';
import 'package:ipacking_app/src/feature/scan_qr/data/models/packing_vehice_by_card_number_response.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/card_event.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/complete_info_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/payment_transaction_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/update_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/upload_image_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/create_card_by_id_dto.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';
import 'package:ipacking_app/src/shared/network/network_info.dart';

import '../../../../shared/services/rest_api_service.dart';

class ScanQRRemoteDataSource {
  final RestClient _client;
  final NetworkInfo _networkInfo;

  ScanQRRemoteDataSource(this._client, this._networkInfo);

  Future<Either<Failure, CompleteInfoByCardNumber>> completeInfoByCardNumber(
      String cardNumber) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse =
            await _client.completeInfoByCardNumber(cardNumber);
        if (requestResponse.statusCode == 200) {
          final String result = requestResponse.result ?? "";
          Map<String, dynamic> map = jsonDecode(result);
          final CompleteInfoByCardNumberResponse response =
              CompleteInfoByCardNumberResponse.fromJson(map);
          return Right(_getCompleteInfoByCardNumberResponse(response));
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<Either<Failure, PackingVehiceByCardNumber>> packingVehiceByCardNumber(
      String cardNumber) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse =
            await _client.parkingVehiceByCardNumber(cardNumber);
        if (requestResponse.statusCode == 200) {
          final String result = requestResponse.result ?? "";
          Map<String, dynamic> map = jsonDecode(result);
          final PackingVehiceByCardNumberResponse response =
              PackingVehiceByCardNumberResponse.fromJson(map);
          return Right(_getPackingVehiceByCardNumber(response));
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<Either<Failure, CardEvent>> updateCardById(
      UpdateCardByIdDTO updateCardByIdDTO) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse = await _client.updateCardById(
            updateCardByIdDTO.getId, updateCardByIdDTO);
        if (requestResponse.statusCode == 200) {
          final String result = requestResponse.result ?? "";
          Map<String, dynamic> map = jsonDecode(result);
          final CardEventResponse response = CardEventResponse.fromJson(map);
          return Right(_getCardEventFromResponse(response));
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<Either<Failure, CardEvent>> createCardByID(
      CreateCardByIdDTO createCardByIdDTO) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse = await _client.createCardById(createCardByIdDTO);
        if (requestResponse.statusCode == 200) {
          final String result = requestResponse.result ?? "";
          Map<String, dynamic> map = jsonDecode(result);
          final CardEventResponse response = CardEventResponse.fromJson(map);
          return Right(_getCardEventFromResponse(response));
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<Either<Failure, bool>> paymentTransaction(
      PaymentTransactionDto paymentTransactionDto) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse =
            await _client.paymentTransaction(paymentTransactionDto);
        if (requestResponse.statusCode == 200) {
          return const Right(true);
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<Either<Failure, bool>> uploadCardEventImage(
      UploadImageDto uploadImageDto) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse = await _client.uploadImages(
            uploadImageDto.cardEventId, uploadImageDto.image);
        if (requestResponse.statusCode == 200) {
          return const Right(true);
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }
}

CardEvent _getCardEventFromResponse(CardEventResponse? response) {
  if (response != null) {
    return CardEvent(
        id: response.id ?? "", eventCode: response.eventCode ?? "");
  } else {
    return CardEvent(id: "", eventCode: "");
  }
}

CompleteInfoByCardNumber _getCompleteInfoByCardNumberResponse(
    CompleteInfoByCardNumberResponse? response) {
  if (response != null) {
    return CompleteInfoByCardNumber(
      cardInfo: _getCardInfo(response.cardInfo),
      cardGroupInfo: _getCardGroupInfo(response.cardGroupInfo),
      vehicleGroupInfo: _getVehicleGroupInfo(response.vehicleGroupInfo),
      customerGroupInfo: _getCustomerGroupInfo(response.customerGroupInfo),
    );
  } else {
    return CompleteInfoByCardNumber(
      cardInfo: _getCardInfo(null),
      cardGroupInfo: _getCardGroupInfo(null),
      vehicleGroupInfo: _getVehicleGroupInfo(null),
      customerGroupInfo: _getCustomerGroupInfo(null),
    );
  }
}

CustomerGroupInfo _getCustomerGroupInfo(CustomerGroupInfoResponse? response) {
  if (response != null) {
    return CustomerGroupInfo(
      id: response.id ?? "",
      customerGroupID: response.customerGroupID ?? "",
      parentID: response.parentID ?? "",
      customerGroupCode: response.customerGroupCode ?? "",
      customerGroupName: response.customerGroupName ?? "",
      description: response.description ?? "",
      inactive: response.inactive ?? false,
      sortOrder: response.sortOrder ?? 0,
      ordering: response.ordering ?? 0,
      tax: response.tax ?? "",
      isCompany: response.isCompany ?? false,
    );
  } else {
    return CustomerGroupInfo(
        id: "",
        customerGroupID: "",
        parentID: "",
        customerGroupCode: "",
        customerGroupName: "",
        description: "",
        inactive: false,
        sortOrder: 0,
        ordering: 0,
        tax: "",
        isCompany: false);
  }
}

CardInfo _getCardInfo(CardInfoResponse? response) {
  if (response != null) {
    return CardInfo(
        id: response.id ?? "",
        cardID: response.cardID ?? "",
        cardNo: response.cardNo ?? "",
        cardNumber: response.cardNumber ?? "",
        customerID: response.customerID ?? "",
        cardGroupID: response.cardGroupID ?? "",
        importDate: response.importDate ?? "",
        expireDate: response.expireDate ?? "",
        plate1: response.plate1 ?? "",
        plateUnsign1: response.plateUnsign1 ?? "",
        vehicleName1: response.vehicleName1 ?? "",
        plate2: response.plate2 ?? "",
        plateUnsign2: response.plateUnsign2 ?? "",
        vehicleName2: response.vehicleName2 ?? "",
        plate3: response.plate3 ?? "",
        plateUnsign3: response.plateUnsign3 ?? "",
        vehicleName3: response.vehicleName3 ?? "",
        isLock: response.isLock ?? false,
        isDelete: response.isDelete ?? false,
        sortOrder: response.sortOrder ?? 0,
        description: response.description ?? "",
        dateRegister: response.dateRegister ?? "",
        dateRelease: response.dateRelease ?? "",
        dateCancel: response.dateCancel ?? "",
        dateActive: response.dateActive ?? "",
        accessExpireDate: response.accessExpireDate ?? "",
        accessLevelID: response.accessLevelID ?? "",
        chkRelease: response.chkRelease ?? false,
        isAutoCapture: response.isAutoCapture ?? false,
        isLost: response.isLost ?? false);
  } else {
    return CardInfo(
        id: "",
        cardID: "",
        cardNo: "",
        cardNumber: "",
        customerID: "",
        cardGroupID: "",
        importDate: "",
        expireDate: "",
        plate1: "",
        plateUnsign1: "",
        vehicleName1: "",
        plate2: "",
        plateUnsign2: "",
        vehicleName2: "",
        plate3: "",
        plateUnsign3: "",
        vehicleName3: "",
        isLock: false,
        isDelete: false,
        sortOrder: 0,
        description: "",
        dateRegister: "",
        dateRelease: "",
        dateCancel: "",
        dateActive: "",
        accessExpireDate: "",
        accessLevelID: "",
        chkRelease: false,
        isAutoCapture: false,
        isLost: false);
  }
}

CardGroupInfo _getCardGroupInfo(CardGroupInfoResponse? response) {
  if (response != null) {
    return CardGroupInfo(
        id: response.id ?? "",
        cardGroupID: response.cardGroupID ?? "",
        cardGroupCode: response.cardGroupCode ?? "",
        cardGroupName: response.cardGroupName ?? "",
        description: response.description ?? "",
        cardType: response.cardType ?? 0,
        vehicleGroupID: response.vehicleGroupID ?? "",
        laneIDs: response.laneIDs ?? "",
        dayTimeFrom: response.dayTimeFrom ?? "",
        dayTimeTo: response.dayTimeTo ?? "",
        formulation: response.formulation ?? 0,
        eachFee: response.eachFee ?? 0,
        block0: response.block0 ?? 0,
        time0: response.time0 ?? 0,
        block1: response.block1 ?? 0,
        time1: response.time1 ?? 0,
        block2: response.block2 ?? 0,
        time2: response.time2 ?? 0,
        block3: response.block3 ?? 0,
        time3: response.time3 ?? 0,
        block4: response.block4 ?? 0,
        time4: response.time4 ?? 0,
        block5: response.block5 ?? 0,
        time5: response.time5 ?? 0,
        timePeriods: response.timePeriods ?? "",
        costs: response.costs ?? "",
        inactive: response.inactive ?? false,
        sortOrder: response.sortOrder ?? 0,
        isHaveMoneyExcessTime: response.isHaveMoneyExcessTime ?? false,
        enableFree: response.enableFree ?? false,
        freeTime: response.freeTime ?? 0,
        isCheckPlate: response.isCheckPlate ?? false,
        isHaveMoneyExpiredDate: response.isHaveMoneyExpiredDate ?? false);
  } else {
    return CardGroupInfo(
        id: "",
        cardGroupID: "",
        cardGroupCode: "",
        cardGroupName: "",
        description: "",
        cardType: 0,
        vehicleGroupID: "",
        laneIDs: "",
        dayTimeFrom: "",
        dayTimeTo: "",
        formulation: 0,
        eachFee: 0,
        block0: 0,
        time0: 0,
        block1: 0,
        time1: 0,
        block2: 0,
        time2: 0,
        block3: 0,
        time3: 0,
        block4: 0,
        time4: 0,
        block5: 0,
        time5: 0,
        timePeriods: "",
        costs: "",
        inactive: false,
        sortOrder: 0,
        isHaveMoneyExcessTime: false,
        enableFree: false,
        freeTime: 0,
        isCheckPlate: false,
        isHaveMoneyExpiredDate: false);
  }
}

VehicleGroupInfo _getVehicleGroupInfo(VehicleGroupInfoResponse? response) {
  if (response != null) {
    return VehicleGroupInfo(
        id: response.id ?? "",
        vehicleGroupID: response.vehicleGroupID ?? "",
        vehicleGroupCode: response.vehicleGroupCode ?? "",
        vehicleGroupName: response.vehicleGroupName ?? "",
        vehicleType: response.vehicleType ?? 0,
        limitNumber: response.limitNumber ?? 0,
        inactive: response.inactive ?? false,
        sortOrder: response.sortOrder ?? 0);
  } else {
    return VehicleGroupInfo(
        id: "",
        vehicleGroupID: "",
        vehicleGroupCode: "",
        vehicleGroupName: "",
        vehicleType: 0,
        limitNumber: 0,
        inactive: false,
        sortOrder: 0);
  }
}

PackingVehiceByCardNumber _getPackingVehiceByCardNumber(
    PackingVehiceByCardNumberResponse? response) {
  if (response != null) {
    return PackingVehiceByCardNumber(
        id: response.id ?? "",
        eventCode: response.eventCode ?? "",
        cardNumber: response.cardNumber ?? "",
        datetimeIn: response.datetimeIn ?? "",
        dateTimeOut: response.dateTimeOut ?? "",
        imagesIn: _getListImageClass(response.imagesIn),
        imagesOut: _getListImageClass(response.imagesOut),
        laneIDIn: response.laneIDIn ?? "",
        laneIDOut: response.laneIDOut ?? "",
        userIDIn: response.userIDIn ?? "",
        userIDOut: response.userIDOut ?? "",
        plateIn: response.plateIn ?? "",
        plateOut: response.plateOut ?? "",
        registedPlate: response.registedPlate ?? "",
        moneys: response.moneys ?? 0,
        cardGroupID: response.cardGroupID ?? "",
        vehicleGroupID: response.vehicleGroupID ?? "",
        customerGroupID: response.customerGroupID ?? "",
        customerName: response.customerName ?? "",
        isBlackList: response.isBlackList ?? false,
        isFree: response.isFree ?? false,
        isDelete: response.isDelete ?? false,
        freeType: response.freeType ?? "",
        cardNo: response.cardNo ?? "",
        description: response.description ?? "",
        paperTicketNumber: response.paperTicketNumber ?? "",
        isIncludePaperTicket: response.isIncludePaperTicket ?? false,
        unsignPlateIn: response.unsignPlateIn ?? "",
        unsignPlateOut: response.unsignPlateOut ?? "",
        feePaid: response.feePaid ?? 0,
        discount: response.discount ?? 0,
        vouchers: response.vouchers ?? "",
        paymentTransactions: response.paymentTransactions ?? [],
        token: response.token ?? "",
        inUserName: response.inUserName ?? "",
        inLaneName: response.inLaneName ?? "",
        outUserName: response.outUserName ?? "",
        outLaneName: response.outLaneName ?? "",
        customerGroupName: response.customerGroupName ?? "",
        cardGroupName: response.cardGroupName ?? "",
        vehicleGroupName: response.vehicleGroupName ?? "");
  } else {
    return PackingVehiceByCardNumber(
        id: "",
        eventCode: "",
        cardNumber: "",
        datetimeIn: "",
        dateTimeOut: "",
        imagesIn: _getListImageClass(null),
        imagesOut: _getListImageClass(null),
        laneIDIn: "",
        laneIDOut: "",
        userIDIn: "",
        userIDOut: "",
        plateIn: "",
        plateOut: "",
        registedPlate: "",
        moneys: 0,
        cardGroupID: "",
        vehicleGroupID: "",
        customerGroupID: "",
        customerName: "",
        isBlackList: false,
        isFree: false,
        isDelete: false,
        freeType: "",
        cardNo: "",
        description: "",
        paperTicketNumber: "",
        isIncludePaperTicket: false,
        unsignPlateIn: "",
        unsignPlateOut: "",
        feePaid: 0,
        discount: 0,
        vouchers: "",
        paymentTransactions: [],
        token: "",
        inUserName: "",
        inLaneName: "",
        outUserName: "",
        outLaneName: "",
        customerGroupName: "",
        cardGroupName: "",
        vehicleGroupName: "");
  }
}

List<ImageClass> _getListImageClass(List<ImageResponse>? list) {
  List<ImageClass> listImageClass = [];
  if (list != null && list.isNotEmpty) {
    for (var imageClass in list) {
      listImageClass.add(_getImageClass(imageClass));
    }
  }
  return listImageClass;
}

ImageClass _getImageClass(ImageResponse? response) {
  if (response != null) {
    return ImageClass(
        filePath: response.filePath ?? "",
        displayIndex: response.displayIndex ?? 0,
        description: response.description ?? "");
  } else {
    return ImageClass(filePath: "", displayIndex: 0, description: "");
  }
}
