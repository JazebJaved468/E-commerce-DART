import 'dart:io';
import 'dart:math';
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
dynamic loggedInCustomer = customers[
    0]; // dynamic bcz in middle of program its datatype is changing from string to Map and then again to String
dynamic loggedInCustomerPosition = 0;
// "None"; // dynamic bcz in middle of program its datatype is changing from string to int(index of customers List)

bool isAdmin = false;
bool isCustomer = false;

void main() {
  //Starting the Program---Welcome Message
  start();

  // asking option from user after after show products
  if (isCustomer) {
    print("Asking options");
    askOptions();
  } else {
    askAdminOptions();
  }

  //extra testing functions : write here

  // String? inp = stdin.readLineSync();
  // String i = inp ?? "-2";
  // print(isIdExist(i));
  // addToCart();
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

  print("\u001b[1m\u001b[32mYou are successfully registered\u001b[0m");
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
      isCustomer = true;
      loggedInCustomer = i;
      loggedInCustomerPosition = customers.indexOf(
          i); // storing in global variable so that products can be easily added to cart
      break;
    }
  }
  if (iscredentials == true) {
    print(
        "\u001b[1m\u001b[32mLogin Successful (${loggedInCustomer['name']})\u001b[0m");
    askShowProducts();
  } else {
    print("\u001b[31mSorry: Incorrect Credentials, Login Failed\u001b[0m");

    // again asking user to select options
    askUser();
  }
}

askShowProducts() {
  //Home page

  print("\u001b[36mEnter (1,2,3,4,5): ");
  print("1: Show all products");
  print("2: Show Bags");
  print("3: Show Fragrance");
  print("4: Show Jewelry");
  print("5 (or any other key): Logout \u001b[0m");

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
  // askOptions();
  // above line commented bcz showall func getting stuck in recursion
}

void showAll() {
  List<String> titles = ['BAGS', 'FRAGRANCES', 'JEWELRY'];
  List<List> productLists = [bags, fragrance, jewelry];
  for (var i = 0; i < 3; i++) {
    showProductList(titles[i], productLists[i]);
  }
}

void askOptions() {
  print("\u001b[36mEnter (1,2,3,4,5,6,7): ");
  print("1: Show product details");
  print("2: Add to cart ");
  print("3: Remove from Cart");
  print("4: Show Cart");
  print("5: Check Out");
  print("6: Go Back");
  print("7 (or any other key): Logout \u001b[0m");

  stdout.write("Enter: ");
  var optionSelected = stdin.readLineSync()!;

  if (optionSelected == "1") {
    getProductID();
  } else if (optionSelected == "2") {
    addToCart();
  } else if (optionSelected == "3") {
    removeFromCart();
  } else if (optionSelected == "4") {
    showCart();
  } else if (optionSelected == "5") {
    checkOut();
  } else if (optionSelected == "6") {
    askShowProducts();
  } else {
    logoutCustomer();
  }
  // Again asking options
  askOptions();
}

getProductID() {
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
        "\u001b[1m\u001b[31mSorry, Product not found... Write correct ID\u001b[0m");
  }
}

addToCart() {
  var accessedCart = customers[loggedInCustomerPosition]['cart'];
  stdout.write("Enter Product ID to be added to cart: ");
  var productId = stdin.readLineSync()!;
  var prodId = productId.toLowerCase();

  var productquantity;

  if (isIdExist(prodId)) {
    stdout.write("Enter Product Quantity: ");
    var productquantity = stdin.readLineSync()!;
    print(accessedCart);
    List existData = itemAlreadyInCart(prodId, accessedCart);
    if (existData[0]) {
      // print(existData);
      // print(accessedCart[existData[1]]['quantity'].runtimeType);
      accessedCart[existData[1]]['quantity'] =
          (int.parse(accessedCart[existData[1]]['quantity']) +
                  int.parse(productquantity))
              .toString();
      // print(accessedCart[existData[1]]['quantity']);
      // print(accessedCart[existData[1]]['quantity'].runtimeType);
    } else {
      int cartLength = accessedCart.length;
      accessedCart.add({'item': prodId});
      // print( accessedCart[cartLength]['quantity']);
      accessedCart[cartLength]['quantity'] = productquantity;
      // print(accessedCart[cartLength]['quantity'].runtimeType);
    }

    print("\u001b[1m\u001b[35mItem Successfully Added To Cart...\u001b[0m");
    showCart();
    reduceInventory(prodId, productquantity);
  } else {
    print(
        "\u001b[1m\u001b[31mSorry, Product Doesnot Exist... Write correct ID\u001b[0m");
    addToCart();
  }
}

