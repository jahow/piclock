void initAlarm() {
}

int checkHours = -1;
int checkMinutes = -1;
int playing = 0;    // 1 is sound, 2 is radio
int startTime = 0;
final int ALARM_DURATION_MS = 1000 * 60 * 60;
final int ALARM_SOUND_DURATION_MS = 6000;

void updateAlarm() {
  if (playing == 1 && millis() - startTime > ALARM_SOUND_DURATION_MS) {
    exec("mplayer", Settings_RadioList.get(Settings_CurrentRadio).url);
    playing = 2;
  }
  
  if (playing > 0 && millis() - startTime > ALARM_DURATION_MS) {
    playing = 0;
    exec("/bin/bash", "sound_stop");
  }
  
  if (hour() != checkHours || minute() != checkMinutes) {
    checkHours = hour();
    checkMinutes = minute();
    int day = 0;
   
    switch(cal.get(Calendar.DAY_OF_WEEK)) {
      case Calendar.MONDAY: day = 0; break;
      case Calendar.TUESDAY: day = 1; break;
      case Calendar.WEDNESDAY: day = 2; break;
      case Calendar.THURSDAY: day = 3; break;
      case Calendar.FRIDAY: day = 4; break;
      case Calendar.SATURDAY: day = 5; break;
      case Calendar.SUNDAY: day = 6; break;
    }
    
    if (Settings_AlarmEnabled[day] && Settings_AlarmTimes[day][0] == checkHours
        && Settings_AlarmTimes[day][1] == checkMinutes) {
      exec("mplayer", sketchPath() + "/wakeup.mp3");
      startTime = millis();
      playing = 1;
    }
  }
}
