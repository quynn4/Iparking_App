import 'package:flutter/material.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';

import '../../../../shared/constants/dimens_constants.dart';
import '../../../../shared/constants/text_style_constants.dart';
import '../../../../shared/utils/utils.dart';

class VehicleInInfoWidget extends StatelessWidget {
  final PackingVehiceByCardNumber packingVehice;

  const VehicleInInfoWidget({Key? key, required this.packingVehice})
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
          vehicleInfo(
            "Thời gian vào: ",
            formatDate(packingVehice.datetimeIn),
          ),
          smallPadding,
          vehicleInfo(
            "Biển số xe vào: ",
            packingVehice.plateIn.toUpperCase(),
          ),
          smallPadding,
          vehicleInfo(
              "Số tiền: ",
              packingVehice.moneys -
                          packingVehice.feePaid -
                          packingVehice.discount <=
                      0
                  ? FormatPrice(0).price().toString()
                  : FormatPrice((packingVehice.moneys -
                          packingVehice.feePaid -
                          packingVehice.discount))
                      .price()
                      .toString()),
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
