class TimelineData {
  JSONObject json;
  TimelineData() {
    json = loadJSONObject("json/timeline/"+matchID+".json");
  }

  int getFramSize() {
    return json.getJSONArray("frames").size();
  }

  int getPlayerByID(int pid) {
    return json.getJSONArray("frames").getJSONObject(0).getJSONObject("participantFrames").getJSONObject("1").getInt("totalGold");
  }

  boolean hasEvent(int fid) {
    return this.numEventInframe(fid) > 0;
  }

  int numEventInframe(int fid) {
    return this.getEventArray(fid).size();
  }

  JSONArray getEventArray(int fid) {
    return json.getJSONArray("frames").getJSONObject(fid).getJSONArray("events");
  }

  int getEventSize(int fid) {
    return getEventArray(fid).size();
  }

  String getEventType(int fid, int eid) {
    return getEventArray(fid).getJSONObject(eid).getString("type");
  }

  long[] getPlayerKillPos(int fid, int eid) {
    long[] pos = {-1, -1};
    if (this.getEventType(fid, eid).equals("CHAMPION_KILL")) {
      long px = getEventArray(fid).getJSONObject(eid).getJSONObject("position").getLong("x");
      long py = getEventArray(fid).getJSONObject(eid).getJSONObject("position").getLong("y");
      pos[0] = px;
      pos[1] = py;
    }
    return pos;
  }

  Position[] getPlayerKillPosList() {
    Position[] pos = new Position[0];
    for (int i=0; i<getFramSize(); i++) {
      if (hasEvent(i)) {
        for (int j=0; j<getEventSize(i); j++) {
          long[] k = getPlayerKillPos(i, j);
          if (k[0] >= 0) {
            //println(k[0], k[1]);
            Position tmpPos = new Position(k[0], k[1]);
            pos = (Position[])append(pos, tmpPos);
          }
        }
      }
    }
    return pos;
  }

  class Position {
    long px;
    long py;
    Position(long x, long y) {
      px = x;
      py = y;
    }
  }
}