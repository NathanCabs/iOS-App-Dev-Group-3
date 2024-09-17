import 'dart:io';


class AtmActivity{
double balance = 50000;
String initialPin = "1234";

void dashBoard(){
  print("\nWelcome User! \n");  
  print("[1] Balance Inquiry");
  print("[2] Withdraw Cash");
  print("[3] Transfer Money");
  print("[4] Change Pin");
  print("[5] Pay Bills");
  print("[6] Deposit Money");
  print("[7] Exit");
  

stdout.write("\nSelect an option: ");
String? choice = stdin.readLineSync();

switch (choice){
  case '1':
  balanceInquiry();
  break;
  case '2':
  withdrawCash();
  break;
  case '3':
  transferMoney();
  break;
  case '4':
  changePin();
  break;
  case '5':
  payBills();
  break;
  case '6':
  depositMoney();
  break;
  case '7':
  logout();
  break;
  default:
  print("Invalid input please select from 1-7");
  dashBoard();
  break;
}

}

void balanceInquiry(){
bool condition = false;
bool pinCondition = false;

while(!pinCondition){
stdout.write("Enter your PIN: ");
String? enteredPin = stdin.readLineSync()!;
if(enteredPin == initialPin){
  print("Your balance is ₱$balance\n");
  pinCondition = true;
}
else if (enteredPin.length < initialPin.length){
  print("Invalid PIN. Please enter a PIN with ${initialPin.length} digits.");
  
}
else{
  print("Invalid PIN. Please try again.");
}
}

while(!condition){
stdout.write("Do another transaction? (y/n): ");
String? option= stdin.readLineSync();
if (option != null){
  if (option.toLowerCase() == 'y'){
    dashBoard();
    condition = true;
  }
  else if (option.toLowerCase() == 'n'){
    print("Ending transaction");
    return;
  }
  else{
    print("Invalid input. Please choose y or n.");
  }
}
else{
  print("No input given");
}
}

}

void withdrawCash(){
  bool condition = false;
  bool pinCondition = false;

while(!pinCondition){
stdout.write("Enter your PIN: ");
String? enteredPin = stdin.readLineSync()!;
if(enteredPin == initialPin){
  while(!condition){
  stdout.write("Enter amount to withdraw: ");
  double? withdraw = double.tryParse(stdin.readLineSync()!);
    if (withdraw != null && withdraw < balance && withdraw > 0){
    balance -= withdraw;
    condition = true;
    print("Withdrawal successful. Your new balance is ₱$balance\n");
    
    stdout.write("Do another transaction? (y/n): ");
    String? option= stdin.readLineSync();
      if (option != null){
        if (option.toLowerCase() == 'y'){
          dashBoard();
          condition = true;
        }
      else if (option.toLowerCase() == 'n'){
        print("Ending transaction");
        return;
      }
      else{
        print("Invalid input. Please choose y or n.");
      }
    }
    else{
      print("No input given");
    }
    }
    else{
      print("Invalid amount entered, please try again");
    }        
}
  pinCondition = true;
}
else if (enteredPin.length < initialPin.length){
  print("Invalid PIN. Please enter a PIN with ${initialPin.length} digits.");
  
}
else{
  print("Invalid PIN. Please try again.");
}
}
 
}

void transferMoney(){
bool condition = false;
double tf = 10;bool pinCondition = false;

while(!pinCondition){
stdout.write("Enter your PIN: ");
String? enteredPin = stdin.readLineSync()!;
if(enteredPin == initialPin){
  stdout.write("Transfer to (account number): ");
  String? accNumber = stdin.readLineSync();
  
  while(!condition){
  stdout.write("Enter amount to transfer:");
  double? transfer = double.tryParse(stdin.readLineSync()!);

  stdout.write("\nThere is an ₱10 transfer fee, would you like to continue? (y/n): ");
  String? cont = stdin.readLineSync();
    if (cont != null){
        if (cont.toLowerCase() == 'y'){
            if (transfer != null && transfer < balance && transfer > 0){
    balance -= (transfer + tf);
    condition = true;
    print("\nTransfered to account number: $accNumber");
    print("Transfer successful. Your new balance is ₱$balance\n");
    
    stdout.write("Do another transaction? (y/n): ");
    String? option= stdin.readLineSync();
      if (option != null){
        if (option.toLowerCase() == 'y'){
          dashBoard();
          condition = true;
        }
      else if (option.toLowerCase() == 'n'){
        print("Ending transaction");
        return;
      }
      else{
        print("Invalid input. Please choose y or n.");
      }
    }
    else{
      print("No input given");
      transferMoney();
    }
    }
    else{
      print("\nInvalid amount entered, please try again");
      transferMoney();
    }
      condition = true;
        }
      else if (cont.toLowerCase() == 'n'){
        print("Cancelling transaction");
        dashBoard();
      }
      else{
        print("Invalid input. Please choose y or n.");
      }
    }
    else{
      print("No input given");
    }       
}
  pinCondition = true;
}
else if (enteredPin.length < initialPin.length){
  print("Invalid PIN. Please enter a PIN with ${initialPin.length} digits.");
  
}
else{
  print("Invalid PIN. Please try again.");
}
}
}

void changePin(){
  stdout.write("Enter current PIN:");
    String currentPin = stdin.readLineSync()!;

    if (currentPin == initialPin) {
      while (true) {
        stdout.write("Enter new PIN (4 digits):");
        String newPin = stdin.readLineSync()!;

        if (newPin.length == 4 && newPin != currentPin) {
          stdout.write("Re-enter new PIN:");
          String reEnterNewPin = stdin.readLineSync()!;

          if (newPin == reEnterNewPin) {
            print("PIN changed successfully");
            initialPin = newPin;
            dashBoard();
            break;
          } else {
            print("PINs do not match. Please try again.");
          }
        } else {
          print("PIN must be 4 digits / PIN is the same as the current PIN. Please try again.");
        }
      }
    } else {
      print("Invalid current PIN. Please try again.");
      changePin();
    }
}

void payBills(){
bool condition = false;
double tf = 10;
// ignore: unused_local_variable
String? accNumber;
bool pinCondition = false;

while(!pinCondition){
stdout.write("Enter your PIN: ");
String? enteredPin = stdin.readLineSync()!;
if(enteredPin == initialPin){
 print("\nBILLERS");
  print("[1] Meralco");
  print("[2] Manila Water");
  print("[3] PLDT");
  
  stdout.write("\nSelect an option: ");
String? choice = stdin.readLineSync();

switch (choice){
  case '1':
  stdout.write("Enter your Meralco account number: ");
  accNumber = stdin.readLineSync();
  break;
  case '2':
  stdout.write("Enter your Manila Water account number: ");
  accNumber = stdin.readLineSync();
  break;
  case '3':
  stdout.write("Enter your PLDT account number: ");
  accNumber = stdin.readLineSync();
  break;
}
  while(!condition){
  stdout.write("Enter amount to pay:");
  double? billPay = double.tryParse(stdin.readLineSync()!);

  stdout.write("\nThere is an ₱10 transfer fee, would you like to continue? (y/n): ");
  String? cont = stdin.readLineSync();
    if (cont != null){
        if (cont.toLowerCase() == 'y'){
            if (billPay != null && billPay < balance && billPay > 0){
    balance -= (billPay + tf);
    condition = true;
    print("Payment successful. Your new balance is ₱$balance\n");
    
    stdout.write("Do another transaction? (y/n): ");
    String? option= stdin.readLineSync();
      if (option != null){
        if (option.toLowerCase() == 'y'){
          dashBoard();
          condition = true;
        }
      else if (option.toLowerCase() == 'n'){
        print("Ending transaction");
        return;
      }
      else{
        print("Invalid input. Please choose y or n.");
      }
    }
    else{
      print("No input given");
      payBills();
    }
    }
    else{
      print("\nInvalid amount entered, please try again");
      payBills();
    }
      condition = true;
        }
      else if (cont.toLowerCase() == 'n'){
        print("Cancelling transaction");
        dashBoard();
      }
      else{
        print("Invalid input. Please choose y or n.");
      }
    }
    else{
      print("No input given");
    }       
}
  pinCondition = true;
}
else if (enteredPin.length < initialPin.length){
  print("Invalid PIN. Please enter a PIN with ${initialPin.length} digits.");
  
}
else{
  print("Invalid PIN. Please try again.");
}
}



}

void depositMoney(){
 bool condition = false;
 bool pinCondition = false;

while(!pinCondition){
stdout.write("Enter your PIN: ");
String? enteredPin = stdin.readLineSync()!;
if(enteredPin == initialPin){
while(!condition){
  stdout.write("Enter amount to deposit: ");
  double? deposit = double.tryParse(stdin.readLineSync()!);
    if (deposit != null && deposit > 0){
    balance += deposit;
    condition = true;
    print("Deposit successful. Your new balance is ₱$balance\n");
    
    stdout.write("Do another transaction? (y/n): ");
    String? option= stdin.readLineSync();
      if (option != null){
        if (option.toLowerCase() == 'y'){
          dashBoard();
          condition = true;
        }
        else if (option.toLowerCase() == 'n'){
          print("Ending transaction");
          return;
          }
      else{
    print("Invalid input. Please choose y or n.");
    }
  }
    else{
  print("No input given");
  }
    }
    else{
      print("Invalid amount entered, please try again");
    }        
}
  pinCondition = true;
}
else if (enteredPin.length < initialPin.length){
  print("Invalid PIN. Please enter a PIN with ${initialPin.length} digits.");
  
}
else{
  print("Invalid PIN. Please try again.");
}
} 
}

void logout(){
  print("You have successfully logged out!");
}

}

