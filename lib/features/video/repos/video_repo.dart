import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok2/features/video/models/video_model.dart';

class VideoRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UploadTask> uploadVideo(File file, String uid) async {
    final fileRef = _storage.ref().child(
      "videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
    );
    return fileRef.putFile(file);
  }

  Future<void> saveVideo(VideoModel video) async {
    await _db.collection("videos").add(video.toJson());
  }

  // create a video document
}

final videoRepoProvider = Provider<VideoRepo>((ref) {
  return VideoRepo();
});
