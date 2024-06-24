import 'package:stackfood_multivendor/features/auth/controllers/auth_controller.dart';
import 'package:stackfood_multivendor/features/cart/controllers/cart_controller.dart';
import 'package:stackfood_multivendor/features/home/widgets/cuisine_card_widget.dart';
import 'package:stackfood_multivendor/features/search/controllers/search_controller.dart' as search;
import 'package:stackfood_multivendor/features/search/widgets/filter_widget.dart';
import 'package:stackfood_multivendor/features/search/widgets/search_result_widget.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/cuisine/controllers/cuisine_controller.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/bottom_cart_widget.dart';
import 'package:stackfood_multivendor/common/widgets/custom_snackbar_widget.dart';
import 'package:stackfood_multivendor/common/widgets/footer_view_widget.dart';
import 'package:stackfood_multivendor/common/widgets/menu_drawer_widget.dart';
import 'package:stackfood_multivendor/common/widgets/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();

  late bool _isLoggedIn;
  final SearchController anchorController = SearchController();

  String? _searchingWithQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    Get.find<search.SearchController>().setSearchMode(true, canUpdate: false);
    if(_isLoggedIn) {
      Get.find<search.SearchController>().getSuggestedFoods();
    }
    Get.find<CuisineController>().getCuisineList();
    Get.find<search.SearchController>().getHistoryList();
  }

  Future<Iterable<String>> _search(String query) async {
    List<String> foodsAndRestaurants = <String>[];
    if (query == '') {
      return const Iterable<String>.empty();
    } else {
      foodsAndRestaurants = await Get.find<search.SearchController>().getSearchSuggestions(query);
    }
    return foodsAndRestaurants;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        if(!Get.find<search.SearchController>().isSearchMode) {
          Get.find<search.SearchController>().setSearchMode(true);
          anchorController.text = '';
        } else if(anchorController.text.isNotEmpty) {
          anchorController.text = '';
          setState(() {});
        } else {
          Future.delayed(const Duration(milliseconds: 100), () => Get.back());
        }
      },
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
        endDrawer: const MenuDrawerWidget(), endDrawerEnableOpenDragGesture: false,
        body: SafeArea(child: GetBuilder<search.SearchController>(builder: (searchController) {
          return Column(children: [

            Container(
              height: ResponsiveHelper.isDesktop(context) ? 130 : 80,
              color: ResponsiveHelper.isDesktop(context) ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ResponsiveHelper.isDesktop(context) ? Text('search_food_and_restaurant'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)) : const SizedBox(),

                  SizedBox(width: Dimensions.webMaxWidth, child: Row(children: [
                    SizedBox(width: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeExtraSmall),

                    Expanded(
                      child: SearchAnchor(
                        viewSurfaceTintColor: Theme.of(context).cardColor,
                        viewHintText: 'search_food_or_restaurant'.tr,
                        headerHintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor),
                        textInputAction: TextInputAction.done,
                        viewLeading: IconButton(onPressed: () => anchorController.closeView(anchorController.text), icon: const Icon(Icons.arrow_back)),
                        viewTrailing: [
                          IconButton(
                            onPressed: () {
                              if(anchorController.text.isNotEmpty) {
                                anchorController.text = '';
                              } else {
                                anchorController.closeView('');
                              }
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ],
                        viewOnSubmitted: (searchText) {
                          anchorController.closeView(searchText);
                          _actionSearch(searchController, true);
                          if(!searchController.isSearchMode && anchorController.text.isEmpty) {
                            searchController.setSearchMode(true);
                          }
                        },
                        searchController: anchorController,
                        builder: (BuildContext context, SearchController controller) {
                          return Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Theme.of(context).primaryColor, width: 0.3),
                            ),
                            child: Row(children: [

                              !ResponsiveHelper.isDesktop(context) ? IconButton(
                                onPressed: () {
                                  if(!searchController.isSearchMode) {
                                    searchController.setSearchMode(true);
                                    controller.text = '';
                                  } else if(controller.text.isNotEmpty) {
                                    controller.text = '';
                                    setState(() {});
                                  } else {
                                    Get.back();
                                  }
                                },
                                icon: const Icon(Icons.arrow_back),
                              ) : const SizedBox(width: 50),

                              Expanded(
                                child: Text(
                                  controller.text.isEmpty ? 'search_food_or_restaurant'.tr : controller.text,
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: robotoRegular.copyWith(color: controller.text.isEmpty ? Theme.of(context).disabledColor : Theme.of(context).textTheme.bodyMedium!.color),
                                ),
                              ),

                              IconButton(
                                onPressed: (){
                                  _actionSearch(searchController, false);
                                },
                                icon: Icon(!searchController.isSearchMode ? Icons.filter_list : Icons.search, size: 28,),
                              )

                            ]),
                          );
                        },
                        suggestionsBuilder: (BuildContext context, SearchController controller) async {
                          _searchingWithQuery = controller.text;
                          final List<String> options = (await _search(_searchingWithQuery!)).toList();
                          if (_searchingWithQuery != controller.text) {
                            return _lastOptions;
                          }
                          _lastOptions = List<ListTile>.generate(options.length, (int index) {
                            final String item = options[index];
                            return ListTile(
                              leading: Icon(Icons.search, color: Theme.of(context).disabledColor),
                              title: Text(item),
                              trailing: Icon(Icons.north_west, color: Theme.of(context).disabledColor),
                              onTap: () async {
                                controller.closeView(item);
                                _actionSearch(searchController, true);
                              },
                            );
                          });

                          return _lastOptions;
                        },
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : 0),
                  ])),
                ],
              )),
            ),

            Expanded(child: searchController.isSearchMode ? SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: FooterViewWidget(
                child: SizedBox(width: Dimensions.webMaxWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  searchController.historyList.isNotEmpty ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('recent_search'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),

                    InkWell(
                      onTap: () => searchController.clearSearchAddress(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: 4),
                        child: Text('clear_all'.tr, style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.error,
                        )),
                      ),
                    ),
                  ]) : const SizedBox(),

                  SizedBox(height: searchController.historyList.isNotEmpty ? Dimensions.paddingSizeExtraSmall : 0),
                  Wrap(
                    children: searchController.historyList.map((historyData) {
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            border: Border.all(color: Theme.of(context).disabledColor.withOpacity(0.6)),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            InkWell(
                              onTap: () {
                                anchorController.text = historyData;
                                searchController.searchData(historyData);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                child: Text(
                                  historyData,
                                  style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),

                            InkWell(
                              onTap: () => searchController.removeHistory(searchController.historyList.indexOf(historyData)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                child: Icon(Icons.close, color: Theme.of(context).disabledColor, size: 20),
                              ),
                            )
                          ]),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: searchController.historyList.isNotEmpty && _isLoggedIn && searchController.suggestedFoodList != null ? Dimensions.paddingSizeLarge : 0),

                  (_isLoggedIn && searchController.suggestedFoodList != null) ? Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                    child: Text(
                      'recommended'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    ),
                  ) : const SizedBox(),

                  (_isLoggedIn && searchController.suggestedFoodList != null) ? searchController.suggestedFoodList!.isNotEmpty ?  Wrap(
                    children: searchController.suggestedFoodList!.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall),
                        child: InkWell(
                          onTap: () {
                            anchorController.text = product.name!;
                            searchController.searchData(product.name!);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              border: Border.all(color: Theme.of(context).disabledColor.withOpacity(0.6)),
                            ),
                            child: Text(
                              product.name!,
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ) : Padding(padding: const EdgeInsets.only(top: 10), child: Text('no_suggestions_available'.tr)) : const SizedBox(),



                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  GetBuilder<CuisineController>(builder: (cuisineController) {
                    return (cuisineController.cuisineModel != null && cuisineController.cuisineModel!.cuisines!.isEmpty) ? const SizedBox() : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (cuisineController.cuisineModel != null) ? Text(
                          'cuisines'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                        ) : const SizedBox(),
                        const SizedBox(height: Dimensions.paddingSizeDefault),


                        (cuisineController.cuisineModel != null) ? cuisineController.cuisineModel!.cuisines!.isNotEmpty ? GetBuilder<CuisineController>(builder: (cuisineController) {
                          return cuisineController.cuisineModel != null ? GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? 35 : 15,
                              childAspectRatio: ResponsiveHelper.isDesktop(context) ? 1 : 1,
                            ),
                            shrinkWrap: true,
                            itemCount: cuisineController.cuisineModel!.cuisines!.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(RouteHelper.getCuisineRestaurantRoute(cuisineController.cuisineModel!.cuisines![index].id, cuisineController.cuisineModel!.cuisines![index].name));
                                },
                                child: SizedBox(
                                  height: 130,
                                  child: CuisineCardWidget(
                                    image: '${Get.find<SplashController>().configModel!.baseUrls!.cuisineImageUrl}/${cuisineController.cuisineModel!.cuisines![index].image}',
                                    name: cuisineController.cuisineModel!.cuisines![index].name!,
                                    fromSearchPage: true,
                                  ),
                                ),
                              );
                            }) : const Center(child: CircularProgressIndicator());
                        }) : Padding(padding: const EdgeInsets.only(top: 10), child: Text('no_suggestions_available'.tr)) : const SizedBox(),
                      ],
                    );
                  }),

                ])),
              ),
            ) : SearchResultWidget(searchText: anchorController.text.trim())),




          ]);
        })),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
          return cartController.cartList.isNotEmpty && !ResponsiveHelper.isDesktop(context) ? const BottomCartWidget() : const SizedBox();
        }),
      ),
    );
  }

  void _actionSearch(search.SearchController searchController, bool isSubmit) {
    if(searchController.isSearchMode || isSubmit) {
      if(anchorController.text.trim().isNotEmpty) {
        searchController.searchData(anchorController.text.trim());
      }else {
        showCustomSnackBar('search_food_or_restaurant'.tr);
      }
    }else {
      List<double?> prices = [];
      if(!searchController.isRestaurant) {
        for (var product in searchController.allProductList!) {
          prices.add(product.price);
        }
        prices.sort();
      }
      double? maxValue = prices.isNotEmpty ? prices[prices.length-1] : 1000;
      ResponsiveHelper.isMobile(context) ? Get.bottomSheet(FilterWidget(maxValue: maxValue, isRestaurant: searchController.isRestaurant), isScrollControlled: true)
      : Get.dialog(Dialog(
        insetPadding: const EdgeInsets.all(30),
        child: FilterWidget(maxValue: maxValue, isRestaurant: searchController.isRestaurant),
      ));
    }
  }
}
