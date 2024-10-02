// utils/custom_colors.dart
import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? highlightColor;

  CustomColors({this.highlightColor});

  @override
  CustomColors copyWith({Color? highlightColor}) {
    return CustomColors(
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t),
    );
  }
}
