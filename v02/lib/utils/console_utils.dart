import 'dart:io';
class ConsoleUtils {

  void logo(){
    print(r"""
             .=.,
            ;c =\
          __|  _/
        .'-'-._/-'-._
       /..   ____    \
      /' _  [<_->] )  \
     (  / \--\_>/-/'._ )
      \-;_/\__;__/ _/ _/
       '._}|==o==\{_\/
        /  /-._.--\  \_
       // /   /|   \ \ \
      / | |   | \;  |  \ \
     / /  | :/   \: \   \_\
    /  |  /.'|   /: |    \ \
    |  |  |--| . |--|     \_\
    / _/   \ | : | /___--._) \
   |_(---'-| >-'-| |       '-'
          /_/     \_\
 _   _                ____              _____  ___   ___   ___  
| | | | ___ _ __ ___ |  _ \  _____  __ |___ / / _ \ / _ \ / _ \ 
| |_| |/ _ \ '__/ _ \| | | |/ _ \ \/ /   |_ \| | | | | | | | | |
|  _  |  __/ | | (_) | |_| |  __/>  <   ___) | |_| | |_| | |_| |
|_| |_|\___|_|  \___/|____/ \___/_/\_\ |____/ \___/ \___/ \___/ 
""");
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

  // Function to give message to user about invalid input
  void invalidChoice(){
    stdout.writeln("Ogiltigt input. Vänligen försök igen");
    sleep(Duration(seconds: 2));
  }

  // Function to create an end screen and end the program
  void endScreen(){
    clearConsole();
    stdout.write("Du valde att avsluta, programmet avslutar...");
    sleep(Duration(seconds: 2));
    exit(0);
  }
}