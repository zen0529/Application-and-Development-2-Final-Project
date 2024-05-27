// import 'package:appd2fp/practice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appd2fp/history.dart';
import 'package:appd2fp/login.dart';
import 'package:appd2fp/registration.dart';
import 'package:appd2fp/settings.dart';
import 'package:appd2fp/sentimentanalysis.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // const sentimentanalysis(),
      // home: Scaffold(body: logIn()),
      initialRoute: '/login',
      routes: {
        '/history': (context) => history(
            username: ModalRoute.of(context)!.settings.arguments as String),
        '/home': (context) => MyHomePage(),
        '/settings': (context) => setting(
            username: ModalRoute.of(context)!.settings.arguments as String),
        '/login': (context) => const logIn(),
        '/registration': (context) => const Registration(),
        '/sentimentanalysis': (context) => sentimentanalysis(
            username: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // initialize a index
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: 1020,
          width: 1550,
          color: const Color(0xFFF0F3F7),
        ),
        Positioned(
          top: 0,
          child: Stack(
            children: [
              Container(
                width: 1550,
                height: 101,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color(0x000000).withOpacity(0.04), // 4% transparency
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hi, there!', // Replace 'firstname' with the field you want to display
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const SizedBox(
                      width: 19,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 15,
          right: 20,
          child: Container(
            width: 1150,
            height: 650,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Color(0x000000).withOpacity(0.04), // 4% transparency
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 226),
              color: Colors.white,
              width: 300,
              child: NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                    _pageController.jumpToPage(index);
                  });
                },
                labelType: NavigationRailLabelType.all,
                backgroundColor: Colors.white,
                destinations: <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: buildIconWithLabel(
                      icon: CupertinoIcons.doc_text_search,
                      selectedIcon: CupertinoIcons.doc_text_search,
                      label: 'Sentiment Analysis',
                      isSelected: _selectedIndex == 0,
                    ),
                    label: const SizedBox.shrink(), // Keep label empty here
                  ),
                  NavigationRailDestination(
                    icon: buildIconWithLabel(
                      icon: CupertinoIcons.news_solid,
                      selectedIcon: CupertinoIcons.news_solid,
                      label: 'History',
                      isSelected: _selectedIndex == 1,
                    ),
                    label: const SizedBox.shrink(),
                  ),
                  NavigationRailDestination(
                    icon: buildIconWithLabel(
                      icon: CupertinoIcons.gear,
                      selectedIcon: CupertinoIcons.gear,
                      label: 'Settings',
                      isSelected: _selectedIndex == 2,
                    ),
                    label: const SizedBox.shrink(),
                  ),
                ],
                selectedIconTheme:
                    const IconThemeData(color: Color(0xFF0C356A)),
                unselectedIconTheme:
                    IconThemeData(color: const Color(0xFF747C85)),
                selectedLabelTextStyle:
                    TextStyle(color: const Color(0xFF747C85)),
              ),
            ),
            // const VerticalDivider(thickness: 0, width: 0),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: <Widget>[
                  Center(
                      child: sentimentanalysis(
                          username: ModalRoute.of(context)!.settings.arguments
                              as String)),
                  Center(
                      child: history(
                          username: ModalRoute.of(context)!.settings.arguments
                              as String)),
                  Center(
                      child: setting(
                          username: ModalRoute.of(context)!.settings.arguments
                              as String)),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 113,
          left: 23,
          child: Container(
              child: Row(
            children: [
              Image.asset(
                'assets/icons/Bitcoin-Logo.png',
                width: 70,
              ),
              Text('CryptoBERT',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0C356A),
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  )),
            ],
          )),
        ),
        Positioned(
          bottom: 82,
          left: 40,
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Row(
                children: [
                  Image.asset('assets/images/dashboard/logout.png'),
                  const SizedBox(
                    width: 11.96,
                  ),
                  Text('Logout',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      )),
                ],
              )),
        ),
      ]),
    );
  }

  Widget buildIconWithLabel({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
  }) {
    return Container(
      color: isSelected ? const Color(0xFFF5FAFF) : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(isSelected ? selectedIcon : icon),
            const SizedBox(width: 8),
            Text(label,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? const Color(0xFF0C356A)
                      : const Color(0xFF747C85),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                )),
          ],
        ),
      ),
    );
  }
}
