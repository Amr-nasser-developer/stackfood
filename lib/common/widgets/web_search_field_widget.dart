
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';

class WebSearchFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? suffixIcon;
  final Function iconPressed;
  final Color? filledColor;
  final Color? iconColor;
  final Function? onSubmit;
  final Function? onChanged;
  final Widget? prefixWidget;
  const WebSearchFieldWidget({super.key, required this.controller, required this.hint, required this.suffixIcon, required this.iconPressed, this.filledColor, this.onSubmit, this.onChanged, this.iconColor, this.prefixWidget});

  @override
  State<WebSearchFieldWidget> createState() => _WebSearchFieldWidgetState();
}

class _WebSearchFieldWidgetState extends State<WebSearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        )),
        filled: true, fillColor: widget.filledColor ?? Theme.of(context).cardColor,
        isDense: true,
        suffixIcon: widget.suffixIcon != null ? IconButton(
          onPressed: widget.iconPressed as void Function()?,
          icon: Icon(widget.suffixIcon, color: widget.iconColor ?? Theme.of(context).textTheme.bodyLarge!.color),
        ) : null,
        prefixIcon: widget.prefixWidget != null ? InkWell(
          onTap: widget.iconPressed as void Function()?,
          child: widget.prefixWidget,
        ): null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(.30),
          ),
        ),
      ),
      onSubmitted: widget.onSubmit as void Function(String)?,
      onChanged: widget.onChanged as void Function(String)?,
    );
  }
}
