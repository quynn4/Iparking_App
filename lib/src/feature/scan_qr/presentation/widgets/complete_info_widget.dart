import 'package:flutter/material.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/complete_info_by_card_number.dart';
import 'package:ipacking_app/src/shared/constants/dimens_constants.dart';

import '../../../../shared/constants/text_style_constants.dart';

class CompleteInfoWidget extends StatelessWidget {
  final CompleteInfoByCardNumber completeInfo;

  const CompleteInfoWidget({Key? key, required this.completeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const smallPadding = SizedBox(
      height: AppDimensPadding.normalPadding,
    );
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensPadding.largePadding),
      child: Column(
        children: [
          vehicleInfo("Mã Thẻ: ", completeInfo.cardInfo.cardNo),
          smallPadding,
          vehicleInfo(
              "Loại xe: ", completeInfo.vehicleGroupInfo.vehicleGroupName),
          smallPadding,
          vehicleInfo(
              "Khách hàng: ", completeInfo.customerGroupInfo.customerGroupName)
        ],
      ),
    );
  }

  Widget vehicleInfo(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.caption1Bold,
        ),
        Text(
          info,
          style: AppTextStyle.caption1,
        ),
      ],
    );
  }
}
