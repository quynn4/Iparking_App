
import '../constants/enums_constants.dart';

extension ResourceTypeExtension on ResourceType {
  int get value {
    switch (this) {
      case ResourceType.video:
        return 3;
      case ResourceType.image:
        return 2;
      case ResourceType.text:
        return 1;
      default:
        return 0;
    }
  }
}

final Map<int, ResourceType> resourceInputTypes = Map.of({
  ResourceType.text.value: ResourceType.text,
  ResourceType.image.value: ResourceType.image,
  ResourceType.video.value: ResourceType.video,
});

String getBtnName(TakePictureType type) {
  switch (type) {
    case TakePictureType.plate:
      return "Chụp biển số xe";
    case TakePictureType.vehicle:
      return "Chụp hình phương tiện";
    case TakePictureType.person:
      return "Chụp hình người lái xe";
  }
}
