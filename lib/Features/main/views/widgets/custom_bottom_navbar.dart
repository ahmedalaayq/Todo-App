import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/assets_manager/assets_manager.dart';
import 'package:todo_app/core/theme/theme_manager.dart';
import 'package:todo_app/core/utils/app_size.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.onTransition,
    required this.currentIndex,
  });
  final Function(int index) onTransition;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(8),
      child: Theme(
        data: Theme.of(context),
        child: NavigationBar(
          animationDuration: Duration(milliseconds: 500),
          labelPadding: .symmetric(horizontal: 4, vertical: 4.0),
          labelBehavior: .onlyShowSelected,
          labelTextStyle: .resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: .bold,
                fontSize: AppSize.sp(12),
                height: 1.5,
                fontFamily: GoogleFonts.cairo().fontFamily,
              );
            }
            return Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: .w500,
              fontSize: AppSize.sp(12),
              height: 1.5,
              fontFamily: GoogleFonts.cairo().fontFamily,
            );
          }),
          indicatorColor: const Color(0xFF15B86C).withValues(alpha: 0.15),
          onDestinationSelected: (int index) => onTransition(index),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedIndex: currentIndex,
          height: AppSize.h(60),
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.imagesIconsHome,
                colorFilter: ColorFilter.mode(
                !ThemeManager.isDark ? Colors.black : Colors.white,
                  .srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                AssetsManager.imagesIconsHome,
                colorFilter: ColorFilter.mode(Color(0xFF15B86C), .srcIn),
              ),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.imagesIconsTodo,
                colorFilter: ColorFilter.mode(
                !ThemeManager.isDark ? Colors.black : Colors.white,
                  .srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                AssetsManager.imagesIconsTodo,
                colorFilter: ColorFilter.mode(Color(0xFF15B86C), .srcIn),
              ),
              label: 'المهمات',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.imagesIconsCompletedTasks,
                colorFilter: ColorFilter.mode(
                !ThemeManager.isDark ? Colors.black : Colors.white,
                  .srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                AssetsManager.imagesIconsCompletedTasks,
                colorFilter: ColorFilter.mode(Color(0xFF15B86C), .srcIn),
              ),
              label: 'المكتملة',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.imagesIconsProfile,
                colorFilter: ColorFilter.mode(
                  !ThemeManager.isDark ? Colors.black : Colors.white,
                  .srcIn,
                ),
              ),
              selectedIcon: SvgPicture.asset(
                AssetsManager.imagesIconsProfile,
                colorFilter: ColorFilter.mode(Color(0xFF15B86C), .srcIn),
              ),
              label: 'الملف',
            ),
          ],
        ),
      ),
    );
  }
}
