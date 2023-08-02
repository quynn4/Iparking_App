class AuthApi{
  static const String _base = "/api";
  static const String login = "$_base/login";
}
class ReadCard {
  static const String _base = "/api";
  static const String parkingVehiceByCardNumber = "$_base/tblCardEvent/parkingVehiceByCardNumber";
  static const String completeInfoByCardNumber = "$_base/tblCard/completeInfoByCardNumber";
  static const String updateCardById = "$_base/tblCardEvent/{id}";
  static const String createCardById = "$_base/tblCardEvent";
}
class UploadImage {
  static const String _base = "/api";
  static const String image = "$_base/Images";
  static const String newCardEventImage = "$image/NewCardEventImages";
}
class SystemsConfig {
  static const _base = "/api";
  static const getSystemConfig = "$_base/tblSystemConfig";
}
class Payment {
  static const _base = "/api";
  static const paymentTransaction = "$_base/PaymentTransaction/NewTransaction";
}

class Lane {
  static const _base = "/api";
  static const getLane = "$_base/tblLane/byList";
}
