# uefi_simulator

1. Install Flutter (e.g. as Extension in VS Code)
   e.g. Extensions IDs: Dart-Code.flutter, alexisvt.flutter-snippets
2. Open VS Code Terminal 
3. $ flutter pub get
4. $ flutter build app

# Integration in moodle/bycs/mebis
1. open file build/web/index.html
2. Comment out <base href="/">  to  <!-- <base href="/"> -->
3. zip all files inside the web directory to web.zip
4. Create activity file in moodle
5. Upload the whole zip
6. click on zip file and in the dialog click on unzip
7. search for index.html and click on it
8. in the dialogform click on "Hauptdatei setzen"