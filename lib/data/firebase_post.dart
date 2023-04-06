import 'dart:io';

import 'package:app/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebasePost {
  static final _post = FirebaseFirestore.instance.collection("posts");
  static final _reference = FirebaseStorage.instance.ref();
  static Future<void> addPost(PostModel postModel) async {
    await _post.add(postModel.toMap());
  }

  static Stream<List<PostModel>> getPosts() {
    var snapShot = _post.orderBy("date", descending: true).snapshots();

    final postModels = snapShot.map((event) {
      return event.docs.map((e) => PostModel.fromMap(e.data())).toList();
    });
    return postModels;
  }

  static Future<String?> uploadWithGetURL(pickerImage) async {
    if (pickerImage == null) return null;
    final imageName = pickerImage!.name;
    final image = File(pickerImage!.path!);
    try {
      final ref = _reference.child(imageName);
      final uploadTask = ref.putFile(image);
      final snapShot = await uploadTask.whenComplete(() {});
      return await snapShot.ref.getDownloadURL();
    } catch (e) {
      print("ERORR");
      return null;
    }
  }
}
