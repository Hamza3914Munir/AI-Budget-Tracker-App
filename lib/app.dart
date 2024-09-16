import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/firstProvider.dart';
import 'app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => FirstProvider())
    ],
    child: MyAppView(),
    );
  }
}
