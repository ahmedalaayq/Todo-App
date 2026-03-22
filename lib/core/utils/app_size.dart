import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  static double w(double width) => ScreenUtil().setWidth(width);
  static double h(double height) => ScreenUtil().setHeight(height);
  static double r(double radius) => ScreenUtil().radius(radius);
  static double dg(double size) => ScreenUtil().diagonal(size);
  static double dm(double size) => ScreenUtil().diameter(size);
  static double sp(double size) => ScreenUtil().setSp(size);
}



/*
original design FontSize.sp 

 */