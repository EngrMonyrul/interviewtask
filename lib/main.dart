import 'package:flutter/material.dart';
import 'package:interviewtask/controls/providers/home_page_provider.dart';
import 'package:interviewtask/models/database.dart';
import 'package:interviewtask/views/homePage/home_page_view.dart';
import 'package:provider/provider.dart';

import 'controls/utils/app_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHandler databaseHandler = DatabaseHandler();
  await databaseHandler.createDatabase();
  runApp(MyApp(databaseHandler: databaseHandler));
}

class MyApp extends StatelessWidget {
  final DatabaseHandler databaseHandler;

  const MyApp({super.key, required this.databaseHandler});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
      ],
      child: MaterialApp(
        title: 'InterviewTask',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: appThemeData(),
        // home: const HomePageView(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePageView(databaseHandler: databaseHandler),
        },
      ),
    );
  }
}
