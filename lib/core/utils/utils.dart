import 'dart:convert';

import 'package:todo_app/Features/home/models/task.dart';

String setGreetingMessage12Hour() {
    int hour = DateTime.now().hour;
    bool isAM = hour < 12;

    int hour12 = hour % 12;
    if (hour12 == 0) hour12 = 12;

    if (isAM) {
      return 'صباح الخير';
    } else if (hour12 < 5) {
      return 'بعد الظهر';
    } else {
      return 'مساء الخير';
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

  