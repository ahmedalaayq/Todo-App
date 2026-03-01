import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AchievedTasksItem extends StatelessWidget {
  const AchievedTasksItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: .all(12),
            decoration: BoxDecoration(
              borderRadius: .circular(20.r),
              color: Color(0xFF282828),
            ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Achieved Tasks',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 16.sp),
                ),
                Text(
                  '3 Out of 6 Done',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(
                        fontSize: 14.sp,
                        color: Color(0xFFC6C6C6),
                      ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 52,
                width: 52,
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: CircularProgressIndicator(
                    value: 0.5,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey.shade700,
                    valueColor: AlwaysStoppedAnimation(Color(0xFF15B86C)),
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  '50%',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
