import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacings {
  static final EdgeInsets s10Top = EdgeInsets.only(top: 10.h);
  static final EdgeInsets s5Bottom = EdgeInsets.only(bottom: 5.h);
  static final EdgeInsets s10Bottom = EdgeInsets.only(bottom: 10.h);
  static final EdgeInsets s20Bottom = EdgeInsets.only(bottom: 20.h);
  static final EdgeInsets s50Bottom = EdgeInsets.only(bottom: 50.h);
  static const EdgeInsets s5All = EdgeInsets.all(5);
  static const EdgeInsets s10All = EdgeInsets.all(10);
  static const EdgeInsets s15All = EdgeInsets.all(15);
  static const EdgeInsets s20All = EdgeInsets.all(20);
  static const EdgeInsets s5Vertical = EdgeInsets.symmetric(vertical: 5);
  static const EdgeInsets s10Vertical = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets s20Vertical = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets s10Horizental = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets s20Horizental = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets s20Horizental10Vertical = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,
  );
  static const EdgeInsets s10Horizental5Vertical =
      EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  static final EdgeInsets s10Top20Bot =
      EdgeInsets.only(top: 10.r, bottom: 20.r);
  static final EdgeInsets s20Top10Right10Left =
      EdgeInsets.only(top: 20.r, right: 10.r, left: 10.r);
  static final EdgeInsets s10r = EdgeInsets.only(right: 10.r);
}

class AppSize {
  static const double s01 = 1;
  static const double s08 = 8;
  static const double s32 = 32;
  static const double s16 = 16;
  static const double s30 = 30;
  static const double s40 = 40;
}
