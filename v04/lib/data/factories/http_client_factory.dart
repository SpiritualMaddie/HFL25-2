import 'package:http/http.dart' as http;
import 'package:v04/interfaces/ihttp_client_factory.dart';

class HttpClientFactory implements IHttpClientFactory {
  @override
  http.Client create() => http.Client();
}