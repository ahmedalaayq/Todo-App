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
  