import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await Shared.createLEClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}

class Shared {
  static Future<HttpClient> customHttpClient({
    bool isTestMode = false,
  }) async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    try {
      List<int> bytes = [];
      if (isTestMode) {
        bytes = utf8.encode(_certificatedString);
      } else {
        bytes = (await rootBundle.load('certificates/certificates.pem'))
            .buffer
            .asUint8List();
      }
      log('bytes $bytes');
      context.setTrustedCertificatesBytes(bytes);
      log('createHttpClient() - cert added!');
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('createHttpClient() - cert already trusted! Skipping.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }
    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createLEClient({bool isTestMode = false}) async {
    IOClient client =
        IOClient(await Shared.customHttpClient(isTestMode: isTestMode));
    return client;
  }
}

const _certificatedString = """-----BEGIN CERTIFICATE-----
MIIFNzCCBB+gAwIBAgISBOi9yAwPdtlpt56Mq/rk1Va9MA0GCSqGSIb3DQEBCwUA
MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
EwJSMzAeFw0yMjExMTAxMzIwMDhaFw0yMzAyMDgxMzIwMDdaMCQxIjAgBgNVBAMT
GWRldmVsb3BlcnMudGhlbW92aWVkYi5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDyx9ghDZ8Dy7QQJVBzOExTkrRf7J4+cPp5WsVvEkNFOI9cSDku
4T8x1vwu7YgRzylsv2v5ZJ0v0CyS+FC5qSbAkE2Fs+e1iOcpEtnXO0itaNNityy7
2Lpx6yHZeK40Z1+A9gqfsZKJOjppwW3Q/7tbw0PE6gLXii5A58LhFzk/QheL62F9
l+ddfMCzt4cl7p+GdZHY0m4go9buhA4iVK06QUBqroC1pkeGFRRgM7T1L8euQC23
wcQqOBykapwMjxKNtBaPtXLAF/7J2umrnRzikEB7x3bEVht3NDduGH1SUQyfhB+p
nqcuPzl0rXGru12Sq1H6J4WpOaPp2EGljL9jAgMBAAGjggJTMIICTzAOBgNVHQ8B
Af8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMAwGA1UdEwEB
/wQCMAAwHQYDVR0OBBYEFAk70v07HyLQVS6+v8zjd0G54LErMB8GA1UdIwQYMBaA
FBQusxe3WFbLrlAJQOYfr52LFMLGMFUGCCsGAQUFBwEBBEkwRzAhBggrBgEFBQcw
AYYVaHR0cDovL3IzLm8ubGVuY3Iub3JnMCIGCCsGAQUFBzAChhZodHRwOi8vcjMu
aS5sZW5jci5vcmcvMCQGA1UdEQQdMBuCGWRldmVsb3BlcnMudGhlbW92aWVkYi5v
cmcwTAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMBAQEwKDAmBggrBgEF
BQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEDBgorBgEEAdZ5AgQC
BIH0BIHxAO8AdQB6MoxU2LcttiDqOOBSHumEFnAyE4VNO9IrwTpXo1LrUgAAAYRh
6ZTJAAAEAwBGMEQCIDHaqb99C+C2Yu/D3dabfjZsBntR4Nrrjpy4W01Sa0RTAiBu
q7AKGj90A4IlN4rc5UajtBnPjigZNluYREmfsimR8wB2AK33vvp8/xDIi509nB4+
GGq0Zyldz7EMJMqFhjTr3IKKAAABhGHplNkAAAQDAEcwRQIhAIl5tInSqRf1DHqT
z76col7Ua2zm+potvQUdut3pRN94AiBrdLUFnbzUmMh6E4wZiLt+hAkVtwbYUNXp
udOBarGVyTANBgkqhkiG9w0BAQsFAAOCAQEALs0wNLe7oPDokGGsmS4jWpSMgoiY
XtoRFaKb2UdNS0mIHqR0qshrvPtPlg6Ohk9ymWGOvbxWnEh9/ImJ9k3mLJl6Wp3F
JshlzM02kIBjpS/f1D4pAFtESkefHwsPwlne3Oefkcb2SP5UQH2YL5foPzh0dJhl
zQ2KbFrLBmVa7+X4EIPS7KBHVBrr6Wafy9rtMJxNTk8vASeT0S92PcbLyPFFEinX
Aw9sEk+ig5e8z6Y5aeUCHO5dDcioK/v0M4jMbxa+tETr1mx2vWX83dboJXOz+GmD
iWvscRS9/7yLUyOXx6mkdElDx8MtjfL4mLUBiMS/KnULFQbbbBIgizlJ+A==
-----END CERTIFICATE-----
""";
