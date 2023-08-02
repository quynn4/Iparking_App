import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/payment_transaction_dto.dart';
import 'package:ipacking_app/src/shared/services/request_response.dart';

import 'package:retrofit/retrofit.dart';

import '../../../env.dart';
import '../../feature/login/domain/entities/login_dto.dart';
import '../../feature/scan_qr/domain/entities/update_card_by_id.dart';
import '../../feature/scan_qr/domain/usecases/create_card_by_id_dto.dart';
import '../constants/api_constants.dart';

part 'rest_api_service.g.dart';

///We do call the rest API to get, store data on a remote database for that we
///need to write the rest API call at a single place and need to return the data
///if the rest call is a success or need to return custom error exception on the
///basis of 4xx, 5xx status code. We can make use of http package to make the
///rest API call in the flutter

///APIs class is for api tags
///
///NOTE: run this command everytime you edit this file: flutter pub run build_runner build --delete-conflicting-outputs

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(AuthApi.login)
  Future<RequestResponse> loginEmail(@Body() LoginDTO loginDTO);

  @GET(ReadCard.parkingVehiceByCardNumber)
  Future<RequestResponse> parkingVehiceByCardNumber(
      @Query("cardNumber") String cardNumber);

  @GET(ReadCard.completeInfoByCardNumber)
  Future<RequestResponse> completeInfoByCardNumber(
      @Query("cardNumber") String cardNumber);

  @PUT(ReadCard.updateCardById)
  Future<RequestResponse> updateCardById(
      @Path() String id, @Body() UpdateCardByIdDTO updateCardByIdDTO);

  @POST(ReadCard.createCardById)
  Future<RequestResponse> createCardById(
      @Body() CreateCardByIdDTO createCardByIdDTO);

  @POST(UploadImage.newCardEventImage)
  @MultiPart()
  Future<RequestResponse> uploadImages(
      @Query("cardEventId") String cardEventId, @Part() List<File> files);

  @GET(SystemsConfig.getSystemConfig)
  Future<RequestResponse> getSystemConfig();

  @POST(Payment.paymentTransaction)
  Future<RequestResponse> paymentTransaction(
      @Body() PaymentTransactionDto paymentTransactionDto);

  @GET(Lane.getLane)
  Future<RequestResponse> getLane();
}
