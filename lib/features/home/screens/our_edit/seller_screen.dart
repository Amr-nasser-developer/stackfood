import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/features/home/screens/our_edit/search_screen.dart';
import 'package:stackfood_multivendor/features/location/controllers/location_controller.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';

class SellerScreen extends StatelessWidget {
  const SellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double scrollPoint = 0.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children:[
              Container(
                width: Dimensions.webMaxWidth,

                height: 120,
                padding: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                ),
                child: Opacity(
                  opacity: 1 - scrollPoint,
                  child: Row(children: [

                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: GetBuilder<LocationController>(builder: (locationController) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20,),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                                child: Align(
                                    alignment: Alignment.centerLeft, child: InkWell(onTap:(){
                                      Navigator.pop(context);
                                },child: const Icon(Icons.arrow_back,color: Colors.white, size: 20,)))),
                            Center(
                              child: Text(
                                "Seller",
                                style: robotoMedium.copyWith(
                                  color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeDefault /* - (scrollingRate * Dimensions.fontSizeDefault)*/,
                                ),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }),
                    )),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Text('Recommended For You',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),
                        ),
                        const Spacer(),
                        Text('See all',
                          style: TextStyle(
                              color:Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
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
                                  color: const Color(0xffF4F8FD),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [BoxShadow(
                                      color: const Color(0xff000000).withOpacity(0.05),
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
                                  const SizedBox(height: 10,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(

                                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
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
                                      const SizedBox(width: 5,),
                                      Container(
                                        width: 70,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrange,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Center(
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
                                  const SizedBox(height: 10,),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    child: const Text(
                                      'Panadol Extra Tablets (1 Strip = 10 Tablets)',
                                      style: TextStyle(
                                          color:Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
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
                                  const SizedBox(height: 10,),
                                  const Row(
                                    children: [
                                      Icon(Icons.star,color: Colors.orange,size: 12,),
                                      Icon(Icons.star,color: Colors.orange,size: 12,),
                                      Icon(Icons.star,color: Colors.orange,size: 12,),
                                      Icon(Icons.star,color: Colors.orange,size: 12,),
                                      Icon(Icons.star,color: Colors.orange,size: 12,),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const Text(
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
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const Text(
                                        '\$120.99',
                                        style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                      ),
                                      const SizedBox(width: 5,),
                                      Text(
                                        '\$130',
                                        style: TextStyle(
                                          color:Colors.black.withOpacity(0.7),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          decoration: TextDecoration.lineThrough,
                                        ),

                                      ),
                                      const Spacer(),
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

                                            child: const Row(
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
                          return const SizedBox(width: 10,);
                        } ,
                        itemCount: 5),
                  ),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Text('Sellers',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),
                        ),
                        const Spacer(),
                        Text('See all',
                          style: TextStyle(
                              color:Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12
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
                                  color: const Color(0xffF4F8FD),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(
                                      color: const Color(0xff000000).withOpacity(0.05),
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: const Offset(1, 1)
                                  )]
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10,),
                                  Image.asset( 'assets/image/seller.png',width: 70,),
                                  const SizedBox(width: 5,),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                          width: MediaQuery.sizeOf(context).width * 0.6,
                                          child: const Text(
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
                                            const Icon(Icons.star,color: Colors.orange,size: 12,),
                                            const Icon(Icons.star,color: Colors.orange,size: 12,),
                                            const Icon(Icons.star,color: Colors.orange,size: 12,),
                                            const Icon(Icons.star,color: Colors.orange,size: 12,),
                                            const Icon(Icons.star,color: Colors.orange,size: 12,),
                                            const SizedBox(width: 10,),
                                            SvgPicture.asset('assets/image/mon.svg'),
                                            const Text(
                                              'Minimum Order: 20',
                                              style: TextStyle(
                                                  color:Color(0xff999999),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/image/box.svg'),
                                            const SizedBox(width: 3,),
                                            const Text(
                                              '1200 Products . ',
                                              style: TextStyle(
                                                  color:Color(0xff999999),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                            SvgPicture.asset('assets/image/time.svg'),
                                            const SizedBox(width: 3,),
                                            const Text(
                                              '2 Days . ',
                                              style: TextStyle(
                                                  color:Color(0xff999999),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12
                                              ),
                                            ),
                                            SvgPicture.asset('assets/image/checkk.svg'),
                                            const SizedBox(width: 3,),
                                            const Text(
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
                        return const SizedBox(height: 10,);
                      },
                      itemCount: 5
                  ),
                  const SizedBox(height: 20,),

                ]),
              ),

            ]
        ),
      ),
    );
  }
}
