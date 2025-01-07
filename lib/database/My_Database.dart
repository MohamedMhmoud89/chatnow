import 'package:chatnow/model/Message.dart';
import 'package:chatnow/model/My_User.dart';
import 'package:chatnow/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDatabase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (doc, _) => MyUser.fromFireStore(doc.data()!),
            toFirestore: (user, option) => user.toFireStore());
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (doc, _) => Room.fromFireStore(doc.data()!),
            toFirestore: (room, option) => room.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    var res = await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUserCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static Future<void> createRoom(Room room) {
    var docRef = getRoomCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> loadRooms() async {
    var querySnapshot = await getRoomCollection().get();
    return querySnapshot.docs
        .map(
          (queryDocSnapshot) => queryDocSnapshot.data(),
        )
        .toList();
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: (snapshot, options) =>
                Message.fromFireStore(snapshot.data()!),
            toFirestore: (message, options) => message.toFireStore());
  }

  static Future<void> sendMessage(String roomId, Message message) {
    var messageDoc = getMessageCollection(roomId).doc();
    message.id = messageDoc.id;
    return messageDoc.set(message);
  }
}
