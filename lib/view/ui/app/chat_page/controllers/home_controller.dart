import 'package:app/view/ui/app/chat_room/views/chat_room_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> chatsStream(String email) {
    return firestore
        .collection('user')
        .doc(email)
        .collection("chats")
        .orderBy("lastTime", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email) {
    return firestore.collection('user').doc(email).snapshots();
  }

  void goToChatRoom(String chat_id, String email, String friendEmail) async {
    CollectionReference chats = firestore.collection('chats');
    CollectionReference users = firestore.collection('user');

    final updateStatusChat = await chats
        .doc(chat_id)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chat_id)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(email)
        .collection("chats")
        .doc(chat_id)
        .update({"total_unread": 0});
    Get.to(() => ChatRoomView(
          arguments: {
            "chat_id": chat_id,
            "friendEmail": friendEmail,
          },
        ));
  }
}
