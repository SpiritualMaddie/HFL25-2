
// Class to create a customizable menu in a CLI with multiple options
class Menu{

  final List<String> _options;
  final String _prompt;

  Menu({required List<String> options, required String prompt})
  : _options = options,
  _prompt = prompt;

  @override
  String toString() {
    String result = "$_prompt\n";
    for (int i = 0; i < _options.length; i++){
      result += "${_options[i]}\n";
    }
    return result;
  }
}