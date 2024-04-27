import 'package:energise_test/data/provider/page_provider.dart';
import 'package:energise_test/presentation/pages/first_screen.dart';
import 'package:energise_test/presentation/pages/second_screen.dart';
import 'package:energise_test/presentation/pages/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Widget> _pageBody = [
  const FirstScreen(),
  SecondScreen(),
  const ThirdScreen(),
];

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(builder: (context, pageProvider, child) {
      return Scaffold(
        body: _pageBody[pageProvider.pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.abc,
                ),
                label: AppLocalizations.of(context)!.first),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.face,
                ),
                label: AppLocalizations.of(context)!.second),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.monetization_on,
                ),
                label: AppLocalizations.of(context)!.third)
          ],
          currentIndex: pageProvider.pageIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          onTap: (value) => pageProvider.changePageIndex(value),
        ),
      );
    });
  }
}
