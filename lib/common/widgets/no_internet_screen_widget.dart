import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stackfood_multivendor/common/widgets/custom_snackbar_widget.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget? child;
  const NoInternetScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.noInternet, width: 150, height: 150),
            Text('oops'.tr, style: robotoBold.copyWith(
              fontSize: 30,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            )),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              'no_internet_connection'.tr,
              textAlign: TextAlign.center,
              style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: 40),

            GestureDetector(
              onTap: () async {
                if(await Connectivity().checkConnectivity() != ConnectivityResult.none) {
                  Get.off(child);
                }else {
                  showCustomSnackBar('no_internet_connection'.tr, isError: true);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  child: Center(child: Icon(Icons.refresh, size: 34, color: Theme.of(context).cardColor)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
