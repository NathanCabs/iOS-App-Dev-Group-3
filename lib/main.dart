import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(ATMApp());

class ATMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PinEntryScreen(),
    );
  }
}

double balance = 50000.00; // Example balance

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  TextEditingController pinController = TextEditingController();
  int attempts = 0;
  final correctPin = '123456';

  void checkPin() {
    if (pinController.text == correctPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        attempts++;
      });
      if (attempts >= 3) {
        // Exit the app or show an error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Too many attempts!'),
            content: Text('Exiting...'),
            actions: [
              TextButton(
                onPressed: () => exit(0),
                child: Text('OK'),
              ),
            ],
          ),
        );
        
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Incorrect PIN'),
            content: Text('Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  pinController.clear();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  // void exitApp(){
  //   if(Platform.isAndroid || Platform.isIOS){
  //     SystemNavigator.pop();
  //   } else{
  //     exit(0);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Enter 6-digit PIN'),
            ),
            ElevatedButton(
              onPressed: checkPin,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the grid and the logout button
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10.0),
              children: [
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BalanceInquiryScreen()),
                      );
                    },
                    child: Center(child: Text('Balance Inquiry')),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WithdrawCashScreen()),
                      );
                    },
                    child: Center(child: Text('Withdraw Cash')),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransferMoneyScreen()),
                      );
                    },
                    child: Center(child: Text('Transfer Money')),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePinScreen()),
                      );
                    },
                    child: Center(child: Text('Change Pin')),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PayBillsScreen()),
                      );
                    },
                    child: Center(child: Text('Pay Bills')),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DepositMoneyScreen()),
                      );
                    },
                    child: Center(child: Text('Deposit Money')),
                  ),
                ),
              ],
            ),
          ),
          // Add Logout button here
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PinEntryScreen()),
                  (route) => false, // Clear the stack to prevent going back
                );
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}


// Step 1: Create Balance Inquiry Screen
class BalanceInquiryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Inquiry'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your Balance:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '\₱$balance',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to HomeScreen
              },
              child: Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

// Step 2: Withdraw Cash Screen
class WithdrawCashScreen extends StatefulWidget {
  @override
  _WithdrawCashScreenState createState() => _WithdrawCashScreenState();
}

class _WithdrawCashScreenState extends State<WithdrawCashScreen> {
  final TextEditingController amountController = TextEditingController();

