import 'package:cloud_firestore/cloud_firestore.dart';

/// Service for handling Cloud Firestore database operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create or update user profile
  Future<void> saveUserProfile({
    required String uid,
    required String email,
    required String displayName,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error saving user profile: $e');
    }
  }

  /// Get user profile data
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }

  /// Stream of user profile data (real-time updates)
  Stream<DocumentSnapshot> streamUserProfile(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  /// Add an eco-tip (note/action) for a user
  Future<String> addEcoTip({
    required String uid,
    required String title,
    required String description,
    required String category,
  }) async {
    try {
      final docRef = await _firestore
          .collection('users')
          .doc(uid)
          .collection('ecoTips')
          .add({
        'title': title,
        'description': description,
        'category': category,
        'completed': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      throw Exception('Error adding eco tip: $e');
    }
  }

  /// Get all eco-tips for a user
  Stream<QuerySnapshot> streamUserEcoTips(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('ecoTips')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Update an eco-tip
  Future<void> updateEcoTip({
    required String uid,
    required String tipId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('ecoTips')
          .doc(tipId)
          .update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating eco tip: $e');
    }
  }

  /// Mark eco-tip as completed
  Future<void> toggleEcoTipCompletion({
    required String uid,
    required String tipId,
    required bool completed,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('ecoTips')
          .doc(tipId)
          .update({
        'completed': completed,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error toggling eco tip: $e');
    }
  }

  /// Delete an eco-tip
  Future<void> deleteEcoTip({
    required String uid,
    required String tipId,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('ecoTips')
          .doc(tipId)
          .delete();
    } catch (e) {
      throw Exception('Error deleting eco tip: $e');
    }
  }

  /// Get user statistics (count of tips, completed, etc.)
  Future<Map<String, dynamic>> getUserStats(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('ecoTips')
          .get();

      int total = snapshot.docs.length;
      int completed =
          snapshot.docs.where((doc) => doc['completed'] == true).length;
      int pending = total - completed;

      return {
        'totalTips': total,
        'completedTips': completed,
        'pendingTips': pending,
        'completionRate':
            total == 0 ? 0 : ((completed / total) * 100).toStringAsFixed(1),
      };
    } catch (e) {
      throw Exception('Error fetching user stats: $e');
    }
  }
}
