import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class SSLHelper {
  static IOClient? _client;

  static http.Client get client => _client ?? http.Client();

  static Future<void> initializing() async {
    _client = await instance;
  }

  static Future<IOClient> get instance async =>
      _client ??= await createIoClient();

  static Future<IOClient> createIoClient() async {
    final sslCert = await rootBundle.load('certificates/certificate.pem');
    // final sslCert = await rootBundle.load('certificates/google.pem');
    
    final securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
    

    final httpClient = HttpClient(context: securityContext);

    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
        
    return IOClient(httpClient);
  }
}
