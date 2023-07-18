import 'dart:io';

// GLoabal variables
var userInput;

void main() {
  //Starting the Program---Welcome Message
  start();

  // asking user to login as
  askUser();

  // Doing operations depending on user
  // doOperations(user);

  // if (user == "1"){
  //     stdout.write("Enter Username: ");
  //     var adminName = stdin.readLineSync();
  //     stdout.write("Enter Password: ");
  //     var adminPassword = stdin.readLineSync();
  // }
}

void start() {
  print('\u001b[1m\u001b[32m ======== Welcome to E-SHOP ========\u001b[0m');
}

void askUser() {
  print("\u001b[36mEnter (1,2,3): ");
  print("1: Login as Admin");
  print("2: User Register");
  print("3: User Login");
  print("4 (or any key): Exit \u001b[0m");

  stdout.write("Enter: ");
  var userInput = stdin.readLineSync()!;
  // return userInput;

  // Doing operations depending on user
  doOperations(userInput);
}

void doOperations(user) {
  if (user == "1") {
    adminLogin();
  } else if (user == '2') {
    registerUser();
  } else if (user == '3') {
    userLogin();
  } else {
    print("Program Exited");
  }
}

adminLogin() {
  // getting admin username
  stdout.write("Enter Username: ");
  var adminName = stdin.readLineSync()!;

  // getting admin password
  stdout.write("Enter Password: ");
  var adminPassword = stdin.readLineSync();

  // Assumption: Username is case sensitive (that's why used toLOwerCase())
  if((adminName.toLowerCase() == "jazeb" && adminPassword == "jazeb") || (adminName.toLowerCase() == "arbaz" && adminPassword == "arbaz")){
    print("\u001b[1m\u001b[32mWelcome to Admin Panel\u001b[0m");
  }
  else{
    print("\u001b[31mSorry: Incorrect Credentials\u001b[0m");

    // again asking user to select options
    askUser();
  }
}

registerUser() {}

userLogin() {}


// \u001b[1m: Sets the text style to bold.
// \u001b[32m: Sets the text color to green.
// \u001b[0m: Resets the text style and color to the default.

// Black: \u001b[30m
// Red: \u001b[31m
// Green: \u001b[32m
// Yellow: \u001b[33m
// Blue: \u001b[34m
// Magenta: \u001b[35m
// Cyan: \u001b[36m
// White: \u001b[37m
