import 'dart:io';

class AtmActivity{
 
double balance = 1000;

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
  exit(0);
}

}

void balanceInquiry(){
bool condition = false;

print("Your balance is ₱$balance\n");

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
  
  while(!condition){
  stdout.write("Enter amount: ");
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
}

void transferMoney(){

}

void changePin(){

}

void payBills(){

}

void depositMoney(){
 bool condition = false;
  
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
}



}

