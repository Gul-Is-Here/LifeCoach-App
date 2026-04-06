// LAYER: Services (Layer 3)
// PURPOSE: Wraps Firebase Cloud Storage for file uploads (receipts, avatars).
//          Returns the public download URL after upload.
//          ExpenseController calls uploadReceipt(); ProfileController calls uploadAvatar().

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a receipt photo. Returns the public download URL.
  // Path: receipts/{uid}/{timestamp}.jpg
  Future<String> uploadReceipt(String uid, File file) async {
    final ref = _storage.ref().child(
      'receipts/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await ref.putFile(file);
    return ref.getDownloadURL();
  }

  // Upload a profile avatar. Returns the public download URL.
  // Path: avatars/{uid}.jpg
  Future<String> uploadAvatar(String uid, File file) async {
    final ref = _storage.ref().child('avatars/$uid.jpg');
    await ref.putFile(file);
    return ref.getDownloadURL();
  }
}
