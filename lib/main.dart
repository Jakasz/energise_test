import 'package:energise_test/data/provider/map_provider.dart';
import 'package:energise_test/data/provider/page_provider.dart';
import 'package:energise_test/generated/l10n.dart';
import 'package:energise_test/l10n/l10n.dart';
import 'package:energise_test/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PageProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MapProvider(),
          )
        ],
        child: MaterialApp(
          home: const MainScreen(),
          supportedLocales: L10n.all,
          locale: const Locale('de'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ));
  }
}
