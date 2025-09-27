import 'dart:io';

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
    double firstNumber = getValidNumber(firstPrompt);
    
    String operator = checkOperator(thirdPrompt);
    
    double secondNumber = getValidNumber(secondPrompt);

    double answer = calculate(firstNumber, secondNumber, operator);

    stdout.writeln("Svar: ${answer.toStringAsFixed(2)}\n");
    stdout.writeln("Tryck Enter för att göra en ny uträkning.");
    stdin.readLineSync();
    runApp();
  }

}

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

String checkOperator(String prompt){
  
  while (true) {
    String errorMessage = "Du måste välja en operation (+, -, /, *)";
    stdout.writeln(prompt);
    String operator = stdin.readLineSync()?.trim() ?? "";

    if (operator.isEmpty) {
      stdout.writeln(errorMessage);
      continue;
    }
    
    try {
      if (operator == "+" || operator == "-" || operator == "/" || operator == "*") {
        return operator;    
      }
      else{
        stdout.writeln(errorMessage);
      }
    } catch(e) {
      stdout.writeln("Error: $e");
    }
  }
}

double getValidNumber(String prompt){

  while (true) {
    stdout.writeln(prompt);
    String input = stdin.readLineSync()?.trim() ?? "";

    if (input.isEmpty) {
      stdout.writeln("Du måste ange ett heltal");
      continue;
    }

    try {
      double number = double.parse(input);
      return number;
    } on FormatException {
      stdout.writeln("Ogiltigt värde. Ange ett heltal.");
    }
  }
}

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