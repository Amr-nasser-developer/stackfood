import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:stackfood_multivendor/common/widgets/custom_asset_image_widget.dart';
import 'package:stackfood_multivendor/common/widgets/custom_ink_well_widget.dart';
import 'package:stackfood_multivendor/common/widgets/rating_bar_widget.dart';
import 'package:stackfood_multivendor/features/cart/controllers/cart_controller.dart';
import 'package:stackfood_multivendor/features/language/controllers/localization_controller.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/cart/domain/models/cart_model.dart';
import 'package:stackfood_multivendor/common/models/product_model.dart';
import 'package:stackfood_multivendor/helper/cart_helper.dart';
import 'package:stackfood_multivendor/helper/price_converter.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/custom_image_widget.dart';
import 'package:stackfood_multivendor/common/widgets/product_bottom_sheet_widget.dart';
import 'package:stackfood_multivendor/common/widgets/quantity_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartProductWidget extends StatelessWidget {
  final CartModel cart;
  final int cartIndex;
  final List<AddOns> addOns;
  final bool isAvailable;
  final bool isRestaurantOpen;
  const CartProductWidget({super.key, required this.cart, required this.cartIndex, required this.isAvailable, required this.addOns, required this.isRestaurantOpen});

  @override
  Widget build(BuildContext context) {
    String addOnText = CartHelper.setupAddonsText(cart: cart) ?? '';
    String variationText = CartHelper.setupVariationText(cart: cart);

    double? discount = cart.product!.restaurantDiscount == 0 ? cart.product!.discount : cart.product!.restaurantDiscount;
    String? discountType = cart.product!.restaurantDiscount == 0 ? cart.product!.discountType : 'percent';

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault),
          child: GetBuilder<CartController>(
            builder: (cartController) {
              return Slidable(
                key: UniqueKey(),
                enabled: !cartController.isLoading,
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.2,
                  children: [
                    SlidableAction(
                      onPressed: (context) => cartController.removeFromCart(cartIndex),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(Get.find<LocalizationController>().isLtr ? Dimensions.radiusDefault : 0), left: Radius.circular(Get.find<LocalizationController>().isLtr ? 0 : Dimensions.radiusDefault)),
                      foregroundColor: Colors.white,
                      icon: CupertinoIcons.trash,
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    boxShadow: ResponsiveHelper.isDesktop(context) ? [] : [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, spreadRadius: 1)],
                  ),
                  child: CustomInkWellWidget(
                    onTap: (){
                      ResponsiveHelper.isMobile(context) ? showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (con) => ProductBottomSheetWidget(product: cart.product, cartIndex: cartIndex, cart: cart),
                      ).then((value) => Get.find<CartController>().getCartDataOnline(),
                      ) : showDialog(context: context, builder: (con) => Dialog(
                        child: ProductBottomSheetWidget(product: cart.product, cartIndex: cartIndex, cart: cart),
                      ));
                    },
                    radius: Dimensions.radiusDefault,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [

                          Row(children: [
                            cart.product!.image != null ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  child: CustomImageWidget(
                                    image: '${Get.find<SplashController>().configModel!.baseUrls!.productImageUrl}/${cart.product!.image}',
                                    height: 90, width: 90, fit: BoxFit.cover, isFood: true,
                                  ),
                                ),
                                isAvailable ? const SizedBox() : Positioned(
                                  top: 0, left: 0, bottom: 0, right: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Colors.black.withOpacity(0.6)),
                                    child: Text('not_available_now_break'.tr, textAlign: TextAlign.center, style: robotoRegular.copyWith(
                                      color: Colors.white, fontSize: 8,
                                    )),
                                  ),
                                ),
                              ],
                            ) : const SizedBox(),
                            SizedBox(width: cart.product!.image != null ? Dimensions.paddingSizeSmall : 0),

                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                Row(children: [
                                  Flexible(
                                    child: Text(
                                      cart.product!.name!,
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                                  CustomAssetImageWidget(
                                    cart.product!.veg == 0 ? Images.nonVegImage : Images.vegImage,
                                    height: 11, width: 11,
                                  ),

                                  SizedBox(width: cart.product!.isRestaurantHalalActive! && cart.product!.isHalalFood! ? Dimensions.paddingSizeExtraSmall : 0),

                                  cart.product!.isRestaurantHalalActive! && cart.product!.isHalalFood! ? const CustomAssetImageWidget(
                                   Images.halalIcon, height: 13, width: 13) : const SizedBox(),

                                ]),
                                const SizedBox(height: 2),

                                RatingBarWidget(rating: cart.product!.avgRating, size: 12, ratingCount: cart.product!.ratingCount),
                                const SizedBox(height: 5),

                                Wrap(
                                  children: [
                                    Text(
                                      PriceConverter.convertPrice(cart.product!.price, discount: discount, discountType: discountType),
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall), textDirection: TextDirection.ltr,
                                    ),
                                    SizedBox(width: discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),

                                    discount > 0 ? Text(
                                      PriceConverter.convertPrice(cart.product!.price), textDirection: TextDirection.ltr,
                                      style: robotoMedium.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall, decoration: TextDecoration.lineThrough),
                                    ) : const SizedBox(),
                                  ],
                                ),
                              ]),
                            ),

                            GetBuilder<CartController>(builder: (cartController) {
                              return Row(children: [

                                QuantityButton(
                                  onTap: cartController.isLoading ? () {} : () {
                                    if (cart.quantity! > 1) {
                                      cartController.setQuantity(false, cart);
                                    }else {
                                      cartController.removeFromCart(cartIndex);
                                    }
                                  },
                                  isIncrement: false,
                                  showRemoveIcon: cart.quantity! == 1,
                                ),

                                 AnimatedFlipCounter(
                                  duration: const Duration(milliseconds: 500),
                                  value: cart.quantity!.toDouble(),
                                  textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                                ),

                                QuantityButton(
                                  onTap: cartController.isLoading ? (){} : () => cartController.setQuantity(true, cart),
                                  isIncrement: true,
                                  color: cartController.isLoading ? Theme.of(context).disabledColor : null,
                                ),
                              ]);
                            }),

                          ]),

                          addOnText.isNotEmpty ? Padding(
                            padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                            child: Row(children: [
                              const SizedBox(width: 80),
                              Text('${'addons'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
                              Flexible(child: Text(
                                addOnText,
                                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                              )),
                            ]),
                          ) : const SizedBox(),

                          variationText.isNotEmpty ? Padding(
                            padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                            child: Row(children: [
                              const SizedBox(width: 80),
                              Text('${'variations'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
                              Flexible(child: Text(
                                variationText,
                                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                              )),
                            ]),
                          ) : const SizedBox(),

                          ResponsiveHelper.isDesktop(context) ? const Padding(
                            padding: EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                            child: Divider(),
                          ) : const SizedBox()

                        ],
                      ),
                    ),
                  )
                ),
              );
            }
          ),
        ),

        isRestaurantOpen ? const SizedBox() : Positioned(
          left: 0, right: 0, bottom: 0, top: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.radiusDefault),
              color: Theme.of(context).disabledColor.withOpacity(ResponsiveHelper.isDesktop(context) ? 0.1 : 0.3),
            ),
            margin: EdgeInsets.only(bottom: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.paddingSizeDefault),
          ),
        )
      ],
    );
  }
}

