import 'dart:io';

class UploadImageDto {
  final String cardEventId;
  final List<File> image;

  UploadImageDto(this.cardEventId, this.image);
}