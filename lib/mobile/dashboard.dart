import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:safepass/logic/api.dart';
import 'package:safepass/mobile/password_preview.dart';
import 'package:safepass/utils/colors.dart';
import 'package:safepass/widgets/custom_navbar_mobile.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/password_item.dart';
import '../widgets/generate_modal.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({super.key});

  @override
  State<MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  @override
  void initState() {
    super.initState();
  }

  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("SafePass",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: primaryColor)),
        centerTitle: false,
      ),
      body: PageView(
        controller: _pageController,
        children: const [HomePage(), SyncPage()],
      ),
      bottomNavigationBar: CustomNavBar(
        homeOnPressed: () => _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn),
        syncOnPressed: () => _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn),
      ),
    );
  }
}

class SyncPage extends StatelessWidget {
  const SyncPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String serverUrl = 'wss://10.0.2.2:3000/ws';
    String clientId = 'sender123';
    String receiverId = 'receiver123';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How to set up sync:",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
              "1. Open SafePass on the other device and select the \"sync password from another device\" option.\n\n2. Ensure you are connected to the same Wi-Fi network.\n\n3. Select the \"Sync Now\" button to open a connection to sync your passwords to your other device.",
              style: Theme.of(context).textTheme.bodyMedium),
          const Expanded(child: SizedBox()),
          Text("Sync your passwords to your other devices securely.",
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextButton(
                onPressed: () async {
                  HttpOverrides.global = MyHttpOverrides();
                  final channel = IOWebSocketChannel.connect(serverUrl);
                  channel.sink.add(
                      jsonEncode({'type': 'register', 'clientId': clientId}));

                  File file =
                      File(join(await getDatabasesPath(), 'safepass.db'));
                  List<int> fileBytes = await file.readAsBytes();
                  String base64File = base64Encode(fileBytes);

                  channel.sink.add(jsonEncode({
                    'type': 'file',
                    'filename': 'safepass.db',
                    'file': base64File,
                    'receiverId': receiverId
                  }));
                },
                style: TextButton.styleFrom(backgroundColor: secondaryColor),
                child: Text("Sync Now",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white))),
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PasswordItem> recentlyUsed = [];
  @override
  void initState() {
    super.initState();
    retrievePasswords().then((e) => setState(() {
          recentlyUsed = e;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        secondaryColor.withAlpha(205).withRed(62).withBlue(112),
                    child: SvgPicture.asset(
                      'assets/images/key.svg',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Generate a Password",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                  const SizedBox(height: 5),
                  Text("Generate a unique password you can use anywhere!",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.white)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                builder: (context) => const GenerateModal());
                          },
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10)),
                          child: const Text("Generate"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Categories",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              children: [
                Card(
                  color: altColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: accentColor.withAlpha(70),
                          child: SvgPicture.asset(
                            'assets/images/global.svg',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Websites",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "${recentlyUsed.where((password) => password.category == "Website").length} password",
                            style: Theme.of(context).textTheme.labelMedium)
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: accentColor.withAlpha(70),
                          child: SvgPicture.asset(
                            'assets/images/slider-horizontal.svg',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Apps",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "${recentlyUsed.where((password) => password.category == "App").length} passwords",
                            style: Theme.of(context).textTheme.labelMedium)
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Text(
              "Recently used passwords",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // const SizedBox(height: 20),
            recentlyUsed.isEmpty
                ? SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Your recently used passwords appear here",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: recentlyUsed.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        PasswordPreview(
                                            password: recentlyUsed[index]))),
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          accentColor.withAlpha(135),
                                      child: recentlyUsed[index].favicon ??
                                          (recentlyUsed[index].category ==
                                                  "Websites"
                                              ? SvgPicture.asset(
                                                  'assets/images/global.svg')
                                              : SvgPicture.asset(
                                                  'assets/images/slider-horizontal.svg'))),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          recentlyUsed[index].title ??
                                              recentlyUsed[index].site,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          recentlyUsed[index].username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await Clipboard.setData(ClipboardData(
                                          text: recentlyUsed[index].password));
                                      Get.snackbar(
                                        "",
                                        "Password Copied Successfully",
                                        backgroundColor: Colors.green,
                                        snackPosition: SnackPosition.TOP,
                                        snackStyle: SnackStyle.FLOATING,
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/images/copy copy.svg'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
          ],
        ),
      ),
    );
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