reduceInventory(String prodId, String prodQuantity){
if (prodId[0] == "b") {
    reduceItem(prodId, prodQuantity, bags);
  } else if (prodId[0] == "f") {
    reduceItem(prodId, prodQuantity, fragrance);
  } else {
    reduceItem(prodId, prodQuantity, jewelry);
  } 
}

reduceItem(String prodId, String prodQuantity, List prodList){
  for (var product in prodList) {
    if(product['id'] == prodId){
      print(product['quantity']);
      product['quantity'] -= int.parse(prodQuantity);
      print(product['quantity']);
    }
  }
}

List itemAlreadyInCart(String id, List cart) {
  bool alreadyExist = false;
  var indexwhereExist = -1;
  for (var product in cart) {
    if (product['item'] == id) {
      alreadyExist = true;
      indexwhereExist = cart.indexOf(product);
    }
  }
  print(cart);
  return [alreadyExist, indexwhereExist];
}

isIdExist(String prodId) {
  bool idFound = false;
  if (prodId[0] == "b") {
    idFound = checkId(prodId, bags);
  } else if (prodId[0] == "f") {
    idFound = checkId(prodId, fragrance);
  } else if (prodId[0] == "j") {
    idFound = checkId(prodId, jewelry);
  } else {
    idFound = false;
  }

  return idFound;
}

bool checkId(String pid, List prodList) {
  bool isFound = false;
  for (var product in prodList) {
    if (isFound == false) {
      if (pid == product['id']) {
        isFound = true;
      }
    } else {
      break;
    }
  }
  return isFound;
}

removeFromCart() {
  var accessedCart = customers[loggedInCustomerPosition]['cart'];
  stdout.write("Enter Product ID to be removed from cart: ");
  var productId = stdin.readLineSync()!;
  var prodId = productId.toLowerCase();

  accessedCart.removeWhere((item) => item == prodId);
  print("\u001b[1m\u001b[35mItem Successfully Removed From Cart...\u001b[0m");
  showCart();
}

showCart() {
  var accessedCart = customers[loggedInCustomerPosition]['cart'];
  if (accessedCart.length == 0) {
    print("\u001b[1m\u001b[35mYour Cart is currently empty\u001b[0m");
  } else {
    stdout.write(
        "\u001b[1m\u001b[35mYour Cart contains the following products ---> \u001b[0m");

    for (var cartItem in accessedCart) {
      stdout.write(
          '${getItemDetails(cartItem['item'], "name")} (${cartItem['quantity']}) | ');
    }
    print(" ");
  }
}

dynamic getItemDetails(String prodId, String attribute) {
  if (prodId[0].toLowerCase() == "b") {
    return (getDetails(prodId, bags, attribute));
  } else if (prodId[0].toLowerCase() == "f") {
    return (getDetails(prodId, fragrance, attribute));
  } else {
    return (getDetails(prodId, jewelry, attribute));
  }
}

dynamic getDetails(String id, List productList, String attribute) {
  bool isFound = false;
  var requiredName;
  var requiredPrice;
  for (var i = 0; i < productList.length; i++) {
    if (isFound == false) {
      if (id == productList[i]['id']) {
        isFound = true;
        // return (productList[i]['name']);
        requiredName = productList[i]['name'];
        requiredPrice = productList[i]['price'];
      }
    } else {
      break;
    }
  }
  if (attribute == "name") {
    return requiredName;
  } else if (attribute == "price") {
    return requiredPrice;
  } else {
    return "none";
  }
}

checkOut() {
  print("\u001b[1m\u001b[32mEnter Shipping Details\u001b[0m");

  // getting country
  stdout.write("Enter Country: ");
  var country = stdin.readLineSync()!;

  // getting city
  stdout.write("Enter City: ");
  var city = stdin.readLineSync()!;

  // getting Shipping Addres
  stdout.write("Enter Shipping Address: ");
  var shippingAddress = stdin.readLineSync()!;

  // getting postal code
  stdout.write("Enter Postal Code: ");
  var postalCode = stdin.readLineSync()!;

  // adding customer map to customers list
  // print('loggedInCustomer datatype : ${loggedInCustomer.runtimeType}');
  loggedInCustomer['shippingDetails'] = {
    'city': city,
    'country': country,
    'shippingAddress': shippingAddress,
    'postalCode': postalCode,
  };

  print("\u001b[1m\u001b[32mShipping Details Saved\u001b[0m");
  print('\u001b[30m\x1B[3mNote: Shipping Charges will be applied...\u001b[0m');

  orderOptions();
}

