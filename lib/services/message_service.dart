import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class MessageService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessagesByUserId({int? userId}) {
    // try {
    //   return _db
    //       .collection('messages')
    //       .where('userId', isEqualTo: userId)
    //       .snapshots()
    //       .map((snapshot) => snapshot.docs
    //           .map((doc) => MessageModel.fromJson(doc.data()))
    //           .toList());
    // } catch (e) {
    //   print(e);
    // }

    try {
      return _db
          .collection('messages')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((list) {
        var result = list.docs.map((message) {
          print(message.data());
          return MessageModel.fromJson(message.data());
        }).toList();

        result.sort((MessageModel a, MessageModel b) =>
            a.createdAt!.compareTo(b.createdAt!));

        return result;
      });
    } catch (e) {
      throw Exception('Exception is: ${e}');
    }
  }

  Future<void> sendMessage(UserModel user, String message, bool isFromUser,
      ProductModel product) async {
    try {
      _db.collection('messages').add({
        'message': message,
        'userId': user.id,
        'userName': user.username,
        'userImg': user.urlPhoto,
        'isFromUser': isFromUser,
        'product': product is UninitializedProductModel ? {} : product.toJson(),
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      }).then((value) => print('Message sent!'));
    } catch (e) {
      throw Exception('Error sending message: ${e}');
    }
  }
}
