import 'dart:io';

class AtmActivity {
  String pin = "1234";

  void changePin() {
    print("Enter current PIN:");
    String currentPin = stdin.readLineSync()!;

    if (currentPin == pin) {
      while (true) {
        print("Enter new PIN (4 digits):");
        String newPin = stdin.readLineSync()!;

        if (newPin.length == 4) {
          print("Re-enter new PIN:");
          String reEnterNewPin = stdin.readLineSync()!;

          if (newPin == reEnterNewPin) {
            print("PIN changed successfully");
            pin = newPin;
            dashBoard();
            break;
          } else {
            print("PINs do not match. Please try again.");
          }
        } else {
          print("PIN must be 4 digits. Please try again.");
        }
      }
    } else {
      print("Invalid current PIN. Please try again.");
      changePin();
    }
  }
}
