import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stackfood_multivendor/common/widgets/menu_drawer_widget.dart';
import 'package:stackfood_multivendor/features/home/screens/our_edit/search_screen.dart';
import 'package:stackfood_multivendor/features/home/screens/our_edit/seller_profile.dart';
import 'package:stackfood_multivendor/features/home/screens/our_edit/seller_screen.dart';
import 'package:stackfood_multivendor/features/home/screens/our_edit/top_product.dart';
import 'package:stackfood_multivendor/features/home/widgets/cashback_dialog_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/cashback_logo_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/refer_bottom_sheet_widget.dart';
import 'package:stackfood_multivendor/features/product/controllers/campaign_controller.dart';
import 'package:stackfood_multivendor/features/home/controllers/home_controller.dart';
import 'package:stackfood_multivendor/features/home/screens/web_home_screen.dart';
import 'package:stackfood_multivendor/features/home/widgets/all_restaurant_filter_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/all_restaurants_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/bad_weather_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/banner_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/best_review_item_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/cuisine_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/enjoy_off_banner_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/location_banner_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/new_on_stackfood_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/order_again_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/popular_foods_nearby_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/popular_restaurants_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/refer_banner_view_widget.dart';
import 'package:stackfood_multivendor/features/home/screens/theme1_home_screen.dart';
import 'package:stackfood_multivendor/features/home/widgets/today_trends_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/what_on_your_mind_view_widget.dart';
import 'package:stackfood_multivendor/features/language/controllers/localization_controller.dart';
import 'package:stackfood_multivendor/features/order/controllers/order_controller.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/features/notification/controllers/notification_controller.dart';
import 'package:stackfood_multivendor/features/profile/controllers/profile_controller.dart';
import 'package:stackfood_multivendor/common/widgets/customizable_space_bar_widget.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/splash/domain/models/config_model.dart';
import 'package:stackfood_multivendor/features/address/controllers/address_controller.dart';
import 'package:stackfood_multivendor/features/auth/controllers/auth_controller.dart';
import 'package:stackfood_multivendor/features/category/controllers/category_controller.dart';
import 'package:stackfood_multivendor/features/cuisine/controllers/cuisine_controller.dart';
import 'package:stackfood_multivendor/features/location/controllers/location_controller.dart';
import 'package:stackfood_multivendor/features/product/controllers/product_controller.dart';
import 'package:stackfood_multivendor/features/review/controllers/review_controller.dart';
import 'package:stackfood_multivendor/helper/address_helper.dart';
import 'package:stackfood_multivendor/helper/auth_helper.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/footer_view_widget.dart';
import 'package:stackfood_multivendor/common/widgets/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  static Future<void> loadData(bool reload) async {
    Get.find<HomeController>().getBannerList(reload);
    Get.find<CategoryController>().getCategoryList(reload);
    Get.find<CuisineController>().getCuisineList();
    if(Get.find<SplashController>().configModel!.popularRestaurant == 1) {
      Get.find<RestaurantController>().getPopularRestaurantList(reload, 'all', false);
    }
    Get.find<CampaignController>().getItemCampaignList(reload);
    if(Get.find<SplashController>().configModel!.popularFood == 1) {
      Get.find<ProductController>().getPopularProductList(reload, 'all', false);
    }
    if(Get.find<SplashController>().configModel!.newRestaurant == 1) {
      Get.find<RestaurantController>().getLatestRestaurantList(reload, 'all', false);
    }
    if(Get.find<SplashController>().configModel!.mostReviewedFoods == 1) {
      Get.find<ReviewController>().getReviewedProductList(reload, 'all', false);
    }
    Get.find<RestaurantController>().getRestaurantList(1, reload);
    if(Get.find<AuthController>().isLoggedIn()) {
      await Get.find<ProfileController>().getUserInfo();
      Get.find<RestaurantController>().getRecentlyViewedRestaurantList(reload, 'all', false);
      Get.find<RestaurantController>().getOrderAgainRestaurantList(reload);
      Get.find<NotificationController>().getNotificationList(reload);
      Get.find<OrderController>().getRunningOrders(1, notify: false);
      Get.find<AddressController>().getAddressList();
      Get.find<HomeController>().getCashBackOfferList();
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController _scrollController = ScrollController();
  final ConfigModel? _configModel = Get.find<SplashController>().configModel;
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();

    _isLogin = Get.find<AuthController>().isLoggedIn();
    HomeScreen.loadData(false).then((value) {
      Get.find<SplashController>().getReferBottomSheetStatus();

      if((Get.find<ProfileController>().userInfoModel?.isValidForDiscount ?? false) && Get.find<SplashController>().showReferBottomSheet) {
        Future.delayed(const Duration(milliseconds: 500), () => _showReferBottomSheet());
      }

    });

    _scrollController.addListener(() {
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(Get.find<HomeController>().showFavButton){
          Get.find<HomeController>().changeFavVisibility();
          Future.delayed(const Duration(milliseconds: 800), ()=> Get.find<HomeController>().changeFavVisibility());
        }
      }else {
        if(Get.find<HomeController>().showFavButton){
          Get.find<HomeController>().changeFavVisibility();
          Future.delayed(const Duration(milliseconds: 800), ()=> Get.find<HomeController>().changeFavVisibility());
        }
      }
    });

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showReferBottomSheet() {
    ResponsiveHelper.isDesktop(context) ? Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
      insetPadding: const EdgeInsets.all(22),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: const ReferBottomSheetWidget(),
    ),
      useSafeArea: false,
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false)) :
    showModalBottomSheet(
      isScrollControlled: true, useRootNavigator: true, context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const ReferBottomSheetWidget(),
        );
      },
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false));
  }


  @override
  Widget build(BuildContext context) {

    double scrollPoint = 0.0;

    return GetBuilder<HomeController>(builder: (homeController) {
      return GetBuilder<LocalizationController>(builder: (localizationController) {
        return Scaffold(
          appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
          endDrawer: const MenuDrawerWidget(), endDrawerEnableOpenDragGesture: false,
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SafeArea(
            top: (Get.find<SplashController>().configModel!.theme == 2),
            child: RefreshIndicator(
              onRefresh: () async {
                await Get.find<HomeController>().getBannerList(true);
                await Get.find<CategoryController>().getCategoryList(true);
                await Get.find<CuisineController>().getCuisineList();
                await Get.find<RestaurantController>().getPopularRestaurantList(true, 'all', false);
                await Get.find<CampaignController>().getItemCampaignList(true);
                await Get.find<ProductController>().getPopularProductList(true, 'all', false);
                await Get.find<RestaurantController>().getLatestRestaurantList(true, 'all', false);
                await Get.find<ReviewController>().getReviewedProductList(true, 'all', false);
                await Get.find<RestaurantController>().getRestaurantList(1, true);
                if(Get.find<AuthController>().isLoggedIn()) {
                  await Get.find<ProfileController>().getUserInfo();
                  await Get.find<NotificationController>().getNotificationList(true);
                  await Get.find<RestaurantController>().getRecentlyViewedRestaurantList(true, 'all', false);
                  await Get.find<RestaurantController>().getOrderAgainRestaurantList(true);

                }
              },
              child: ResponsiveHelper.isDesktop(context) ? WebHomeScreen(
                scrollController: _scrollController,
              ) :
              // (Get.find<SplashController>().configModel!.theme == 2) ? Theme1HomeScreen(
              //   scrollController: _scrollController,
              // ) : CustomScrollView(
              //   controller: _scrollController,
              //   physics: const AlwaysScrollableScrollPhysics(),
              //   slivers: [
              //
              //     /// App Bar
              //     SliverAppBar(
              //       pinned: true, toolbarHeight: 16, expandedHeight: ResponsiveHelper.isTab(context) ? 72 : GetPlatform.isWeb ? 72 : 100,
              //       floating: false, elevation: 0, /*automaticallyImplyLeading: false,*/
              //       backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).primaryColor,
              //       flexibleSpace: FlexibleSpaceBar(
              //           titlePadding: EdgeInsets.zero,
              //           centerTitle: true,
              //           expandedTitleScale: 1,
              //           title: CustomizableSpaceBarWidget(
              //             builder: (context, scrollingRate) {
              //               scrollPoint = scrollingRate;
              //               return Center(child: Container(
              //                 width: Dimensions.webMaxWidth, color: Theme.of(context).primaryColor,
              //                 padding: const EdgeInsets.only(top: 30),
              //                 child: Opacity(
              //                   opacity: 1 - scrollPoint,
              //                   child: Row(children: [
              //
              //                     Expanded(child: Transform.translate(
              //                       offset: Offset(0, -(scrollingRate * 20)),
              //                       child: InkWell(
              //                         onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
              //                         child: Padding(
              //                           padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              //                           child: GetBuilder<LocationController>(builder: (locationController) {
              //                             return Row(
              //                               mainAxisAlignment: MainAxisAlignment.start,
              //                               children: [
              //                                 CircleAvatar(
              //                                   radius: 25,
              //                                   backgroundColor: Theme.of(context).primaryColor,
              //                                   backgroundImage: const NetworkImage('https://media.istockphoto.com/id/1327592506/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=1024x1024&w=is&k=20&c=er-yFBCv5wYO_curZ-MILgW0ECSjt0DDg5OlwpsAgZM='),
              //                                 ),
              //                                 SizedBox(width: 20,),
              //                                 Column(
              //                                     mainAxisSize: MainAxisSize.min,
              //                                     crossAxisAlignment: CrossAxisAlignment.start,
              //                                     children: [
              //
              //                                   if(scrollingRate < 0.2)
              //                                   Row(children: [
              //                                     Text(
              //                                        "${'hello'.tr} Mohamed Ahmed",
              //                                       style: robotoMedium.copyWith(
              //                                         color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeDefault /* - (scrollingRate * Dimensions.fontSizeDefault)*/,
              //                                       ),
              //                                       maxLines: 1, overflow: TextOverflow.ellipsis,
              //                                     ),
              //                                   ]),
              //                                   SizedBox(height: (scrollingRate < 0.15) ? 5 : 0),
              //
              //                                   if(scrollingRate < 0.8)
              //                                   Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
              //                                     children: [
              //
              //                                       Text(
              //                                         'Good Afternoon',
              //                                         style: TextStyle(
              //                                           color: Colors.white,
              //                                           fontSize: Dimensions.fontSizeSmall,
              //                                           fontWeight: FontWeight.w400
              //                                         ),
              //                                       )
              //                                     ],
              //                                   ),
              //                                 ]),
              //                               ],
              //                             );
              //                           }),
              //                         ),
              //                       ),
              //                     )),
              //
              //                     Transform.translate(
              //                       offset: Offset(0, -(scrollingRate * 10)),
              //                       child: InkWell(
              //                         child: GetBuilder<NotificationController>(builder: (notificationController) {
              //                           return Container(
              //                             decoration: BoxDecoration(
              //
              //                               borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              //                             ),
              //                             padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              //                             child: Stack(children: [
              //                               Transform.translate(
              //                                 offset: Offset(0, -(scrollingRate * 10)),
              //                                 child: Icon(Icons.notifications_outlined, size: 25, color: Colors.white),
              //                             ),
              //                               notificationController.hasNotification ? Positioned(top: 0, right: 0, child: Container(
              //                                 height: 10, width: 10, decoration: BoxDecoration(
              //                                 color: Theme.of(context).primaryColor, shape: BoxShape.circle,
              //                                 border: Border.all(width: 1, color: Theme.of(context).cardColor),
              //                               ),
              //                               )) : const SizedBox(),
              //                             ]),
              //                           );
              //                         }),
              //                         onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
              //                       ),
              //                     ),
              //
              //                     const SizedBox(width: Dimensions.paddingSizeSmall),
              //                   ]),
              //                 ),
              //               ));
              //             },
              //           )
              //       ),
              //       actions: const [SizedBox()],
              //     ),
              //
              //
              //
              //
              //
              //     SliverPersistentHeader(
              //       pinned: true,
              //       delegate: SliverDelegate(
              //         height: 85,
              //         child: const AllRestaurantFilterWidget(),
              //       ),
              //     ),
              //
              //
              //     SliverToBoxAdapter(child: Center(child: FooterViewWidget(
              //       child: Padding(
              //         padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : const EdgeInsets.only(bottom: Dimensions.paddingSizeOverLarge),
              //         child: AllRestaurantsWidget(scrollController: _scrollController),
              //       ),
              //     ))),
              //
              //   ],
              // )
              SingleChildScrollView(
                child: Column(
                  children:[
                    Container(
                      width: Dimensions.webMaxWidth, color: Theme.of(context).primaryColor,
                      height: 140,
                      padding: const EdgeInsets.only(top: 30),
                      child: Opacity(
                    opacity: 1 - scrollPoint,
                    child: Row(children: [

                      Expanded(child: InkWell(
                        onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: GetBuilder<LocationController>(builder: (locationController) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  backgroundImage: const NetworkImage('https://media.istockphoto.com/id/1327592506/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=1024x1024&w=is&k=20&c=er-yFBCv5wYO_curZ-MILgW0ECSjt0DDg5OlwpsAgZM='),
                                ),
                                const SizedBox(width: 20,),
                                Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                        Row(children: [
                                          Text(
                                            "${'hello'.tr} Mohamed Ahmed",
                                            style: robotoMedium.copyWith(
                                              color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeDefault /* - (scrollingRate * Dimensions.fontSizeDefault)*/,
                                            ),
                                            maxLines: 1, overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),

                                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Text(
                                              'Good Afternoon',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Dimensions.fontSizeSmall,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            )
                                          ],
                                        ),
                                    ]),
                              ],
                            );
                          }),
                        ),
                      )),

                      InkWell(
                        child: GetBuilder<NotificationController>(builder: (notificationController) {
                          return Container(
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            ),
                            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                            child: Stack(children: [
                              const Icon(Icons.notifications_outlined, size: 25, color: Colors.white),
                              notificationController.hasNotification ? Positioned(top: 0, right: 0, child: Container(
                                height: 10, width: 10, decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor, shape: BoxShape.circle,
                                border: Border.all(width: 1, color: Theme.of(context).cardColor),
                              ),
                              )) : const SizedBox(),
                            ]),
                          );
                        }),
                        onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
                      ),

                      const SizedBox(width: Dimensions.paddingSizeSmall),
                    ]),
                                          ),
                                        ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      ),
                      width: Dimensions.webMaxWidth,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        // const BannerViewWidget(),
                        Center(
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
                        ),
                        const SizedBox(height: 25,),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
                                },
                                child:Container(
                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Get.isDarkMode ? Colors.black : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(1, 1),
                                      color: Colors.grey[Get.isDarkMode ? 800 : 300]!, spreadRadius: 0, blurRadius: 2,
                                    )],
                                    border: Border.all(color: Colors.grey[Get.isDarkMode ? 800 : 300]!, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 15 ,),
                                      Icon(Icons.search, color: Get.isDarkMode ? Colors.white : Colors.grey[300],),
                                      const SizedBox(width: 10,),
                                      Text('Search here...'.tr, style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.grey[400]),),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){},
                                child:Container(
                                  width: MediaQuery.sizeOf(context).width * 0.15,
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Get.isDarkMode ? Colors.black : Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/image/filtter.svg',

                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const WhatOnYourMindViewWidget(),
                        const SizedBox(height: 25,),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.45,
                                height: 60,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode ? Colors.black : const Color(0xff0198A5).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.15,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xff0198A5).withOpacity(0.1)
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child:SvgPicture.asset('assets/image/bill.svg')
                                    ),
                                    const SizedBox(width: 5,),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.15,
                                      child: Text(
                                        'Drugs Distributor',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Get.isDarkMode ? Colors.white : const Color(0xff0198A5),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          '1,200+',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: Get.isDarkMode ? Colors.white : const Color(0xff000000).withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.45,
                                height: 60,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode ? Colors.black : const Color(0xff0198A5).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.15,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xff0198A5).withOpacity(0.1)
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child:SvgPicture.asset('assets/image/bill.svg')
                                    ),
                                    const SizedBox(width: 5,),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.15,
                                      child: Text(
                                        'Cosmetics Distributor',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Get.isDarkMode ? Colors.white : const Color(0xff0198A5),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          '1,200+',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: Get.isDarkMode ? Colors.white : const Color(0xff000000).withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const TodayTrendsViewWidget(),
                        const SizedBox(height: 25,),
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width * 0.85,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Theme.of(context).primaryColor, width: 0.5),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context).width * 0.3,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Limited Usage',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 10
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            SvgPicture.asset('assets/image/fir.svg', width: 40,),
                                            Center(
                                              child: Text(
                                                'Limited Usage',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 5,),
                                        VerticalDashedDivider(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context).width * 0.25,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '15% Off',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18
                                                  ),
                                                ),
                                                Text(
                                                  'Min. Spend \$20',
                                                  style: TextStyle(
                                                      color: Colors.black.withOpacity(0.7),
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12
                                                  ),
                                                ),
                                                Text(
                                                  'Valid Till 23 May 2024',
                                                  style: TextStyle(
                                                      color: Colors.black.withOpacity(0.7),
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 8
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 12.0,right: 8.0),
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: (){},

                                                  child: Text(
                                                    'Collect',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 10
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:(context,index){
                                return SizedBox(width: 10,);
                              } ,
                              itemCount: 5),
                        ),
                        // const LocationBannerViewWidget(),
                        const SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text('Top Products',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const TopProductScreen()));
                                },
                                child: Text('See all',
                                  style: TextStyle(
                                      color:Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 45,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: Text(
                                        'Best Offers',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:(context,index){
                                  return SizedBox(width: 10,);
                                } ,
                                itemCount: 5),
                          ),
                        ),
                        const SizedBox(height: 25,),
                        SizedBox(
                          height: 175,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width * 0.85,
                                    height: 175,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF4F8FD),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(
                                          color: Color(0xff000000).withOpacity(0.05),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: const Offset(1, 1)
                                      )]
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(

                                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Theme.of(context).primaryColor)
                                                ),
                                                child: Text(
                                                  'Buy 20 Get 2 Free',
                                                  style: TextStyle(
                                                      color:Theme.of(context).primaryColor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 8
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(color: Theme.of(context).primaryColor)
                                                ),
                                                child: Text(
                                                  'Buy 50 Get 6 Free',
                                                  style: TextStyle(
                                                      color:Theme.of(context).primaryColor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 8
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Container(
                                              width: 70,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '20% OFF',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(Icons.favorite,color: Color(0xffE5E9EE),size: 25,),
                                            SizedBox(width: 15,),

                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                          child: Text(
                                            'Panadol Extra Tablets (1 Strip = 10 Tablets)',
                                            style: TextStyle(
                                                color:Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              'From : ',
                                              style: TextStyle(
                                                  color:Color(0xff999999),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                            Text(
                                              'Haleon Glaxosmithkline',
                                              style: TextStyle(
                                                  color:Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              '\$120.99',
                                              style: TextStyle(
                                                  color:Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              '\$130',
                                              style: TextStyle(
                                                  color:Colors.black.withOpacity(0.7),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                decoration: TextDecoration.lineThrough,
                                              ),

                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 12.0,right: 8.0),
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: (){},

                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.add,color: Colors.white,size: 16,),
                                                      Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 10
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:(context,index){
                                return SizedBox(width: 10,);
                              } ,
                              itemCount: 5),
                        ),
                        const SizedBox(height: 25,),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 175,
                              decoration: BoxDecoration(
                                  color: Color(0xffF4F8FD),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(
                                      color: Color(0xff000000).withOpacity(0.05),
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: const Offset(1, 1)
                                  )]
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Image.asset( 'assets/image/tret.png',width: 90,),
                                  SizedBox(width: 5,),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 5,),
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(color: Theme.of(context).primaryColor)
                                                ),
                                                child: Text(
                                                  'Buy 50 Get 6 Free',
                                                  style: TextStyle(
                                                      color:Theme.of(context).primaryColor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 8
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(Icons.favorite,color: Color(0xffE5E9EE),size: 25,),
                                            SizedBox(width: 15,),

                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                          child: Text(
                                            'Panadol Extra Tablets (1 Strip = 10 Tablets)',
                                            style: TextStyle(
                                                color:Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              'From : ',
                                              style: TextStyle(
                                                  color:Color(0xff999999),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                            Text(
                                              'Haleon Glaxosmithkline',
                                              style: TextStyle(
                                                  color:Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              '\$120.99',
                                              style: TextStyle(
                                                  color:Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              '\$130',
                                              style: TextStyle(
                                                color:Colors.black.withOpacity(0.7),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                decoration: TextDecoration.lineThrough,
                                              ),

                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 12.0,right: 8.0),
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: (){},

                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.add,color: Colors.white,size: 16,),
                                                      Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 10
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text('Top Cosmetics',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SellerProfileScreen()));
                                },
                                child: Text('See all',
                                  style: TextStyle(
                                      color:Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(
                          height: 440,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    height: 430,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF4F8FD),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [BoxShadow(
                                            color: Color(0xff000000).withOpacity(0.05),
                                            spreadRadius: 0,
                                            blurRadius: 2,
                                            offset: const Offset(1, 1)
                                        )]
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset( 'assets/image/tret.png',width: MediaQuery.sizeOf(context).width * 0.9,height: 200,fit: BoxFit.fill,),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(

                                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(color: Theme.of(context).primaryColor)
                                                ),
                                                child: Text(
                                                  'Buy 20 Get 2 Free',
                                                  style: TextStyle(
                                                      color:Theme.of(context).primaryColor,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 8
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Container(
                                              width: 70,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '20% OFF',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                          child: Text(
                                            'Panadol Extra Tablets (1 Strip = 10 Tablets)',
                                            style: TextStyle(
                                                color:Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                          child: Text(
                                            'Volume 389ml/13.15 flaz',
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(0.7),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Icon(Icons.star,color: Colors.orange,size: 12,),
                                            Icon(Icons.star,color: Colors.orange,size: 12,),
                                            Icon(Icons.star,color: Colors.orange,size: 12,),
                                            Icon(Icons.star,color: Colors.orange,size: 12,),
                                            Icon(Icons.star,color: Colors.orange,size: 12,),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              'From : ',
                                              style: TextStyle(
                                                  color:Color(0xff999999),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                            Text(
                                              'Haleon Glaxosmithkline',
                                              style: TextStyle(
                                                  color:Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text(
                                              '\$120.99',
                                              style: TextStyle(
                                                  color:Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              '\$130',
                                              style: TextStyle(
                                                color:Colors.black.withOpacity(0.7),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                decoration: TextDecoration.lineThrough,
                                              ),

                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 12.0,right: 8.0),
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: (){},

                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.add,color: Colors.white,size: 16,),
                                                      Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 10
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:(context,index){
                                return SizedBox(width: 10,);
                              } ,
                              itemCount: 5),
                        ),
                        const SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text('Top Sellers',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SellerScreen()));
                                },
                                child: Text('See all',
                                  style: TextStyle(
                                      color:Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        ListView.separated(
                          shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder:(context,index){
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width * 0.9,
                                    height: 85,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF4F8FD),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [BoxShadow(
                                            color: Color(0xff000000).withOpacity(0.05),
                                            spreadRadius: 0,
                                            blurRadius: 2,
                                            offset: const Offset(1, 1)
                                        )]
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 10,),
                                        Image.asset( 'assets/image/seller.png',width: 70,),
                                        SizedBox(width: 5,),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10,),
                                              SizedBox(
                                                width: MediaQuery.sizeOf(context).width * 0.6,
                                                child: Text(
                                                  'Favliy Company. LTD',
                                                  style: TextStyle(
                                                      color:Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,color: Colors.orange,size: 12,),
                                                  Icon(Icons.star,color: Colors.orange,size: 12,),
                                                  Icon(Icons.star,color: Colors.orange,size: 12,),
                                                  Icon(Icons.star,color: Colors.orange,size: 12,),
                                                  Icon(Icons.star,color: Colors.orange,size: 12,),
                                                  SizedBox(width: 10,),
                                                  SvgPicture.asset('assets/image/mon.svg'),
                                                  Text(
                                                    'Minimum Order: 20',
                                                    style: TextStyle(
                                                        color:Color(0xff999999),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  SvgPicture.asset('assets/image/box.svg'),
                                                  SizedBox(width: 3,),
                                                  Text(
                                                    '1200 Products . ',
                                                    style: TextStyle(
                                                        color:Color(0xff999999),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  SvgPicture.asset('assets/image/time.svg'),
                                                  SizedBox(width: 3,),
                                                  Text(
                                                    '2 Days . ',
                                                    style: TextStyle(
                                                        color:Color(0xff999999),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  SvgPicture.asset('assets/image/checkk.svg'),
                                                  SizedBox(width: 3,),
                                                  Text(
                                                    'Credit',
                                                    style: TextStyle(
                                                        color:Color(0xff999999),
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } ,
                            separatorBuilder: (context,index){
                              return SizedBox(height: 10,);
                            },
                            itemCount: 5
                        ),
                        const SizedBox(height: 20,),
                        // _isLogin ? const OrderAgainViewWidget() : const SizedBox(),
                        //
                        // _configModel!.mostReviewedFoods == 1 ?  const BestReviewItemViewWidget(isPopular: false) : const SizedBox(),
                        //
                        // const CuisineViewWidget(),
                        //
                        // _configModel.popularRestaurant == 1 ? const PopularRestaurantsViewWidget() : const SizedBox(),
                        //
                        // const ReferBannerViewWidget(),
                        //
                        // _isLogin ? const PopularRestaurantsViewWidget(isRecentlyViewed: true) : const SizedBox(),
                        //
                        // _configModel.popularFood == 1 ? const PopularFoodNearbyViewWidget() : const SizedBox(),
                        //
                        // _configModel.newRestaurant == 1 ? const NewOnStackFoodViewWidget(isLatest: true) : const SizedBox(),
                        //
                        // const PromotionalBannerViewWidget(),

                      ]),
                    ),

                  ]
                ),
              ),
            ),
          ),

          floatingActionButton: AuthHelper.isLoggedIn() && homeController.cashBackOfferList != null && homeController.cashBackOfferList!.isNotEmpty ?
          homeController.showFavButton ? Padding(
            padding: EdgeInsets.only(bottom: ResponsiveHelper.isDesktop(context) ? 50 : 0, right: ResponsiveHelper.isDesktop(context) ? 20 : 0),
            child: InkWell(
              onTap: () => Get.dialog(const CashBackDialogWidget()),
              child: const CashBackLogoWidget(),
            ),
          ) : null : null,

        );
      });
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;

  SliverDelegate({required this.child, this.height = 50});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
class VerticalDashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashHeight;
  final double dashWidth;
  final double spacing;

  VerticalDashedDivider({
    this.height = 200,
    this.color = const Color(0xff0198A5),
    this.dashHeight = 4,
    this.dashWidth = 1,
    this.spacing = 5,
  });

  @override
  Widget build(BuildContext context) {
    int numDashes = (height / (dashHeight + spacing)).floor();
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(numDashes, (index) {
          return SizedBox(
            width: dashWidth,
            height: dashHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          );
        }),
      ),
    );
  }
}