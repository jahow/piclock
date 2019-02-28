import java.util.Iterator;

class Radio {
  String name;
  String url;
  Radio(String name, String url) {
    this.name = name;
    this.url = url;
  }
}

ArrayList<Radio> Settings_RadioList = new ArrayList<Radio>();
int Settings_CurrentRadio = 0;

final int[][] Settings_AlarmTimes = new int[][] {
  new int[] { 0, 0 },
  new int[] { 0, 0 },
  new int[] { 0, 0 },
  new int[] { 0, 0 },
  new int[] { 0, 0 },
  new int[] { 0, 0 },
  new int[] { 0, 0 },
};
final boolean[] Settings_AlarmEnabled = new boolean[] {
  false,
  false,
  false,
  false,
  false,
  false,
  false,
};

void loadSettings() {
  Settings_RadioList.clear();
  Settings_CurrentRadio = 0;
  
  try {
    JSONObject json = loadJSONObject("settings.json");
    
    // radios
    JSONObject radioList = json.getJSONObject("radioList");
    Iterator it = radioList.keyIterator();
    while(it.hasNext()) {
      String key = (String)it.next();
      Settings_RadioList.add(new Radio(key, radioList.getString(key)));
    }
    Settings_CurrentRadio = json.getInt("currentRadio");
    
    // alarms
    JSONArray alarmTimes = json.getJSONArray("alarmTimes");
    for (int i = 0; i < alarmTimes.size(); i++) {
      Settings_AlarmTimes[i][0] = alarmTimes.getJSONArray(i).getIntArray()[0];
      Settings_AlarmTimes[i][1] = alarmTimes.getJSONArray(i).getIntArray()[1];
    }
    JSONArray alarmEnabled = json.getJSONArray("alarmEnabled");
    for (int i = 0; i < alarmEnabled.size(); i++) {
      Settings_AlarmEnabled[i] = alarmEnabled.getBoolean(i);
    }
  } catch (Exception e) {
    println("loadSettings failed: " + e.getMessage());
  }
}

void saveSettings() {
  try {
    JSONObject lastJson = loadJSONObject("settings.json");
    JSONObject json = new JSONObject();
    
    // radios (list is taken from the previous file)
    json.setJSONObject("radioList", lastJson.getJSONObject("radioList"));
    json.setInt("currentRadio", Settings_CurrentRadio);
    
    // alarms
    JSONArray alarmTimes = new JSONArray();
    for (int i = 0; i < Settings_AlarmTimes.length; i++) {
      JSONArray timeArray = new JSONArray();
      timeArray.setInt(0, Settings_AlarmTimes[i][0]);
      timeArray.setInt(1, Settings_AlarmTimes[i][1]);
      alarmTimes.setJSONArray(i, timeArray);
    }
    json.setJSONArray("alarmTimes", alarmTimes);
    JSONArray alarmEnabled = new JSONArray();
    for (int i = 0; i < Settings_AlarmEnabled.length; i++) {
      alarmEnabled.setBoolean(i, Settings_AlarmEnabled[i]);
    }
    json.setJSONArray("alarmEnabled", alarmEnabled);
    
    saveJSONObject(json, "settings.json");
  } catch (Exception e) {
    println("saveSettings failed: " + e.getMessage());
  }
}
