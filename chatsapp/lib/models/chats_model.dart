class ChatModel {
  final String id;
  final String idUser;
  final String idRoom;
  final bool? isRead;
  final String content;
  final String dateSend;
  ChatModel(
      {required this.id,
      required this.idUser,
      required this.dateSend,
      required this.idRoom,
      this.isRead,
      required this.content});
}
