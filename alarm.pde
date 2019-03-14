import processing.sound.*;

SoundFile file;

void initAlarm() {
  file = new SoundFile(this, "wakeup.mp3");
}

int checkHours = -1;
int checkMinutes = -1;
boolean playing = false;
int startTime = 0;
final int ALARM_DURATION_MS = 1000 * 60 * 60;

void updateAlarm() {
  if (playing && millis() - startTime > file.duration() * 1000 * 2) {
    exec("mplayer", Settings_RadioList.get(Settings_CurrentRadio).url);
  }
  
  if (playing && millis() - startTime > ALARM_DURATION_MS) {
    playing = false;
    exec("sudo", "killall", "mplayer");
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
      file.cue(0);
      file.play();
      startTime = millis();
      playing = true;
    }
  }
}
