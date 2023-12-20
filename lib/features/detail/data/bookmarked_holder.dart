class DataHolder {
  String stringValue;
  int intValue;

  DataHolder({required this.stringValue, required this.intValue});

  void setStringValue(String value) {
    stringValue = value;
  }

  void setIntValue(int value) {
    intValue = value;
  }

  String getStringValue() {
    return stringValue;
  }

  int getIntValue() {
    return intValue;
  }
}
