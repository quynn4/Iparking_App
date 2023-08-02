import 'package:dio/dio.dart';
import 'package:ipacking_app/src/shared/services/local_store_service.dart';


class DioUploadService {
  final LocalStorageService localService;

  DioUploadService(this.localService);

  Future<dynamic> uploadPhotos(String path) async {
    MultipartFile files = await MultipartFile.fromFile(path);
    final storeUrl =
        (await localService.getUrlInfo()).fold((l) => null, (r) => r);

    FormData formData = FormData.fromMap({'upload': files, 'region': "vn"});

    var response = await Dio().post(storeUrl!.plateUrl, data: formData);

    print('\n\n');
    print('RESPONSE WITH DIO');
    print(response.data);
    print('\n\n');
    return response.data;
  }
}
