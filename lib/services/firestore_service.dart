import 'package:cloud_firestore/cloud_firestore.dart';

/// Plant data model for Firestore
class Plant {
  final String id; // Firestore document ID
  final String name;
  final String watering; // e.g., "Every 2 days"
  final String sunlight; // e.g., "Bright indirect"
  final String fertilizer; // e.g., "Monthly"
  final String repotting; // e.g., "Spring"
  final String problems; // e.g., "None"
  final String imageUrl; // Firebase Storage download URL
  final DateTime createdAt;
  
  // Track watering for maintenance
  int wateringCount;
  DateTime? lastWatered;

  Plant({
    required this.id,
    required this.name,
    required this.watering,
    required this.sunlight,
    required this.fertilizer,
    required this.repotting,
    required this.problems,
    this.imageUrl = '',
    DateTime? createdAt,
    this.wateringCount = 0,
    this.lastWatered,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Convert Plant to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'watering': watering,
      'sunlight': sunlight,
      'fertilizer': fertilizer,
      'repotting': repotting,
      'problems': problems,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'wateringCount': wateringCount,
      'lastWatered': lastWatered != null ? Timestamp.fromDate(lastWatered!) : null,
    };
  }

  /// Create Plant from Firestore document
  factory Plant.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Plant(
      id: doc.id,
      name: data['name'] ?? '',
      watering: data['watering'] ?? '',
      sunlight: data['sunlight'] ?? '',
      fertilizer: data['fertilizer'] ?? '',
      repotting: data['repotting'] ?? '',
      problems: data['problems'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      wateringCount: data['wateringCount'] ?? 0,
      lastWatered: (data['lastWatered'] as Timestamp?)?.toDate(),
    );
  }
}

/// Firestore Database Service
/// Handles all plant data operations with real-time sync.
/// 
/// Architecture:
/// - users/{uid}/plants - Subcollection containing user's plants
/// - Each plant document contains care instructions and metadata
/// - Real-time streams allow UI to update instantly when data changes
/// - No manual database polling needed - Firestore handles it
class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Private constructor for singleton pattern
  FirestoreService._internal();

  /// Factory constructor to return singleton instance
  factory FirestoreService() {
    return _instance;
  }

  /// Reference to user's plants subcollection
  CollectionReference<Plant> _plantsCollection(String uid) {
    return _firestore.collection('users').doc(uid).collection('plants').withConverter<Plant>(
      fromFirestore: (doc, _) => Plant.fromFirestore(doc),
      toFirestore: (plant, _) => plant.toFirestore(),
    );
  }

  /// Get real-time stream of user's plants
  /// 
  /// This stream rebuilds the UI whenever:
  /// - A new plant is added
  /// - A plant is modified
  /// - A plant is deleted
  /// 
  /// Perfect for StreamBuilder in HomeScreen.
  /// Database listens for changes - UI doesn't poll.
  Stream<List<Plant>> getPlantsStream(String uid) {
    return _plantsCollection(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Get single plant by ID
  Future<Plant?> getPlant(String uid, String plantId) async {
    try {
      final doc = await _plantsCollection(uid).doc(plantId).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      throw Exception('Failed to fetch plant: $e');
    }
  }

  /// Add new plant to Firestore
  /// 
  /// Returns the generated plant ID from Firestore.
  /// This ID is used for future updates and deletions.
  Future<String> addPlant(String uid, Plant plant) async {
    try {
      final docRef = await _plantsCollection(uid).add(plant);
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add plant: $e');
    }
  }

  /// Update existing plant
  /// 
  /// Merges changes with existing data (doesn't overwrite everything).
  /// Firestore timestamp automatically updated.
  Future<void> updatePlant(
    String uid,
    String plantId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _plantsCollection(uid).doc(plantId).update(data);
    } catch (e) {
      throw Exception('Failed to update plant: $e');
    }
  }

  /// Delete plant from Firestore
  /// 
  /// This removes the plant document.
  /// Associated images should be deleted from Storage separately.
  Future<void> deletePlant(String uid, String plantId) async {
    try {
      await _plantsCollection(uid).doc(plantId).delete();
    } catch (e) {
      throw Exception('Failed to delete plant: $e');
    }
  }

  /// Increment watering count
  /// 
  /// Called when user marks plant as watered.
  /// Updates wateringCount and lastWatered timestamp.
  Future<void> incrementWateringCount(String uid, String plantId) async {
    try {
      await _plantsCollection(uid).doc(plantId).update({
        'wateringCount': FieldValue.increment(1),
        'lastWatered': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to update watering: $e');
    }
  }

  /// Search plants by name
  /// 
  /// Simple client-side search for small datasets.
  /// For large datasets, use Firestore full-text search.
  Future<List<Plant>> searchPlants(String uid, String query) async {
    try {
      final snapshot = await _plantsCollection(uid).get();
      final plants = snapshot.docs.map((doc) => doc.data()).toList();
      return plants
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search plants: $e');
    }
  }

  /// Create default user document
  /// 
  /// Called after signup to initialize user profile.
  /// This ensures user collection exists.
  Future<void> createUserDocument(String uid, String email) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'createdAt': Timestamp.now(),
        'plantsCount': 0,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to create user document: $e');
    }
  }

  /// Delete user's entire data (including all plants)
  /// 
  /// WARNING: Permanent operation. Use with caution.
  /// Should be called when user deletes account.
  Future<void> deleteUserData(String uid) async {
    try {
      // Get all plants
      final plants = await _plantsCollection(uid).get();
      
      // Delete each plant
      for (final doc in plants.docs) {
        await doc.reference.delete();
      }
      
      // Delete user document
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user data: $e');
    }
  }
}
