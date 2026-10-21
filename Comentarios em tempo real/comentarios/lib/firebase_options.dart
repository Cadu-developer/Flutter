import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Arquivo temporário para permitir a compilação antes da configuração.
/// Execute `dart pub global run flutterfire_cli:flutterfire configure`.
/// O FlutterFire CLI deve substituir este arquivo por suas opções reais.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnsupportedError(
      'Firebase ainda não configurado. Execute '
      '`dart pub global run flutterfire_cli:flutterfire configure` '
      'e gere as opções para este aplicativo.',
    );
  }
}
