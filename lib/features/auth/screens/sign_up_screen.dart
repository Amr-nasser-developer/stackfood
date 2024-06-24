import 'dart:developer';
import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stackfood_multivendor/features/auth/widgets/sign_up_widget.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  File? _image;

  Future<void> _pickImageGallery() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      setState(() {
        _image = File(pickedImage.path);
      });
      Navigator.pop(context);
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  Future<void> _pickImageCamera() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage == null) return;

      setState(() {
        _image = File(pickedImage.path);
      });
      Navigator.pop(context);
    } catch (e) {
      log("Error picking image: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: (){Navigator.pop(context);},
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Color(0xffEFF2F8),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.arrow_forward_sharp, color: Theme.of(context).textTheme.bodyLarge!.color)),
            ),
          ),
        ],
      ),
      backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).cardColor,
      body: SafeArea(child: Container(
        width: context.width > 700 ? 700 : context.width,
        padding: context.width > 700 ? const EdgeInsets.all(40) : const EdgeInsets.all(Dimensions.paddingSizeLarge),
        decoration: context.width > 700 ? BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ) : null,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            ResponsiveHelper.isDesktop(context) ? Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.clear),
              ),
            ) : const SizedBox(),
            Text('Create Account'.tr, style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 24.0
            ),),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: 120,
                    height: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffEFF2F8)),
                    child: _image == null
                        ? SvgPicture.asset(
                      'assets/image/assets.svg',
                      width: 38,
                      height: 38,
                      fit: BoxFit.scaleDown,
                    )
                        : Image.file(
                      _image!,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                              'Choose Source',
                              style: TextStyle(fontWeight:  FontWeight.w800),),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 30),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _pickImageGallery();
                                          },
                                          icon: const Icon(Icons.image)),
                                      Text('Gallery')
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _pickImageCamera();
                                          },
                                          icon: const Icon(
                                              Icons.camera_alt_sharp)),
                                      Text( 'Camera')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff0198A5),
                      ),
                      child:  Center(
                          child: SvgPicture.asset('assets/image/camera.svg')),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            const SignUpWidget(),

          ]),
        ),
      )),
    );
  }

}

