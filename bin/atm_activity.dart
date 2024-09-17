import 'dart:io';
import 'package:atm_activity/atm_activity.dart';

AtmActivity atmUser = AtmActivity();

void main() {
  bool rPin = false;
  String pin = "1234";
  int attempts = 0;

  while (!rPin && attempts < 3) {
    stdout.write('Enter PIN: ');
    String? enteredPin = stdin.readLineSync();
    if (enteredPin == pin) {
      dashBoard();
      rPin = true;
    } else {
      attempts++;
      if (attempts < 3) {
        print("Invalid PIN, please re-enter");
      } else {
        print("You have entered the wrong PIN 3 times and are now locked out!");
        exit(0);
      }
    }
  }
}

void dashBoard() {
  print("Welcome User");
  print("Dashboard:");
  print("1. Check Balance");
  print("2. Withdraw Cash");
  print("3. Deposit Cash");
  print("4. Change PIN");
  print("5. Exit");

  int option = int.parse(stdin.readLineSync()!);

  switch (option) {
    case 1:
      print("Check Balance option selected");
      // Add code to check balance code here
      break;
    case 2:
      print("Withdraw Cash option selected");
      // Add code to withdraw cash code here
      break;
    case 3:
      print("Deposit Cash option selected");
      // Add deposit cash code here
      break;
    case 4:
      atmUser.changePin();
      break;
    case 5:
      print("Exiting...");
      break;
    default:
      print("Invalid option. Please try again.");
      dashBoard();
  }
}
