import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUser(String username) async {
    return await Firestore.instance
        .collection("User")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserbyemail(String userEmail) async {
    return await Firestore.instance
        .collection("User")
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  uploadUserInfo(String user, userMap) {
    Firestore.instance
        .collection("User")
        .document(user)
        .setData(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  updateLocation(String user, locationMap) {
    Firestore.instance.collection("User").document(user).updateData(locationMap);
  }

  setLocation(String user, locationMap) {
    Firestore.instance
        .collection("User")
        .document(user)
        .collection("location")
        .add(locationMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("chatroom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addMessages(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("chatroom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getMessages(String chatRoomId) async {
    return await Firestore.instance
        .collection("chatroom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await Firestore.instance
        .collection("chatroom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  getAllUser() async {
    return await Firestore.instance.collection("User").snapshots();
  }

  getSingleLocation(String username) async {
    return await Firestore.instance
        .collection("User")
        .document(username)
        .collection("location")
        .getDocuments();
  }
}
