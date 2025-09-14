import 'package:amazon_clone_1/Router.dart';
import 'package:amazon_clone_1/features/admin/screen/Admin_Screen.dart';
import 'package:amazon_clone_1/features/auth/services/auth_services.dart';
import 'package:amazon_clone_1/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/BottomBar.dart';
import 'constants/GlobalVariables.dart';
import 'features/auth/screens/AuthScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Auth_Services auth = Auth_Services();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      auth.getuserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
            backgroundColor: GlobalVariables.secondaryColor,
            elevation: 0,
            iconTheme: IconThemeData(color: Color.fromARGB(255, 243, 232, 232)),
          ),
        ),
        onGenerateRoute: ((settings) => GenerateRoute(settings)),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const Admin_Screen()
            : const Auth_Screen());
  }
}
