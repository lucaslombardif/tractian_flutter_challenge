import 'package:dio/io.dart';

class HttpService extends DioForNative { 
  
  HttpService() {
    _boot();
  }

  void _boot() {
    options.baseUrl = 'https://fake-api.tractian.com';
  }
}