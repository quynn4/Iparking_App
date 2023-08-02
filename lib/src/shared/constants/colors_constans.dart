import 'package:flutter/material.dart';

import '../utils/hex_color.dart';

class AppColors {
  static final mainColorPrimary = HexColor('#F5F5F5');
  static final textColorPrimary = HexColor('#232222');
  static final inputColor = HexColor('#000000');
  static final inputColorFocused = inputColor.withOpacity(0.87);
  static final inputColorDefault = inputColor.withOpacity(0.37);
  static final borderColorLight = HexColor('#000000').withOpacity(0.12);
  static final disableButtonPrimaryRed = HexColor("#F0B0BF");
  static final textColorSecondary = HexColor('#656565');
  static final backgroundColor = HexColor('#d3d2dd');
  static final mainColorPrimaryDarker = HexColor('#BC0034');
  static final mainColorPrimaryLighter = HexColor('#F93553');
  static final buttonColorPrimary = HexColor('#D51E48');
  static final buttonColorSecondary = HexColor('#232222');
  static final buttonColorTertiary = HexColor('#FFFFFF');
  static final backgroundColorGray = HexColor('#E0DEDE');
  static final backgroundColorPure = HexColor('#FFFFFF');
  static final backgroundButtonColor = HexColor('#251c54');
  static final backgroundColorBase = HexColor('#FBFAFA');
  static final errColor = HexColor('#D02F22');
  static final systemBlueLight = HexColor("#007AFF");
  static final selectedColor = HexColor('#0A7AFF');
  static final textColorDisabled = HexColor('#8E8E8E');
}
