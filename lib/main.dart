import 'package:flutter/material.dart';
import 'package:offiql_techno_assign/widgets/screens/home_screen.dart';
import 'package:offiql_techno_assign/widgets/state_controller/controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      //Intgretion Provider State Management
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProviderStateController(), //this is a state controller
            child: const HomeScreen(),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  MaterialApp build(BuildContext context) {
    return MaterialApp(
      title: 'Offiql Techno',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Fredoka",
      ),
      home: const HomeScreen(), //DashBoard Screen
    );
  }
}
