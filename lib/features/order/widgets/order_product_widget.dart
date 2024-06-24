import 'package:stackfood_multivendor/common/widgets/custom_asset_image_widget.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/order/domain/models/order_details_model.dart';
import 'package:stackfood_multivendor/features/order/domain/models/order_model.dart';
import 'package:stackfood_multivendor/common/models/product_model.dart';
import 'package:stackfood_multivendor/helper/price_converter.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductWidget extends StatelessWidget {
  final OrderModel order;
  final OrderDetailsModel orderDetails;
  final int? itemLength;
  final int? index;
  const OrderProductWidget({super.key, required this.order, required this.orderDetails, this.itemLength, this.index});
  
  @override
  Widget build(BuildContext context) {
    String addOnText = '';
    for (var addOn in orderDetails.addOns!) {
      addOnText = '$addOnText${(addOnText.isEmpty) ? '' : ',  '}${addOn.name} (${addOn.quantity})';
    }

    String? variationText = '';
    if(orderDetails.variation!.isNotEmpty) {
      for(Variation variation in orderDetails.variation!) {
        variationText = '${variationText!}${variationText.isNotEmpty ? ', ' : ''}${variation.name} (';
        for(VariationValue value in variation.variationValues!) {
          variationText = '${variationText!}${variationText.endsWith('(') ? '' : ', '}${value.level}';
        }
        variationText = '${variationText!})';
      }
    }else if(orderDetails.oldVariation!.isNotEmpty) {
      List<String> variationTypes = orderDetails.oldVariation![0].type!.split('-');
      if(variationTypes.length == orderDetails.foodDetails!.choiceOptions!.length) {
        int index = 0;
        for (var choice in orderDetails.foodDetails!.choiceOptions!) {
          variationText = '${variationText!}${(index == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index]}';
          index = index + 1;
        }
      }else {
        variationText = orderDetails.oldVariation![0].type;
      }
    }
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeLarge),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

          orderDetails.foodDetails!.image != null && orderDetails.foodDetails!.image!.isNotEmpty ? Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              child: CustomImageWidget(
                height: 70, width: 70, fit: BoxFit.cover,
                image: '${orderDetails.itemCampaignId != null ? Get.find<SplashController>().configModel!.baseUrls!.campaignImageUrl
                    : Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}/'
                    '${orderDetails.foodDetails!.image}',
                isFood: true,
              ),
            ),
          ) : const SizedBox.shrink(),

          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                Expanded(child: Text(
                  orderDetails.foodDetails!.name!,
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Text('${'quantity'.tr}: ', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                Text(
                  orderDetails.quantity.toString(),
                  style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
                ),
              ]),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Row(children: [

                Expanded(child: Text(
                  PriceConverter.convertPrice(orderDetails.price),
                  style: robotoMedium, textDirection: TextDirection.ltr,
                )),

                Get.find<SplashController>().configModel!.toggleVegNonVeg! ? CustomAssetImageWidget(
                  orderDetails.foodDetails!.veg == 0 ? Images.nonVegImage : Images.vegImage,
                  height: 11, width: 11,
                ) : const SizedBox(),

                SizedBox(width: orderDetails.foodDetails!.isRestaurantHalalActive! && orderDetails.foodDetails!.isHalalFood! ? Dimensions.paddingSizeExtraSmall : 0),

                orderDetails.foodDetails!.isRestaurantHalalActive! && orderDetails.foodDetails!.isHalalFood! ? const CustomAssetImageWidget(
                 Images.halalIcon, height: 13, width: 13) : const SizedBox(),

              ]),

            ]),
          ),
        ]),

        addOnText.isNotEmpty ? Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
          child: Row(children: [
            const SizedBox(width: 80),
            Text('${'addons'.tr}: ', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
            Flexible(child: Text(
                addOnText,
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor,
            ))),
          ]),
        ) : const SizedBox(),

        variationText != '' ? (orderDetails.foodDetails!.variations != null && orderDetails.foodDetails!.variations!.isNotEmpty) ? Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
          child: Row(children: [
            const SizedBox(width: 80),
            Text('${'variations'.tr}: ', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
            Flexible(child: Text(
                variationText!,
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor,
            ))),
          ]),
        ) : const SizedBox() : const SizedBox(),

        (!ResponsiveHelper.isDesktop(context) && index == itemLength! - 1) ? const SizedBox() : const Divider(height: Dimensions.paddingSizeLarge),
        SizedBox(height: (!ResponsiveHelper.isDesktop(context) && index == itemLength! - 1) ? 0 : Dimensions.paddingSizeSmall),

      ]),
    );
  }
}
