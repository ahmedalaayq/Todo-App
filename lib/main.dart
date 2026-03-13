import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/router/app_routes.dart';
import 'package:todo_app/core/router/on_generate_route.dart';
import 'package:todo_app/generated/l10n.dart';

import 'Features/home/models/task.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final welcomeSeen = prefs.getBool('welcome') ?? false;
  runApp(MyApp(welcomeSeen: welcomeSeen));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.welcomeSeen});
  final bool welcomeSeen;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 809),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      builder: (context, widget) {
        return MaterialApp(
          locale: Locale('ar'),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: ThemeData(
            useMaterial3: true,
            switchTheme: SwitchThemeData(
              trackColor: .resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF15B86C);
                }
                return const Color(0xFFCDCDCD);
              }),
              thumbColor: .resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFFFFFFFF);
                }
                return Colors.grey;
              }),
              trackOutlineColor: .resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF15B86C).withValues(alpha: 0.15);
                }
                return Colors.white;
              }),
              trackOutlineWidth: .resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return 18.w;
                }
                return 2.w;
              }),
              thumbIcon: .resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.grey.shade600,
                  );
                }
                return Icon(Icons.light_mode_outlined);
              }),
            ),
            fontFamily: GoogleFonts.cairo().fontFamily,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            brightness: .dark,
          ),
          onGenerateRoute: onGenerateRoute,
          initialRoute: welcomeSeen
              ? AppRoutes.splashView
              : AppRoutes.welcomeView,
        );
      },
    );
  }
}

Future<void> setTestAppTasks({required SharedPreferences prefs}) async {
  List<Task> exampleTasks = [
    Task(
      taskName: "مراجعة كود المشروع",
      taskDescription: "التأكد من جودة الكود وتطبيق أفضل الممارسات",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "كتابة Unit Tests",
      taskDescription: "اختبار الوحدات المهمة في التطبيق",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحديث dependencies",
      taskDescription: "تحديث مكتبات Flutter و Dart لأحدث الإصدارات",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "تحسين الأداء",
      taskDescription: "تقليل زمن استجابة التطبيق وتحسين الـ FPS",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تطوير واجهة مستخدم جديدة",
      taskDescription: "تصميم شاشة Dashboard جديدة بتفاعلات سلسة",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "حل Bugs المفتوحة",
      taskDescription: "معالجة مشاكل الـ UI والـ Logic في المشروع",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "مراجعة Pull Requests",
      taskDescription: "التأكد من جودة التعديلات قبل الدمج",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحسين الـ Animations",
      taskDescription: "جعل حركة الـ Widgets سلسة وسريعة",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "إعداد CI/CD",
      taskDescription: "ربط المشروع مع GitHub Actions للنشر التلقائي",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحديث مستندات المشروع",
      taskDescription: "إضافة شرح للمكتبات والميزات الجديدة",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "تصميم أيقونات جديدة",
      taskDescription: "إنشاء أيقونات مخصصة للشاشة الرئيسية",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "إصلاح مشاكل الـ Layout",
      taskDescription: "معالجة مشاكل الـ Overflow والـ Alignment",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "إضافة ميزة Dark Mode",
      taskDescription: "تمكين المستخدمين من التبديل بين الوضع الليلي والفاتح",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحسين الـ Network Requests",
      taskDescription: "تقليل حجم البيانات وتسريع الاستجابة",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "مراجعة تصميم الشاشة الرئيسية",
      taskDescription: "ضمان تناسق الألوان والخطوط والـ Spacing",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "إصلاح مشاكل الـ State Management",
      taskDescription: "معالجة مشاكل تحديث الواجهة عند تغيير البيانات",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحسين تجربة المستخدم",
      taskDescription: "تسهيل التنقل وتقليل خطوات العمليات",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "إضافة Localization",
      taskDescription: "دعم لغات متعددة للمستخدمين",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "اختبار الأداء على أجهزة قديمة",
      taskDescription: "ضمان استقرار التطبيق على الأجهزة الضعيفة",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "إصلاح مشاكل الـ Notifications",
      taskDescription: "تأكد من وصول التنبيهات في الوقت المناسب",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحسين Splash Screen",
      taskDescription: "إظهار شاشة تحميل سلسة عند فتح التطبيق",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "إعادة تنظيم ملفات المشروع",
      taskDescription: "تبسيط الهيكلية لتسهيل الصيانة",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "إنشاء دليل أساليب الترميز",
      taskDescription: "وضع قواعد للكود الموحد بين الفريق",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحسين الرسائل الخطأ",
      taskDescription: "جعل الرسائل واضحة ومفهومة للمستخدم",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "إضافة اختبارات التكامل",
      taskDescription: "ضمان أن كل المكونات تعمل معًا بدون مشاكل",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "مراجعة الأداء على iOS و Android",
      taskDescription: "التحقق من عدم وجود تهنيج أو Crash",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "إعداد النسخ الاحتياطي للبيانات",
      taskDescription: "حفظ بيانات المستخدمين بشكل آمن",
      isDone: false,
      isHighPriority: true,
    ),
    Task(
      taskName: "تحسين الرسوم المتحركة للـ Buttons",
      taskDescription: "جعل التفاعل مع الأزرار أكثر سلاسة",
      isDone: false,
      isHighPriority: false,
    ),
    Task(
      taskName: "إضافة شاشة إعدادات",
      taskDescription: "تمكين المستخدم من التحكم بالإشعارات والـ Theme",
      isDone: false,
      isHighPriority: true,
    ),
  ];

  List<dynamic> tasksJson = exampleTasks.map((e) => e.toJson()).toList();

  String jsonString = jsonEncode(tasksJson);

  await prefs.setString('tasks', jsonString);
}
