import 'dart:io';
import 'bags.dart'; // getting data from other file
import 'customers.dart'; // getting data from other file
import 'fragrance.dart';
import 'jewelry.dart'; // getting data from other file
/* 
Assumptions:
-Username is case sensitive
-Only 2 admins are there, no more admins allowed
-Admin credentials: username, password
-Customer credentials: email, password
-email is case sensitive

*/

// GLoabal variables
var userInput;
var loggedInCustomer = "No one is Login currently";

void main() {
  //Starting the Program---Welcome Message
  start();

  // asking user to login as
  askUser();
}

void start() {
  print('\u001b[1m\u001b[32m======== Welcome to E-SHOP ========\u001b[0m');
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
    print("\u001b[1m\u001b[32m======== E-Shop Closed ========\u001b[0m");
    exit(
        0); // program exited using builtin function, wese bhi exit hojata is k begair bhi
  }
}

void adminLogin() {
  // getting admin username
  stdout.write("Enter Username: ");
  var adminName = stdin.readLineSync()!;

  // getting admin password
  stdout.write("Enter Password: ");
  var adminPassword = stdin.readLineSync();

  // Username is case sensitive (that's why used toLOwerCase())
  if ((adminName.toLowerCase() == "jazeb" && adminPassword == "jazeb") ||
      (adminName.toLowerCase() == "arbaz" && adminPassword == "arbaz")) {
    print("\u001b[1m\u001b[32mWelcome to Admin Panel\u001b[0m");
  } else {
    print("\u001b[31mSorry: Incorrect Credentials\u001b[0m");

    // again asking user to select options
    askUser();
  }
}

void registerUser() {
  // getting customer Name
  stdout.write("Enter Name: ");
  var customerName = stdin.readLineSync()!;

  // getting customer E-mail
  stdout.write("Enter Email: ");
  var customerEmail = stdin.readLineSync()!;

  // getting customer Contact
  stdout.write("Enter Contact Number: ");
  var customerContact = stdin.readLineSync()!;

  // getting customer Address
  stdout.write("Enter Address: ");
  var customerAddress = stdin.readLineSync()!;

  // getting customer password
  stdout.write("Create Password: ");
  var customerPassword = stdin.readLineSync();

  // adding customer map to customers list
  customers.add({
    // converting username to sentence case
    'name': toSentenceCase(customerName),
    'email': customerEmail,
    'contact': customerContact,
    'address': customerAddress,
    'password': customerPassword
  });

  print("\u001b[1m\u001b[32m You are successfully registered\u001b[0m");
  // asking user for login
  askUser();
}

void userLogin() {
  // getting customer email
  stdout.write("Enter email: ");
  var customeremail = stdin.readLineSync()!;

  // getting customer password
  stdout.write("Enter Password: ");
  var customerPassword = stdin.readLineSync();

  bool iscredentials = false;
  for (var i in customers) {
    if (i['email'] == customeremail.toLowerCase() &&
        i['password'] == customerPassword) {
      iscredentials = true;
      loggedInCustomer = i['name'];
      break;
    }
  }
  if (iscredentials == true) {
    print("\u001b[1m\u001b[32mLogin Successful ($loggedInCustomer)\u001b[0m");
    askShowProducts();
  } else {
    print("\u001b[31mSorry: Incorrect Credentials, Login Failed\u001b[0m");

    // again asking user to select options
    askUser();
  }
}

askShowProducts() {
  print("\u001b[36mEnter (1,2,3): ");
  print("1: Show all products");
  print("2: Show Bags");
  print("3: Show Fragrance");
  print("4: Show Jewelry");
  print("5 (or any key): Logout \u001b[0m");

  stdout.write("Enter: ");
  var userInp = stdin.readLineSync()!;

  showProducts(userInp);
}

showProducts(String userInp){
  if(userInp == "1"){
    showAll();
  }
  else if(userInp == '2'){
    showProductList('BAGS', bags);
  }
    else if(userInp == '3'){
    showProductList('FRAGRANCES', fragrance);
  }
    else if(userInp == '4'){
    showProductList('JEWELRY', jewelry);
  }
  else{
    logoutCustomer();
  }
}

void showProductList(String productTitle, List productList, {int counter=1} ){
  // var productTitle = "BAGS";
  // var productList = bags;
  print("\u001b[1m\u001b[35m$productTitle\u001b[0m");
  for (var i = 0; i < productList.length; i++) {
    print("${counter} : ${productList[i]['name']}");
    counter++;
  }
}

void showAll(){
  List<String> titles = ['BAGS', 'FRAGRANCES', 'JEWELRY'];
  List<List> productLists = [bags, fragrance, jewelry];
  for (var i = 0; i < 3; i++) {
    if(i == 1 ){
        showProductList(titles[i], productLists[i], counter: bags.length + 1);  
    }
    else if(i == 2 ){
        showProductList(titles[i], productLists[i], counter: bags.length +1 + fragrance.length);  
    }
    else{
    showProductList(titles[i], productLists[i]);    
  }
  }
}





void logoutCustomer(){
  print("\u001b[1m\u001b[32mSuccessfully Logout From ($loggedInCustomer)\u001b[0m");

  //setting logincustomer to no-one
  loggedInCustomer = "No one is currently login";

  // asking for again login
  askUser();
}

String toSentenceCase(String input) {
  if (input.isEmpty) {
    return input;
  }

  String firstLetter = input.substring(0, 1).toUpperCase();
  String restOfString = input.substring(1).toLowerCase();

  return '$firstLetter$restOfString';
}



/* FORMATTING

\u001b[1m: Sets the text style to bold.
\u001b[0m: Resets the text style and color to the default.

COLORS
Black: \u001b[30m
Red: \u001b[31m
Green: \u001b[32m
Yellow: \u001b[33m
Blue: \u001b[34m
Magenta: \u001b[35m
Cyan: \u001b[36m
White: \u001b[37m

*/