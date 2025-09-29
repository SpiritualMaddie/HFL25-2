import 'dart:io';

// Function to start the app
void runApp(){
  String firstPrompt = "Ange första talet:";
  String secondPrompt = "Ange andra talet:";
  String thirdPrompt = "Vilken operation vill du göra? (+, -, /, *):";

  clearConsole();
  print("""
██╗  ██╗ █████╗ ██╗     ██╗  ██╗██╗   ██╗     
██║ ██╔╝██╔══██╗██║     ██║ ██╔╝╚██╗ ██╔╝     
█████╔╝ ███████║██║     █████╔╝  ╚████╔╝█████╗
██╔═██╗ ██╔══██║██║     ██╔═██╗   ╚██╔╝ ╚════╝
██║  ██╗██║  ██║███████╗██║  ██╗   ██║        
╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝        
                                              
██╗      █████╗ ████████╗ ██████╗ ██████╗     
██║     ██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗    
██║     ███████║   ██║   ██║   ██║██████╔╝    
██║     ██╔══██║   ██║   ██║   ██║██╔══██╗    
███████╗██║  ██║   ██║   ╚██████╔╝██║  ██║    
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝    
""");
  while (true) {   
    // Variable that stores the first number input of the calculator after its been checked that its a number
    double firstNumber = getValidNumber(firstPrompt);
    
    // Variable that stores the operator input of the calculator after its been checked that its a valid operator that the calculator can handle
    String operator = checkOperator(thirdPrompt);
    
    // Variable that stores the second number input of the calculator after its been checked that its a number
    double secondNumber = getValidNumber(secondPrompt);

    // Variable that stores the calculated equation from the input of the user
    double answer = calculate(firstNumber, secondNumber, operator);

    // Writes the calculated equation to the user with a limit of 2 decibels
    stdout.writeln("Svar: ${answer.toStringAsFixed(2)}\n");

    // and gives the option to either do another equation or end the program with simple error handling
    while(true){
      stdout.writeln("Skriv 'ny' för att göra en ny uträkning eller skriv 'bryt' för att avsluta");
      String input = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (input == "ny") {
        runApp();
      }
      else if(input == "bryt"){
        endScreen();
      }
      else{
        stdout.writeln("Ogiltigt input, försök igen.");
        continue;
      }
    }
  }

}

// Function to calculate simple equations
double calculate(double firstNumber, double secondNumber, String operator) {
  double answer = 0;

  switch (operator) {
    case "+":
      answer = firstNumber + secondNumber;
      break;
    case "-":
      answer = firstNumber - secondNumber;
      break;
    case "/":
      answer = firstNumber / secondNumber;
      break;
    case "*":
      answer = firstNumber * secondNumber;
      break;
  }
  return answer;
}

// Function to check that the operator chosen is valid in this program
// takes in chosen prompt that can be changed in runApp()
// simple error handling
String checkOperator(String prompt){
  
  while (true) {

    // const could also be used instead of List or String for these variables
    List<String> validOperators = ["+", "-", "/", "*"];
    String errorMessage = "Du måste välja en operation (+, -, /, *)";

    while (true) {
      stdout.writeln(prompt);
      String operator = stdin.readLineSync()?.trim() ?? "";

      if (operator.isEmpty || !validOperators.contains(operator)) {
        stdout.writeln(errorMessage);
        continue;
      }

      return operator;
    }
  }
}

// Function to make sure the user inputs a number, simple error handling
double getValidNumber(String prompt){

  while (true) {
    stdout.writeln(prompt);
    String input = stdin.readLineSync()?.trim() ?? "";

    if (input.isEmpty) {
      stdout.writeln("Du måste ange en siffra/tal");
      continue;
    }

    try {
      double number = double.parse(input);
      return number;
    } on FormatException {
      stdout.writeln("Ogiltigt värde. Ange en siffra/tal.");
    }
  }
}

// Function to clear console, there's options to un-comment if this doesnt work on your machine
void clearConsole(){
    // ANSI escape code to clear console
    print('\x1B[2J\x1B[0;0H');

    // Platform specific solutions that didnt work on my machine
    // if(Platform.isWindows){
    //   // Clear console on Windows
    //   Process.runSync("cls", [], runInShell: true);
    // }
    // else{
    //   // Clear console on other platforms
    //   Process.runSync("clear", [], runInShell: true);
    // }
}

// Function to create an end screen and end the program
void endScreen(){
  clearConsole();
  stdout.write("Du valde att avsluta, programmet avslutar...");
  sleep(Duration(seconds: 2));
  exit(0);
}