import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
class HomeToolBar extends StatelessWidget {
  const HomeToolBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                AssetsManager.imagesTopImage,
                width: 42.w,
                height: 42.h,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${setGreetingMessage12Hour()}, Ahmed',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      overflow: .ellipsis,
                      maxLines: 1,
                      'One task at a time. One step closer.',
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Material(
          child: InkWell(
            overlayColor: .all(Color(0xFF282828)),
            splashColor: Color(0xFF282828),
            borderRadius: .circular(50),
            onTap: () {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: .all(8),
              decoration: BoxDecoration(
                color: Color(0xFF282828),
                shape: .circle,
              ),
              child: SvgPicture.asset(AssetsManager.imagesSun),
            ),
          ),
        ),
      ],
    );
  }
}

String setGreetingMessage12Hour() {
  int hour = DateTime.now().hour;
  bool isAM = hour < 12;

  int hour12 = hour % 12;
  if (hour12 == 0) hour12 = 12;

  if (isAM) {
    return 'Good Morning';
  } else if (hour12 < 5) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
