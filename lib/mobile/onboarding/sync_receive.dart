import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:safepass/utils/colors.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ReceiveSync extends StatefulWidget {
  const ReceiveSync({super.key});

  @override
  State<ReceiveSync> createState() => _ReceiveSyncState();
}

class _ReceiveSyncState extends State<ReceiveSync> {
  late WebSocketChannel channel;
  String serverUrl = 'wss://localhost:3000/ws';
  String clientId = 'receiver123';

  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides();
    channel = IOWebSocketChannel.connect(serverUrl);
    channel.sink.add(jsonEncode({'type': 'register', 'clientId': clientId}));

    channel.stream.listen((message) async {
      Map<String, dynamic> data = jsonDecode(message);
      if (data['type'] == 'file') {
        String dbPath = join(await getDatabasesPath(), data['filename']);
        File file = File(dbPath);
        file.writeAsBytesSync(base64Decode(data['file']));
        print('File saved to $dbPath');
        Get.snackbar("Success!", "Sync completed successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30)
              .copyWith(top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Waiting for sync to complete...")],
          )),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
