import 'package:carousel_slider/carousel_slider.dart';
import 'package:stackfood_multivendor/features/home/controllers/home_controller.dart';
import 'package:stackfood_multivendor/features/restaurant/screens/restaurant_screen.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/product/domain/models/basic_campaign_model.dart';
import 'package:stackfood_multivendor/common/models/product_model.dart';
import 'package:stackfood_multivendor/common/models/restaurant_model.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/custom_image_widget.dart';
import 'package:stackfood_multivendor/common/widgets/product_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerViewWidget extends StatelessWidget {
  const BannerViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder: (homeController) {
      return (homeController.bannerImageList != null && homeController.bannerImageList!.isEmpty) ? const
      SizedBox() : Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.85,
            height: GetPlatform.isDesktop ? 500 : 160,
            padding: const EdgeInsets.only(top: 30,),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff00737D),
                  Color(0xff0198A5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),
            child: homeController.bannerImageList != null ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Healthy or Expensive',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'Protect your family from the virus before it’s too late',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  fontWeight: FontWeight.w500
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Image.asset('assets/image/girl.png',width: 100,),
                  ],
                ),

                // CarouselSlider.builder(
                //   options: CarouselOptions(
                //     aspectRatio: 2.5,
                //     enlargeFactor: 0.3,
                //     autoPlay: true,
                //     enlargeCenterPage: true,
                //     disableCenter: true,
                //     autoPlayInterval: const Duration(seconds: 7),
                //     onPageChanged: (index, reason) {
                //       homeController.setCurrentIndex(index, true);
                //     },
                //   ),
                //   itemCount: homeController.bannerImageList!.isEmpty ? 1 : homeController.bannerImageList!.length,
                //   itemBuilder: (context, index, _) {
                //     String? baseUrl = homeController.bannerDataList![index] is BasicCampaignModel ? Get.find<SplashController>()
                //         .configModel!.baseUrls!.campaignImageUrl : Get.find<SplashController>().configModel!.baseUrls!.bannerImageUrl;
                //     return InkWell(
                //       onTap: () {
                //         if(homeController.bannerDataList![index] is Product) {
                //           Product? product = homeController.bannerDataList![index];
                //           ResponsiveHelper.isMobile(context) ? showModalBottomSheet(
                //             context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                //             builder: (con) => ProductBottomSheetWidget(product: product),
                //           ) : showDialog(context: context, builder: (con) => Dialog(
                //               child: ProductBottomSheetWidget(product: product)),
                //           );
                //         }else if(homeController.bannerDataList![index] is Restaurant) {
                //           Restaurant restaurant = homeController.bannerDataList![index];
                //           Get.toNamed(
                //             RouteHelper.getRestaurantRoute(restaurant.id),
                //             arguments: RestaurantScreen(restaurant: restaurant),
                //           );
                //         }else if(homeController.bannerDataList![index] is BasicCampaignModel) {
                //           BasicCampaignModel campaign = homeController.bannerDataList![index];
                //           Get.toNamed(RouteHelper.getBasicCampaignRoute(campaign));
                //         }
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           color: Theme.of(context).cardColor,
                //           borderRadius: BorderRadius.circular(30),
                //           boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 2, offset: const Offset(0, 1))],
                //         ),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                //           child: GetBuilder<SplashController>(builder: (splashController) {
                //             return CustomImageWidget(
                //               image: '$baseUrl/${homeController.bannerImageList![index]}',
                //               fit: BoxFit.cover,
                //             );
                //           },
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                //
                // const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: homeController.bannerImageList!.map((bnr) {
                //     int index = homeController.bannerImageList!.indexOf(bnr);
                //     int totalBanner = homeController.bannerImageList!.length;
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 3),
                //       child: index == homeController.currentIndex ? Container(
                //         decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                //         child: Text('${(index) + 1}/$totalBanner', style: robotoRegular.copyWith(color: Colors.white, fontSize: 12)),
                //       ) : Container(
                //         height: 4.18, width: 5.57,
                //         decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                //       ),
                //     );
                //   }).toList(),
                // ),
              ],
            ) : Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: Shimmer(
                  child: Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Theme.of(context).shadowColor,
                  )),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

}
