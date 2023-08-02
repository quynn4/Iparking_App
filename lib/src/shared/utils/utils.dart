import 'package:intl/intl.dart';
import 'package:ipacking_app/src/feature/login/presentation/bloc/login_bloc.dart';
import 'package:ipacking_app/src/shared/entitis/user_info.dart';

import '../../../injection_container.dart';
import '../services/local_store_service.dart';

Future<UserInfo?> getCurrentUser() async {
  final user = await getIt<LocalStorageService>().getCurrentUser();
  return user.fold((l) => null, (r) => r);
}
extension FormatPrice on double {
  String price() {
    final formatPrice = NumberFormat("#,###₫", "en_US");
    return formatPrice.format(this);
  }
}

String getExtensionFromUrl(String url) => url.split('/').last;

String getEndPointFromUrl(String url) => url.split(':').first;

String getPortFromUrl(String url) => url.split(':').last;

String formatDate(String dateTime) {
  DateTime dt = DateTime.parse(dateTime);
  return DateFormat("yyyy/MM/dd HH:mm").format(dt);
}

String formatDateMinio(DateTime dateTime) {
  return DateFormat("yyyy-MM-dd").format(dateTime);
}

String formatBikePlate(String plate) {
  final String fistPlate = plate.substring(0, 4).toUpperCase();
  final String lastPlate = plate.substring(4, plate.length);
  return "$fistPlate-$lastPlate";
}

String formatCarPlate(String plate) {
  final String fistPlate = plate.substring(0, 3).toUpperCase();
  final String lastPlate = plate.substring(3, plate.length);
  return "$fistPlate-$lastPlate";
}

String formatCardId(String id) {
  final List<String> singleWord = id.trim().split("");
  if (singleWord.length == 8) {
    final String word =
        "${singleWord[6]}${singleWord[7]}${singleWord[4]}${singleWord[5]}${singleWord[2]}${singleWord[3]}${singleWord[0]}${singleWord[1]}";
    return word;
  } else {
    return "";
  }
}
