import 'package:flutter/material.dart';
import '../responsive/responsive_config.dart';

extension ResponsivePadding on num {
  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: this * ResponsiveConfig.widthRatio);

  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: this * ResponsiveConfig.heightRatio);

  EdgeInsets get allPadding => EdgeInsets.fromLTRB(
    this * ResponsiveConfig.widthRatio,
    this * ResponsiveConfig.heightRatio,
    this * ResponsiveConfig.widthRatio,
    this * ResponsiveConfig.heightRatio,
  );
}