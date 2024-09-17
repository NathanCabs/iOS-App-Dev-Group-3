import 'dart:io';
import 'package:atm_activity/atm_activity.dart';

void main() {
  AtmActivity atmUser = AtmActivity();
  bool rPin = false;
  //String pin = "1234";
  int attempts = 0;


 while(!rPin && attempts < 3){
  stdout.write('Enter PIN: ');
  String? enteredPin = stdin.readLineSync();
  if(enteredPin == atmUser.initialPin){
    atmUser.dashBoard();
    rPin = true;
  }
  else{
    attempts++;
      if (attempts < 3){
          print("Invalid PIN, please re-enter");
        }
        else{
          print("You have entered the wrong PIN 3 times and are now locked out!");
          exit(0);
        }
  }
  }
}
