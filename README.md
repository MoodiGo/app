# moodigo_app

## FOLDER STRUCTURE
```
├───.dart_tool
│   ├───dartpad
│   ├───extension_discovery
│   └───flutter_build
│       └───e62cc8210cbd495038e791ce8da63313
├───.idea
│   ├───libraries
│   └───runConfigurations
├───android
│   ├───app
│   │   └───src
│   │       ├───debug
│   │       ├───main
│   │       │   ├───java
│   │       │   │   └───io
│   │       │   │       └───flutter
│   │       │   │           └───plugins
│   │       │   ├───kotlin
│   │       │   │   └───com
│   │       │   │       └───example
│   │       │   │           └───moodigo_app
│   │       │   └───res
│   │       │       ├───drawable
│   │       │       ├───drawable-v21
│   │       │       ├───mipmap-hdpi
│   │       │       ├───mipmap-mdpi
│   │       │       ├───mipmap-xhdpi
│   │       │       ├───mipmap-xxhdpi
│   │       │       ├───mipmap-xxxhdpi
│   │       │       ├───values
│   │       │       └───values-night
│   │       └───profile
│   └───gradle
│       └───wrapper
├───assets
│   ├───fonts
│   ├───icons
│   └───images
├───build
│   ├───e27675abb80c23477dc8191d609594c5
│   ├───flutter_assets
│   │   ├───fonts
│   │   └───shaders
│   ├───native_assets
│   │   └───windows
│   └───windows
│       └───x64
│           ├───CMakeFiles
│           │   ├───3.20.21032501-MSVC_2
│           │   │   ├───CompilerIdCXX
│           │   │   │   ├───Debug
│           │   │   │   │   └───CompilerIdCXX.tlog
│           │   │   │   └───tmp
│           │   │   └───x64
│           │   │       └───Debug
│           │   │           └───VCTargetsPath.tlog
│           │   ├───4452b17cab635e030b0ec502a4aa8dd3
│           │   ├───75720a4e39b61c861e76a9f5360b42cd
│           │   ├───9c60d52448178d2762916fd1f02d3b70
│           │   ├───b3926d99d3e4b7dd0f2211be598c8dc1
│           │   └───CMakeTmp
│           ├───flutter
│           │   ├───CMakeFiles
│           │   ├───Debug
│           │   ├───flutter_wrapper_app.dir
│           │   │   └───Debug
│           │   │       └───flutter_.619B0AE7.tlog
│           │   ├───flutter_wrapper_plugin.dir
│           │   │   └───Debug
│           │   │       └───flutter_.B16C5FC0.tlog
│           │   └───x64
│           │       └───Debug
│           │           └───flutter_assemble
│           │               └───flutter_assemble.tlog
│           ├───runner
│           │   ├───CMakeFiles
│           │   ├───Debug
│           │   │   └───data
│           │   │       └───flutter_assets
│           │   │           ├───fonts
│           │   │           └───shaders
│           │   └───moodigo_app.dir
│           │       └───Debug
│           │           └───moodigo_app.tlog
│           └───x64
│               └───Debug
│                   ├───ALL_BUILD
│                   │   └───ALL_BUILD.tlog
│                   ├───INSTALL
│                   │   └───INSTALL.tlog
│                   └───ZERO_CHECK
│                       └───ZERO_CHECK.tlog
├───ios
│   ├───Flutter
│   ├───Runner
│   │   ├───Assets.xcassets
│   │   │   ├───AppIcon.appiconset
│   │   │   └───LaunchImage.imageset
│   │   └───Base.lproj
│   ├───Runner.xcodeproj
│   │   ├───project.xcworkspace
│   │   │   └───xcshareddata
│   │   └───xcshareddata
│   │       └───xcschemes
│   ├───Runner.xcworkspace
│   │   └───xcshareddata
│   └───RunnerTests
└───lib
    ├───config
    ├───core
    │   ├───constants
    │   ├───error
    │   ├───network
    │   ├───router
    │   └───utils
    ├───features
    │   └───auth
    │       ├───application
    │       ├───data
    │       │   ├───datasources
    │       │   ├───models
    │       │   └───repositories
    │       ├───domain
    │       │   ├───entities
    │       │   ├───repositories
    │       │   └───usecases
    │       └───presentation
    │           ├───pages
    │           ├───providers
    │           └───widgets
    ├───l10n
    ├───providers
    └───shared
        ├───services
        └───widgets
            └───primary_button
```

## PROVIDERS ORGANIZATION

### STATE PROVIDERS - StateProvider
Used for simple state that can change. Good for primitive values (booleans, strings, numbers) that need to be modified.

#### EXAMPLE
dart```
// Example: Toggle for a setting
final isDarkModeProvider = StateProvider<bool>((ref) => false);
// Usage: ref.read(isDarkModeProvider.notifier).state = true;
```

### STATE PROVIDERS - StateNotifierProvider
For more complex state objects with custom logic. Used with a StateNotifier class that encapsulates the state manipulation logic.

#### EXAMPLE
dart```
// Example: Cart management with multiple operations
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState.initial());
  
  void addItem(Product product) {
    state = state.copyWith(items: [...state.items, product]);
  }
  
  void removeItem(int id) {
    state = state.copyWith(
      items: state.items.where((item) => item.id != id).toList()
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
// Usage: ref.read(cartProvider.notifier).addItem(product);
```

### READONLY PROVIDERS - Provider
Provider: For computed values or dependencies that don't change. Good for services, repositories, and other dependencies.

#### EXAMPLE
dart```
// Example: Repository instance
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(httpClientProvider));
});
// Usage: ref.watch(authRepositoryProvider).getCurrentUser();
```

### FUTURE PROVIDERS - FutureProvider
For async data that needs to be loaded once or refreshed occasionally. Manages loading, error, and data states automatically.

#### EXAMPLE
dart```
// Example: Fetching user profile data
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.fetchUserProfile();
});
// Usage: final userAsync = ref.watch(userProfileProvider);
// userAsync.when(
//   data: (data) => UserProfileView(data),
//   loading: () => LoadingIndicator(),
//   error: (error, stack) => ErrorView(error),
// )
```

### STREAM PROVIDERS - StreamProvider
For data that updates continuously from a stream. Perfect for real-time data or things that need to be kept in sync.

#### EXAMPLE
dart```
// Usage: Similar to FutureProvider but for streams
// chatMessagesAsync.when(
//   data: (messages) => ChatView(messages),
//   loading: () => LoadingIndicator(),
//   error: (error, stack) => ErrorView(error),
// )

## APP STRUCTURE

### CONFIGURATION
- Holds constants and configuration settings for the app.

### CORE
- Core functionality and utilities.
- Constants: Common constants used throughout the app.
- Error: Error handling and custom error classes.
- Network: Network-related utilities and configurations.
- Router: Routing and navigation logic.
- Utils: General utility functions.

### FEATURES
- Organized by feature, each containing its own application, data, domain, and presentation layers.
- Auth: Authentication feature with its own structure.

### L10N
- Localization files for supporting multiple languages.

### PROVIDERS
- Global providers that are not feature-specific.

### SHARED
- Shared widgets and services that can be reused across different features.
final chatMessagesProvider = StreamProvider<List<Message>>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getMessagesStream(chatId);
});
// Usage: Similar to FutureProvider but for streams

