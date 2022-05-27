import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsapp/models/chats_model.dart';
import 'package:chatsapp/models/contact_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum TypesMess { file, text, img, video }

class ChannelChats extends StatefulWidget {
  const ChannelChats({required this.contactModel, Key? key}) : super(key: key);

  @override
  State<ChannelChats> createState() => _ChannelChatsState();
  final ContactModel contactModel;
}

class _ChannelChatsState extends State<ChannelChats> {
  TextEditingController editingController = TextEditingController();
  ScrollController listChatController = ScrollController();
  bool isTyping = false;
  Uuid uuid = const Uuid();

  Stream<List<ChatModel>> _chatList() async* {
    yield widget.contactModel.lastedMess!;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        widget.contactModel.imgPath!),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.contactModel.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.videocam,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.blue,
                      )),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: StreamBuilder<List<ChatModel>>(
              stream: _chatList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      controller: listChatController,
                      addAutomaticKeepAlives: false,
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        final it = snapshot.data?[i];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Bubble(
                            style: BubbleStyle(
                              nip: it!.idUser == widget.contactModel.id
                                  ? BubbleNip.rightCenter
                                  : BubbleNip.leftCenter,
                            ),
                            alignment: it.idUser == widget.contactModel.id
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            color: Colors.blue,
                            child: Text(
                              it.content,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data?.length);
                } else {
                  return Container();
                }
              }),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {
                  _filePicker();
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: editingController,
                  onSubmitted: (value) {
                    if (value != '') {
                      _addMessenger(editingController.text);
                    }
                    editingController.clear();
                    isTyping = false;
                    setState(() {});
                  },
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.image,
                              color: Colors.blue,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  if (editingController.text != '') {
                    _addMessenger(editingController.text);
                  } else {
                    _addMessenger('🖕');
                  }
                  editingController.clear();
                  isTyping = false;
                  setState(() {});
                },
                icon: Icon(
                  isTyping ? Icons.send : Icons.thumb_up,
                  color: Colors.blue,
                )),
          ],
        ),
      ],
    );
  }

  void _addMessenger(String content) {
    final it = widget.contactModel;

    it.lastedMess!.insert(
        it.lastedMess!.length,
        ChatModel(
            id: uuid.v4(),
            idUser: it.id,
            dateSend: '${DateTime.now()}',
            idRoom: '123',
            content: content));
    listChatController.jumpTo(listChatController.position.maxScrollExtent + 50);
  }

  void _filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String filename = basename(file.path);
      _addMessenger(filename);
    } else {
      // User canceled the picker
    }
    setState(() {});
  }
}
