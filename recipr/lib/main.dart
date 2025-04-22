import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipr/screens/login_resigster.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ValueNotifier<Locale> _localeNotifier = ValueNotifier(Locale('en'));

  void _changeLanguage(String languageCode) {
    _localeNotifier.value = Locale(languageCode); // Update the locale globally
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: _localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recipes',
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 234, 234, 234),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Color(0xff8DB646),
            ),
          ),
          locale: locale, // Use the locale from the ValueNotifier
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('vi'),
            Locale('fr'),
          ],
          home: LoginRegisterPage(
            onChangeLanguage: _changeLanguage, // Pass the function to LoginRegisterPage
          ),
        );
      },
    );
  }
}