  void withdrawCash() {
    double amount = double.tryParse(amountController.text) ?? 0;
    if (amount > 0) {
      double totalAmount = amount + 10; // Include transfer fee

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Withdrawal'),
          content: Text(
            'You are about to withdraw ₱$amount.\n'
            'Transfer fee: ₱10\n'
            'Total amount: ₱$totalAmount\n\n'
            'Do you want to proceed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel the transaction
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Proceed with the transaction
                if (totalAmount <= balance) {
                  setState(() {
                    balance -= totalAmount; // Subtract the total amount from balance
                  });
                  Navigator.of(context).pop(); // Close the dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Withdrawal Successful'),
                      content: Text('You have withdrawn ₱$amount.\nRemaining Balance: ₱$balance'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.of(context).pop(); // Close the confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Insufficient Balance'),
                      content: Text('You do not have enough balance to complete this transaction.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw Cash'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount to Withdraw'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: withdrawCash,
              child: Text('Withdraw Cash'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Cancel transaction and go back
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}


// Step 3: Transfer Money Screen
class TransferMoneyScreen extends StatefulWidget {
  @override
  _TransferMoneyScreenState createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void transferMoney() {
    String accountNumber = accountNumberController.text;
    double amount = double.tryParse(amountController.text) ?? 0;
    if (amount > 0 && accountNumber.isNotEmpty) {
      double totalAmount = amount + 10; // Include transfer fee

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Transfer'),
          content: Text(
            'You are about to transfer ₱$amount to Account Number: $accountNumber.\n'
            'Transfer fee: ₱10\n'
            'Total amount: ₱$totalAmount\n\n'
            'Do you want to proceed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel the transaction
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Proceed with the transaction
                if (totalAmount <= balance) {
                  setState(() {
                    balance -= totalAmount; // Subtract the total amount from balance
                  });
                  Navigator.of(context).pop(); // Close the dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Transfer Successful'),
                      content: Text('You have transferred ₱$amount to Account Number: $accountNumber.\nRemaining Balance: ₱$balance'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.of(context).pop(); // Close the confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Insufficient Balance'),
                      content: Text('You do not have enough balance to complete this transaction.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid account number and amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: accountNumberController,
              decoration: InputDecoration(labelText: 'Account Number'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount to Transfer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: transferMoney,
              child: Text('Transfer Money'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Cancel transaction and go back
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

// Step 4: Change Pin Screen
class ChangePinScreen extends StatefulWidget {
  @override
  _ChangePinScreenState createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final TextEditingController currentPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController reEnterPinController = TextEditingController();
  String correctPin = '123456'; // Example current pin

  void changePin() {
    String currentPin = currentPinController.text;
    String newPin = newPinController.text;
    String reEnterPin = reEnterPinController.text;

    // Check if any of the fields are empty
    if (currentPin.isEmpty || newPin.isEmpty || reEnterPin.isEmpty) {
      showAlert('Empty Fields', 'Please fill in all fields.');
      return;
    }

    // Validate current pin
    if (currentPin != correctPin) {
      showAlert('Invalid Current Pin', 'Please try again.');
      return;
    }

    // Validate new pin is different from current pin
    if (newPin == currentPin) {
      showAlert('Same Pin Error', 'The new pin must be different from the current pin.');
      return;
    }

    // Validate that new pin matches the re-entered pin
    if (newPin != reEnterPin) {
      showAlert('Pin Mismatch', 'Pins entered do not match, please try again.');
      return;
    }

    // Update the pin (in a real app, you'd save the new pin securely)
    correctPin = newPin;

    // Show success alert and navigate back to the Pin Entry Screen
    showAlert('Success', 'Pin changed successfully!', () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PinEntryScreen()),
        (route) => false, // Remove all previous routes
      );
    });

    // Clear input fields
    currentPinController.clear();
    newPinController.clear();
    reEnterPinController.clear();
  }

  // Function to display alert dialogs
  void showAlert(String title, String message, [VoidCallback? onConfirm]) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onConfirm != null) {
                onConfirm(); // Execute the callback if provided
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Pin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: currentPinController,
              decoration: InputDecoration(labelText: 'Current Pin'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: newPinController,
              decoration: InputDecoration(labelText: 'New Pin'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: reEnterPinController,
              decoration: InputDecoration(labelText: 'Re-enter New Pin'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: changePin,
              child: Text('Change Pin'),
            ),
          ],
        ),
      ),
    );
  }
}


// Step 5: Pay Bills Screen
class PayBillsScreen extends StatefulWidget {
  @override
  _PayBillsScreenState createState() => _PayBillsScreenState();
}

class _PayBillsScreenState extends State<PayBillsScreen> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<String> billers = ['Meralco', 'Manila Water', 'PLDT'];
  String? selectedBiller;

  void payBill() {
    double amount = double.tryParse(amountController.text) ?? 0;
    if (amount > 0 && selectedBiller != null) {
      double totalAmount = amount + 10; // Include transfer fee

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Payment'),
          content: Text(
            'You are about to pay ₱$amount to $selectedBiller.\n'
            'Transfer fee: ₱10\n'
            'Total amount: ₱$totalAmount\n\n'
            'Do you want to proceed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Cancel the transaction
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Proceed with the transaction
                if (totalAmount <= balance) {
                  setState(() {
                    balance -= totalAmount; // Subtract the total amount from balance
                  });
                  Navigator.of(context).pop(); // Close the dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Payment Successful'),
                      content: Text('You have paid ₱$amount to $selectedBiller.\nRemaining Balance: ₱$balance'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  Navigator.of(context).pop(); // Close the confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Insufficient Balance'),
                      content: Text('You do not have enough balance to complete this transaction.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid account number and amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Bills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              hint: Text('Select Biller'),
              value: selectedBiller,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBiller = newValue;
                });
              },
              items: billers.map<DropdownMenuItem<String>>((String biller) {
                return DropdownMenuItem<String>(
                  value: biller,
                  child: Text(biller),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: accountNumberController,
              decoration: InputDecoration(labelText: 'Account Number'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount to Pay'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: payBill,
              child: Text('Pay Bill'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Cancel transaction and go back
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}


// Step 6: Deposit Money Screen
class DepositMoneyScreen extends StatefulWidget {
  @override
  _DepositMoneyScreenState createState() => _DepositMoneyScreenState();
}

class _DepositMoneyScreenState extends State<DepositMoneyScreen> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void depositMoney() {
    String accountNumber = accountNumberController.text;
    double amount = double.tryParse(amountController.text) ?? 0;

    if (amount > 0 && accountNumber.isNotEmpty) {
      double totalAmount = amount; // No transfer fee for deposits

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Deposit'),
          content: Text(
            'You are about to deposit ₱$amount to Account Number: $accountNumber.\n'
            'Total amount to be added: ₱$totalAmount\n\n'
            'Do you want to proceed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel the transaction
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Proceed with the transaction
                setState(() {
                  balance += totalAmount; // Add the amount to balance
                });
                Navigator.of(context).pop(); // Close the dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Deposit Successful'),
                    content: Text('You have deposited ₱$amount to Account Number: $accountNumber.\nNew Balance: ₱$balance'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid account number and amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposit Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: accountNumberController,
              decoration: InputDecoration(labelText: 'Account Number'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount to Deposit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: depositMoney,
              child: Text('Deposit Money'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Cancel transaction and go back
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
