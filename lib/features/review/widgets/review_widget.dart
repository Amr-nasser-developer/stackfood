import 'package:stackfood_multivendor/common/models/review_model.dart';
import 'package:stackfood_multivendor/common/widgets/rating_bar_widget.dart';
import 'package:stackfood_multivendor/common/widgets/readmore_widget.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/helper/date_converter.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  final bool hasDivider;
  final String? restaurantName;
  const ReviewWidget({super.key, required this.review, required this.hasDivider, this.restaurantName});

  @override
  Widget build(BuildContext context) {

    bool isDesktop = ResponsiveHelper.isDesktop(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [

        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          
            Text(review.customerName ?? '', style: robotoMedium),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          
            RatingBarWidget(rating: review.rating!.toDouble(), ratingCount: null, size: 18),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            isDesktop ? Text(DateConverter.stringDateTimeToDate(review.createdAt!), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)) : const SizedBox(),
            SizedBox(height: isDesktop ?  Dimensions.paddingSizeExtraSmall : 0),

            isDesktop ? ReadMoreText(
              review.comment ?? '',
              style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.7)),
              trimMode: TrimMode.Line,
              trimLines: 3,
              colorClickableText: Theme.of(context).primaryColor,
              lessStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
              trimCollapsedText: 'show_more'.tr,
              trimExpandedText: ' ${'show_less'.tr}',
              moreStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
            ) : Text(DateConverter.stringDateTimeToDate(review.createdAt!), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
          
          ]),
        ),
        SizedBox(width: isDesktop ? Dimensions.paddingSizeLarge : 0),

        isDesktop ? Column(children: [

          Container(
            height: 90, width: 120,
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.2)),
            ),
            child:  ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              child: CustomImageWidget(
                image: '${Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}/${review.foodImage ?? ''}',
                height: 45, width: 45, fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Container(width: 120, alignment: Alignment.center, child: Text(review.foodName ?? '', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor), overflow: TextOverflow.ellipsis, maxLines: 1)),

        ]) : Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.2)),
          ),
          child: Row(children: [

            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            SizedBox(
              width: 70,
              child: Text(review.foodName ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall), overflow: TextOverflow.ellipsis, maxLines: 1),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              child: CustomImageWidget(
                image: '${Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}/${review.foodImage ?? ''}',
                height: 45, width: 45, fit: BoxFit.cover,
              ),
            ),

          ]),
        ),

      ]),
      const SizedBox(height: Dimensions.paddingSizeDefault),

      isDesktop ? const SizedBox() : ReadMoreText(
        review.comment ?? '',
        style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.7)),
        trimMode: TrimMode.Line,
        trimLines: 3,
        colorClickableText: Theme.of(context).primaryColor,
        lessStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
        trimCollapsedText: 'show_more'.tr,
        trimExpandedText: ' ${'show_less'.tr}',
        moreStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
      ),
      SizedBox(height: isDesktop ? 0 : Dimensions.paddingSizeSmall),

      review.reply != null ? Container(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

            Text(restaurantName ?? '', style: robotoMedium),

            Text(DateConverter.stringDateTimeToDate(review.updatedAt!), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),

          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          ReadMoreText(
            review.reply ?? '',
            style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.7)),
            trimMode: TrimMode.Line,
            trimLines: 3,
            colorClickableText: Theme.of(context).primaryColor,
            lessStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
            trimCollapsedText: 'show_more'.tr,
            trimExpandedText: ' ${'show_less'.tr}',
            moreStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
          ),

        ]),
      ) : const SizedBox(),

      hasDivider ? Divider(
        height: 40, thickness: 1,
        color: Theme.of(context).disabledColor.withOpacity(0.5),
      ) : const SizedBox(),

    ]);
  }
}
