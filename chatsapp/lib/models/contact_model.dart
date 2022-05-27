import 'package:chatsapp/models/chats_model.dart';

class ContactModel {
  final String id;
  final String name;
  final List<ChatModel>? lastedMess;
  final String? imgPath;
  final bool? isOnl;

  ContactModel(
      {required this.id,
      required this.name,
      required this.imgPath,
      this.lastedMess,
      this.isOnl = false});
}
