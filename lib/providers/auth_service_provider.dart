import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodigo_app/providers/firebase_auth_provider.dart';
import 'package:moodigo_app/shared/services/firebase_auth_service.dart';

final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(ref.watch(firebaseAuthProvider));
});