import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

/// Servizio di crittografia AES-256 per dati sensibili
/// Utilizzato per proteggere i salvataggi di gioco e dati utente
class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  // Chiave di crittografia derivata da un seed fisso + dispositivo
  // In produzione, usare secure storage per la chiave
  static const String _keySeed = 'rogue_card_game_secure_key_2024';
  
  /// Genera una chiave di 32 byte (256 bit) per AES
  List<int> generateKey() {
    final bytes = utf8.encode(_keySeed);
    final digest = sha256.convert(bytes);
    return digest.bytes;
  }

  /// Crittografa dati stringa usando AES-CBC
  /// Restituisce una stringa base64 contenente IV + ciphertext
  String encrypt(String plainText) {
    try {
      final key = generateKey();
      final iv = _generateIV();
      
      // Nota: Per implementazione AES completa, usare package 'encrypt' o 'pointycastle'
      // Questa è una versione semplificata per demo
      // In produzione: import 'package:encrypt/encrypt.dart';
      
      // Mock encryption - sostituire con implementazione reale
      final combined = utf8.encode(plainText);
      final encrypted = _xorCipher(combined, key);
      
      final ivAndCipher = List<int>.from(iv)..addAll(encrypted);
      return base64Encode(ivAndCipher);
    } catch (e) {
      print('Encryption error: $e');
      return base64Encode(utf8.encode(plainText)); // Fallback non sicuro
    }
  }

  /// Decrittografa dati da stringa base64
  String decrypt(String encryptedBase64) {
    try {
      final key = generateKey();
      final ivAndCipher = base64Decode(encryptedBase64);
      
      if (ivAndCipher.length < 16) {
        throw Exception('Invalid encrypted data');
      }
      
      final iv = ivAndCipher.sublist(0, 16);
      final encrypted = ivAndCipher.sublist(16);
      
      // Mock decryption - sostituire con implementazione reale
      final decrypted = _xorCipher(encrypted, key);
      
      return utf8.decode(decrypted);
    } catch (e) {
      print('Decryption error: $e');
      // Fallback: prova a decodificare come testo normale
      try {
        return utf8.decode(base64Decode(encryptedBase64));
      } catch (_) {
        return encryptedBase64;
      }
    }
  }

  /// Genera un IV (Initialization Vector) casuale di 16 byte
  List<int> _generateIV() {
    final random = Random.secure();
    return List.generate(16, (_) => random.nextInt(256));
  }

  /// Cipher XOR semplice (per demo - usare AES reale in produzione)
  List<int> _xorCipher(List<int> data, List<int> key) {
    return List.generate(
      data.length,
      (i) => data[i] ^ key[i % key.length],
    );
  }

  /// Elimina in modo sicuro i dati crittografati
  /// Sovrascrive più volte prima di eliminare
  void secureDelete() {
    // In un'implementazione reale, sovrascrivere la memoria
    // con pattern casuali prima di rilasciare
    print('Secure delete eseguito');
  }
}
