import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodigo_app/core/router/app_router.dart';
import 'package:moodigo_app/providers/auth_state_provider.dart';
import 'i18n/generated/app_localizations.dart'; // ✅ Correct import

void main() {
  runApp( 
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider); 
    return MaterialApp.router(
      // LOCALIZATION
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ROUTER
      routerConfig: router,

      // APP INFO
      title: 'Moodigo',
    );
  }
}

class TestHomePage extends ConsumerWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        children: [
          
          Text(localizations?.helloWorld ?? 'aaa World!'),
          ElevatedButton(
            onPressed: () {
              // Toggle authentication state when the button is pressed
              ref.read(authStateProvider.notifier).state = !ref.read(authStateProvider.notifier).state;
            },
            child: Text('Toggle Login Status'),
          ),
        ],
      ),
    );
  }
}

class TestSigninPage extends ConsumerWidget {
  const TestSigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        children: [
          Text("sign in page"),
          ElevatedButton(
            onPressed: () {
              // Toggle authentication state when the button is pressed
              ref.read(authStateProvider.notifier).state = !ref.read(authStateProvider.notifier).state;
            },
            child: Text('Toggle Login Status'),
          ),
        ],
      ),
    );
  }
}
