import 'package:flutter/cupertino.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final Function? onTap;
  final bool showRemoveIcon;
  final Color? color;
  const QuantityButton({super.key, required this.isIncrement, required this.onTap, this.showRemoveIcon = false, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        height: 22, width: 22,
        margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: showRemoveIcon ? Colors.transparent : isIncrement ? Theme.of(context).primaryColor : Theme.of(context).disabledColor),
          color: showRemoveIcon ? Theme.of(context).cardColor : isIncrement ? color ?? Theme.of(context).primaryColor : Theme.of(context).disabledColor.withOpacity(0.2),
        ),
        alignment: Alignment.center,
        child: Icon(
          showRemoveIcon ? CupertinoIcons.trash : isIncrement ? Icons.add : Icons.remove,
          size: 20,
          color: showRemoveIcon ? Theme.of(context).colorScheme.error : isIncrement ? Theme.of(context).cardColor : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}