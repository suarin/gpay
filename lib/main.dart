import 'package:flutter/material.dart';
import 'package:gpay/screens/startup_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GPayApp()  );
}

class GPayApp extends StatelessWidget {
  const GPayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  StartupScreen(),
      title: 'Global Payment Services',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: [
        Locale('en',''),
        Locale('es',''),
      ],
    );
  }
}
