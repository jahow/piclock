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
  } catch (Exception e) {
    // failed!
  }
}

void saveSettings() {
}
