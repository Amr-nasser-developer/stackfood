import 'package:stackfood_multivendor/features/profile/controllers/profile_controller.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/loyalty/widgets/loyalty_bottom_sheet_widget.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class LoyaltyCardWidget extends StatelessWidget {
  final JustTheController tooltipController;
  const LoyaltyCardWidget({super.key, required this.tooltipController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (userController) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.paddingSizeLarge),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.isDesktop(context) ? 35 : Dimensions.paddingSizeExtraOverLarge,
              vertical: ResponsiveHelper.isDesktop(context) ? 35 : Dimensions.paddingSizeOverLarge,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              color: Theme.of(context).disabledColor.withOpacity(0.2),
            ),
            child:  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(width: Dimensions.paddingSizeExtraLarge),

              Image.asset(Images.loyal , height: 70, width: 70, color: null),
              const SizedBox(width: Dimensions.paddingSizeExtraOverLarge),

              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                ResponsiveHelper.isDesktop(context) ? const SizedBox() : Text(
                  'loyalty_points'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                ),

                Text(
                  userController.userInfoModel?.loyaltyPoint == null ? '0' : userController.userInfoModel!.loyaltyPoint.toString(),
                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).textTheme.bodyLarge!.color),
                ),

                ResponsiveHelper.isDesktop(context) ? Text(
                  'loyalty_points'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                ) : const SizedBox(),

                const SizedBox(height: Dimensions.paddingSizeSmall),
              ])
            ]),
          ),
          ResponsiveHelper.isDesktop(context) ? const SizedBox() : const SizedBox(height: Dimensions.paddingSizeLarge),
          ResponsiveHelper.isDesktop(context) ? const SizedBox(height: Dimensions.paddingSizeDefault) : const SizedBox(),

          ResponsiveHelper.isDesktop(context) ? Text('how_to_use'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)) : const SizedBox(),
          ResponsiveHelper.isDesktop(context) ? const SizedBox(height: Dimensions.paddingSizeDefault) : const SizedBox(),

          !ResponsiveHelper.isDesktop(context) ? const SizedBox() : const LoyaltyStepper(),
        ],
      );
    });
  }
}



class LoyaltyStepper extends StatelessWidget {
  const LoyaltyStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                ),
              ),

              Expanded(
                child: VerticalDivider(
                  thickness: 3,
                  color: Theme.of(context).primaryColor.withOpacity(0.30),
                ),
              ),

              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                ),
              ),
            ]),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('convert_your_loyalty_point_to_wallet_money'.tr, style: robotoRegular),
                  Text('${'minimun'.tr} ${Get.find<SplashController>().configModel!.loyaltyPointExchangeRate} ${'points_required_to_convert_into_currency'.tr}', style: robotoRegular),
                ],
              ),
            ),

          ]),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        CustomButtonWidget(
          radius: Dimensions.radiusSmall,
          isBold: true,
          buttonText: 'convert_to_currency_now'.tr,
          onPressed: () {
            Get.dialog(
              Dialog(backgroundColor: Colors.transparent, child: LoyaltyBottomSheetWidget(
                amount: Get.find<ProfileController>().userInfoModel!.loyaltyPoint == null
                  ? '0' : Get.find<ProfileController>().userInfoModel!.loyaltyPoint.toString(),
              )),
            );
          },
        ),
      ],
    );
  }
}

