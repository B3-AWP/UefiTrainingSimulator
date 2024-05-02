class DefaultValues {
  // Eine Methode, um Standard-Einstellungen zu definieren
  static Map<String, String> initialSettings() {
    return {
      'Language': 'English',
      // Fügen Sie hier weitere Standardwerte hinzu
    };
  }

  // Eine Methode, um die Übung 1 zu definieren
  static Map<String, Map<String, String>> exercise1() {
    return {
      'Language': {'start': 'Français', 'goal': 'English'},
      'Serial Port 1 Address': {'goal': '3E8/IRQ4'},
      'Parallel Port Address': {'start': '3BC'},
      'Parallel Port Mode': {'goal': 'ECP'},
      // Fügen Sie hier weitere Einstellungen hinzu
    };
  }

  // Eine Methode, um die Übung 2 zu definieren
  static Map<String, Map<String, String>> exercise2() {
    return {
      'Serial Port 1 Address': {'goal': '3E8/IRQ4'},
      'Parallel Port Address': {'start': '278'},
      'Parallel Port Mode': {'start': 'EPP'},
      // Weitere Einstellungen hier
    };
  }
}