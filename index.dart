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
}

void start() {
  print('\u001b[1m\u001b[32m======== Welcome to E-SHOP ========\u001b[0m');

  // asking user to login as
  askUser();
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
    'password': customerPassword,
    'cart': []
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

showProducts(String userInp) {
  if (userInp == "1") {
    showAll();
  } else if (userInp == '2') {
    showProductList('BAGS', bags);
  } else if (userInp == '3') {
    showProductList('FRAGRANCES', fragrance);
  } else if (userInp == '4') {
    showProductList('JEWELRY', jewelry);
  } else {
    logoutCustomer();
  }
}

void showProductList(String productTitle, List productList) {
  print("\u001b[1m\u001b[35m$productTitle\u001b[0m");
  for (var i = 0; i < productList.length; i++) {
    print("${productList[i]['id']} : ${productList[i]['name']}");
  }

  // asking user to select options like itemdetails, cart etc
  askOptions();
}

void showAll() {
  List<String> titles = ['BAGS', 'FRAGRANCES', 'JEWELRY'];
  List<List> productLists = [bags, fragrance, jewelry];
  for (var i = 0; i < 3; i++) {
    showProductList(titles[i], productLists[i]);
  }
}

void askOptions() {
  print("\u001b[36mEnter (1,2,3,4): ");
  print("1: Show product details");
  print("2: Add to cart ");
  print("3: Remove from Cart");
  print("4: Show Cart");
  print("5 (or any key): Logout \u001b[0m");

  stdout.write("Enter: ");
  var optionSelected = stdin.readLineSync()!;

  if (optionSelected == "1") {
    stdout.write("Enter Product ID: ");
    var productId = stdin.readLineSync()!;
    var prodId = productId.toLowerCase();
    if (prodId[0].toLowerCase() == "b") {
      showItemDetails(prodId, bags, "Bag");
    } else if (prodId[0] == "f") {
      showItemDetails(prodId, fragrance, "Fragrance");
    } else if (prodId[0] == "j") {
      showItemDetails(prodId, jewelry, "Jewelry");
    } else {
      print(
          "\u001b[1m\u001b[31mSorry, Product not found. Write correct ID\u001b[0m");
    }
  }

  // Again asking options
  askOptions();
}

void showItemDetails(String id, List productList, String categoryName) {
  bool isFound = false;

  for (var i = 0; i < productList.length; i++) {
    if (isFound == false) {
      if (id == productList[i]['id']) {
        isFound = true;
        print('\u001b[1m\u001b[35mSelected $categoryName Details:\u001b[0m');
        var productKeys = productList[i]
            .keys; // this is an iterable --- converting into list bcz [] arenot working with iterables
        List productKeysList = productKeys.toList(); // this is list
        for (var key = 0; key < productKeys.length; key++) {
          print(
              '${productKeysList[key].toUpperCase()} : ${productList[i][productKeysList[key]]}');
        }
      }
    } else {
      break;
    }
  }

  // checked all items... if still not found then product with id doenot exist or customer has inputted wrong id
  if (isFound == false) {
    print(
        "\u001b[1m\u001b[31mSorry, Product not found... Write correct ID\u001b[0m");
  }
}

void logoutCustomer() {
  print(
      "\u001b[1m\u001b[32mSuccessfully Logout From ($loggedInCustomer)\u001b[0m");

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