orderOptions() {
  print("\u001b[36mEnter (1,2,3): ");
  print("1: Generate Invoice");
  print("2: Place Order");
  print("3: Go Back to Cart Page");

  print("4 (or any key): Logout \u001b[0m");

  stdout.write("Enter: ");
  var orderOpt = stdin.readLineSync()!;

  if (orderOpt == "1") {
    generateInvoice();
  } else if (orderOpt == "2") {
    placeOrder();
    askAfterPlaceOrder();
  } else if (orderOpt == "3") {
    askOptions();
  } else {
    logoutCustomer();
  }
}

generateInvoice() {
  var space = "                ";
  var lines = "--------------------";
  print(
      '\u001b[1m\u001b[33m================================= ORDER INVOICE =================================\u001b[0m');
  print('\u001b[35m\x1B[4mCUSTOMER INFORMATION\u001b[0m');
  print(
      '\u001b[32mCUSTOMER NAME\u001b[0m $lines--- \u001b[37m${loggedInCustomer['name']}\u001b[0m');
  print(
      '\u001b[32mCUSTOMER E-MAIL\u001b[0m $lines- \u001b[37m${loggedInCustomer['email']}\u001b[0m');
  print(
      '\u001b[32mCUSTOMER CONTACT\u001b[0m $lines \u001b[37m${loggedInCustomer['contact']}\u001b[0m');
  print(" ");
  print('\u001b[35m\x1B[4mCUSTOMER SHIPPING DETAILS\u001b[0m');
  print(
      '\u001b[32mCOUNTRY\u001b[0m $lines--------- \u001b[37m${loggedInCustomer['shippingDetails']['country']}\u001b[0m');
  print(
      '\u001b[32mCITY\u001b[0m $lines------------ \u001b[37m${loggedInCustomer['shippingDetails']['city']}\u001b[0m');
  print(
      '\u001b[32mSHIPPING ADDRESS\u001b[0m $lines \u001b[37m${loggedInCustomer['shippingDetails']['shippingAddress']}\u001b[0m');
  print(
      '\u001b[32mPOSTAL CODE\u001b[0m $lines----- \u001b[37m${loggedInCustomer['shippingDetails']['postalCode']}\u001b[0m');
  print(" ");
  print('\u001b[35m\x1B[4mITEMS PURACHASED\u001b[0m');
  print(
      '\u001b[32m ITEM ID =============== ITEM NAME =============== QUANTITY=============== PRICE\u001b[0m');
  num total = 0;
  num shippingCharges = 400;
  for (var item in loggedInCustomer['cart']) {
    var itemId = item['item'];
    var itemName = getItemDetails(item['item'], "name");
    var itemQuantity = item['quantity'];
    var itemPrice = getItemDetails(item['item'], "price");
    total += itemPrice;
    print(
        '\u001b[37m   ${itemId} $space ${itemName} $space ${itemQuantity} $space   ${itemPrice}\u001b[0m');
  }
  print("");
  print(
      '\u001b[37mTOTAL --------------------------------------------------------------------- $total\u001b[0m');
  print(
      " $space SHIPPING CHARGES ---------------------------------------- $shippingCharges");
  num gst = (total * 0.18).ceil();
  print(
      " $space GST ----------------------------------------------------- $gst");
  num subTotal = total + shippingCharges + gst;
  print("");
  print(
      '\u001b[1m\u001b[32m SUBTOTAL $space$space$space$space $subTotal\u001b[0m');
  print(
      '\u001b[1m\u001b[33m============================== Thanks For Shopping ==============================\u001b[0m');

  orderOptions();
}

placeOrder() {
  print('\u001b[32mORDER PLACED SUCCESSFULLY\u001b[0m');
  print('\u001b[30mNote: Order will be delivered in 10 days.\u001b[0m');
  print(
      '\u001b[1m\u001b[35mThanks For E-Shopping, Wishing You A Happy Day!\u001b[0m');
}

askAfterPlaceOrder() {
  print("\u001b[36mEnter (1,2,3): ");
  print("1: Go To Home Page");
  print("2 (or any other key): Logout\u001b[0m");

  stdout.write("Enter: ");
  var afterOrder = stdin.readLineSync()!;

  if (afterOrder == "1") {
    askShowProducts();
  } else {
    logoutCustomer();
  }
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
      "\u001b[1m\u001b[32mSuccessfully Logout From (${loggedInCustomer['name']})\u001b[0m");

  //setting logincustomer to no-one
  loggedInCustomer = "No one is currently login";
  isCustomer = false;

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

askAdminOptions() {
  print("Hello Admin");
  logoutAdmin();
}

logoutAdmin() {
  print("\u001b[1m\u001b[32mSuccessfully Logout\u001b[0m");

  askUser();
}


/* FORMATTING
\u001b[1m: Sets the text style to bold.
\u001b[0m: Resets the text style and color to the default.
\x1B[4m: uderline
\x1B[3m: italicized

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