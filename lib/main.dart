import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodigo_app/core/router/app_router.dart';
import 'package:moodigo_app/config/firebase_options.dart';
import 'package:moodigo_app/providers/auth_service_provider.dart';
import 'package:moodigo_app/providers/auth_state_provider.dart';
import 'i18n/generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Moodigo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authServiceProvider).signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text(localizations?.helloWorld ?? 'aaa World!'),
          Text(authState.valueOrNull?.uid ?? 'No user'),
        ],
      ),
    );
  }
}

class TestSigninPage extends ConsumerWidget {
  const TestSigninPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);
    
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        children: [
          Text("sign in page - ${dotenv.env["FIREBASE_OPTIONS_IOS_APP_ID"]}"),
          ElevatedButton(onPressed: () => authService.signInWithEmail("marinho.claramb@gmail.com", "Moodigo@123"), child: Text("Sign In")),
        ],
      ),
    );
  }
}
