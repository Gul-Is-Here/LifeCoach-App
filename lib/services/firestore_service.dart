// LAYER: Services (Layer 3)
// PURPOSE: Single wrapper around FirebaseFirestore SDK.
//          Controllers and repositories NEVER import cloud_firestore directly —
//          they always call methods on this service.
// USED BY: All XxxRepository classes

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Base collection reference under a user's document
  // e.g. collection(uid, 'habits') → users/{uid}/habits
  CollectionReference<Map<String, dynamic>> collection(
    String uid,
    String name,
  ) {
    return _db.collection('users').doc(uid).collection(name);
  }

  // Single document reference
  DocumentReference<Map<String, dynamic>> doc(
    String uid,
    String col,
    String id,
  ) {
    return _db.collection('users').doc(uid).collection(col).doc(id);
  }
}
