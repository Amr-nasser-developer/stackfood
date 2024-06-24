import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/common/widgets/custom_asset_image_widget.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/code_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String titleText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixImage;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double prefixSize;
  final TextAlign textAlign;
  final bool isAmount;
  final bool isNumber;
  final bool showTitle;
  final bool showBorder;
  final double iconSize;
  final bool divider;
  final bool isPhone;
  final String? countryDialCode;
  final Function(CountryCode countryCode)? onCountryChanged;
  final bool isRequired;
  final bool showLabelText;
  final bool required;
  final String? labelText;
  final String? Function(String?)? validator;
  final double? levelTextSize;
  final bool fromUpdateProfile;
  final Widget? suffixChild;

  const CustomTextFieldWidget({
    super.key,
    this.titleText = 'Write something...',
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSubmit,
    this.onChanged,
    this.prefixImage,
    this.prefixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.prefixSize = Dimensions.paddingSizeSmall,
    this.textAlign = TextAlign.start,
    this.isAmount = false,
    this.isNumber = false,
    this.showTitle = false,
    this.showBorder = true,
    this.iconSize = 18,
    this.divider = false,
    this.isPhone = false,
    this.countryDialCode,
    this.onCountryChanged,
    this.isRequired = false,
    this.showLabelText = true,
    this.required = false,
    this.labelText,
    this.validator,
    this.suffixIcon,
    this.levelTextSize,
    this.fromUpdateProfile = false,
    this.suffixChild,
  });

  @override
  CustomTextFieldWidgetState createState() => CustomTextFieldWidgetState();
}

class CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: Colors.black
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.showTitle ? Text(widget.titleText, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)) : const SizedBox(),
          SizedBox(height: widget.showTitle ? ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeExtraSmall : 0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              color: Colors.black
            ),
            child: TextFormField(
              maxLines: widget.maxLines,
              controller: widget.controller,
              focusNode: widget.focusNode,
              textAlign: widget.textAlign,
              validator: widget.validator,
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black),
              textInputAction: widget.inputAction,
              keyboardType: widget.isAmount ? TextInputType.number : widget.inputType,
              cursorColor: Theme.of(context).primaryColor,
              textCapitalization: widget.capitalization,
              enabled: widget.isEnabled,
              autofocus: false,
              obscureText: widget.isPassword ? _obscureText : false,
              inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
                  : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))] : widget.isNumber ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))] : null,
              decoration: InputDecoration(
               border: UnderlineInputBorder(borderSide: BorderSide.none),
                isDense: true,
                hintText: widget.hintText.isEmpty ? widget.titleText : widget.hintText,
                fillColor:Color(0xffEFF2F8),
                hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).hintColor),
                filled: true,
                labelStyle : widget.showLabelText ? robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).hintColor):null,
                errorStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                label: widget.showLabelText ? Text.rich(TextSpan(children: [
                  TextSpan(text: widget.labelText ?? '', style: robotoRegular.copyWith(fontSize: widget.levelTextSize ?? Dimensions.fontSizeLarge, color: Theme.of(context).hintColor.withOpacity(.75))),
                  if(widget.required && widget.labelText != null)
                    TextSpan(text : ' *', style: robotoRegular.copyWith(color: Theme.of(context).colorScheme.error, fontSize: Dimensions.fontSizeLarge)),
                  if(widget.isEnabled == false)
                    TextSpan(text: widget.fromUpdateProfile ? ' (${'phone_number_can_not_be_edited'.tr})' : ' (${'non_changeable'.tr})', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).colorScheme.error)),
                ])) : null,
                prefixIcon:  widget.isPhone ? SizedBox(width: 95, child: Row(children: [
                  Container(
                      width: 85,height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radiusSmall),
                          bottomLeft: Radius.circular(Dimensions.radiusSmall),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 0),
                      padding: const EdgeInsets.only(left: 5 , right: 5),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              generateCountryFlag() + ' +996',
                              style: TextStyle(fontSize: 14, letterSpacing: 2.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ),
                  ),

                  Container(
                    height: 20, width: 2,
                    color: Theme.of(context).disabledColor,
                  )
                ]),
                ) : widget.prefixImage != null && widget.prefixIcon == null ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.prefixSize),
                  child: CustomAssetImageWidget(widget.prefixImage!, height: 25, width: 25, fit: BoxFit.scaleDown),
                ) : widget.prefixImage == null && widget.prefixIcon != null ? Icon(widget.prefixIcon, size: widget.iconSize, color: Theme.of(context).hintColor.withOpacity(0.3)) : null,
                suffixIcon: widget.isPassword ? IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
                  onPressed: _toggle,
                ) : widget.suffixChild,
              ),
              onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
                  : widget.onSubmit != null ? widget.onSubmit!(text) : null,
              onChanged: widget.onChanged as void Function(String)?,
            ),
          ),
          widget.divider ? const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge), child: Divider()) : const SizedBox(),

        ],
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  String generateCountryFlag() {
    String countryCode = 'sa';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }
}

