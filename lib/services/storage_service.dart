import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

/// Firebase Storage Service
/// Handles image uploads and downloads for plant photos.
/// 
/// Architecture:
/// - Storage path: users/{uid}/plants/{plantId}/image
/// - Stores high-quality plant photos
/// - Returns download URLs for displaying in UI
/// - Automatically deletes old images when user uploads new ones
class StorageService {
  static final StorageService _instance = StorageService._internal();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Private constructor for singleton pattern
  StorageService._internal();

  /// Factory constructor to return singleton instance
  factory StorageService() {
    return _instance;
  }

  /// Upload plant image to Firebase Storage
  /// 
  /// Parameters:
  /// - uid: User's Firebase UID
  /// - plantId: Firestore plant document ID
  /// - imageFile: Image file from device (from image_picker)
  /// 
  /// Returns: Download URL for the uploaded image
  /// 
  /// This URL should be stored in the plant's Firestore document.
  /// Firebase manages CDN distribution globally for fast loading.
  Future<String> uploadPlantImage({
    required String uid,
    required String plantId,
    required File imageFile,
  }) async {
    try {
      // Storage path: users/{uid}/plants/{plantId}/image
      final reference = _storage.ref().child('users/$uid/plants/$plantId/image');

      // Delete existing image if it exists
      try {
        await reference.delete();
      } catch (_) {
        // Image doesn't exist yet, ignore error
      }

      // Upload new image
      final uploadTask = reference.putFile(imageFile);
      final snapshot = await uploadTask;

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  /// Upload image from File
  /// 
  /// Alternative method that accepts raw file data.
  Future<String> uploadImageFromBytes({
    required String uid,
    required String plantId,
    required List<int> imageBytes,
    String extension = 'jpg',
  }) async {
    try {
      final reference = _storage.ref().child('users/$uid/plants/$plantId/image.$extension');

      // Delete existing image if it exists
      try {
        await reference.delete();
      } catch (_) {
        // Image doesn't exist yet, ignore error
      }

      // Upload bytes
      final uploadTask = reference.putData(
        Uint8List.fromList(imageBytes),
        SettableMetadata(contentType: 'image/$extension'),
      );
      final snapshot = await uploadTask;

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  /// Delete plant image from Storage
  /// 
  /// Called when:
  /// - User deletes a plant
  /// - User uploads a new image (replaces old one)
  /// - User clears the image from a plant
  Future<void> deleteImage({
    required String uid,
    required String plantId,
  }) async {
    try {
      final reference = _storage.ref().child('users/$uid/plants/$plantId/image');
      await reference.delete();
    } catch (e) {
      // Image might not exist, don't throw error
      print('Note: Image may not exist - $e');
    }
  }

  /// Delete image by specific path
  /// 
  /// Use this if you have the full storage path.
  Future<void> deleteImageByPath(String path) async {
    try {
      await _storage.ref().child(path).delete();
    } catch (e) {
      print('Note: Could not delete image - $e');
    }
  }

  /// Get download URL for existing image
  /// 
  /// Useful for retrieving URLs from Firestore without re-uploading.
  /// This is fast because it doesn't transfer data.
  Future<String> getDownloadUrl({
    required String uid,
    required String plantId,
  }) async {
    try {
      final reference = _storage.ref().child('users/$uid/plants/$plantId/image');
      return await reference.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get image URL: $e');
    }
  }

  /// Check if image exists
  /// 
  /// Returns true if image file exists in Storage.
  Future<bool> imageExists({
    required String uid,
    required String plantId,
  }) async {
    try {
      final reference = _storage.ref().child('users/$uid/plants/$plantId/image');
      await reference.getMetadata();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get image file size
  /// 
  /// Useful for showing upload progress or checking limits.
  Future<int?> getImageSize({
    required String uid,
    required String plantId,
  }) async {
    try {
      final reference = _storage.ref().child('users/$uid/plants/$plantId/image');
      final metadata = await reference.getMetadata();
      return metadata.size;
    } catch (e) {
      return null;
    }
  }

  /// Delete all images for a user
  /// 
  /// Called when user deletes their account.
  /// WARNING: Permanent operation.
  Future<void> deleteUserImages(String uid) async {
    try {
      final reference = _storage.ref().child('users/$uid');
      await reference.listAll().then((result) async {
        for (final item in result.prefixes) {
          // Recursively delete all subdirectories
          await _deleteDirectoryRecursive(item);
        }
        for (final item in result.items) {
          await item.delete();
        }
      });
    } catch (e) {
      throw Exception('Failed to delete user images: $e');
    }
  }

  /// Recursively delete Firebase Storage directory
  Future<void> _deleteDirectoryRecursive(Reference ref) async {
    try {
      final result = await ref.listAll();
      for (final item in result.prefixes) {
        await _deleteDirectoryRecursive(item);
      }
      for (final item in result.items) {
        await item.delete();
      }
    } catch (e) {
      print('Error deleting directory: $e');
    }
  }

  /// Create shareable link for plant image
  /// 
  /// Returns URL that can be shared with other users.
  /// Link has no expiration (as long as image exists).
  Future<String> getShareableImageUrl({
    required String uid,
    required String plantId,
  }) async {
    try {
      final reference = _storage.ref().child('users/$uid/plants/$plantId/image');
      return await reference.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to generate shareable link: $e');
    }
  }
}
