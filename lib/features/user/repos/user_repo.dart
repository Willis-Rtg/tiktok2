import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/features/auth/repos/auth_repo.dart';
import 'package:tiktok2/features/user/models/user_profile_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> setAvatar(String filename, File file) async {
    final fileRef = _storage.ref().child("avatars/$filename");
    await fileRef.putFile(file);
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }
}

final userRepoProvider = Provider<UserRepo>((ref) {
  return UserRepo();
});
