import 'dart:async';

import 'package:chatsapp/models/contact_model.dart';
import 'package:chatsapp/page/row3/channel_chats.dart';
import 'package:chatsapp/utils/data_fake.dart';
import 'package:chatsapp/widgets/avatar_dot_green.dart';
import 'package:chatsapp/widgets/template_contac.dart';
import 'package:flutter/material.dart';

final StreamController<List<ContactModel>> _chatMessagesStreamController =
    StreamController<List<ContactModel>>.broadcast();

class ListContact extends StatefulWidget {
  const ListContact({Key? key}) : super(key: key);

  @override
  State<ListContact> createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  int indexContac = 0;
  bool isRead = false;
  ScrollController horizScroll = ScrollController();
  ScrollController vertiScroll = ScrollController();
  Stream<List<ContactModel>> _chat() {
    late final StreamController<List<ContactModel>> streamController;

    streamController = StreamController<List<ContactModel>>(onListen: () async {
      await Future.delayed(const Duration(milliseconds: 1500));

      streamController.add(contactList);
    });
    return streamController.stream;
  }

  @override
  void initState() {
    _chat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Chats',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                          textAlign: TextAlign.end,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_note,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 4,
                    height: 30,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                      cursorColor: Colors.grey[400],
                      decoration: InputDecoration(
                          fillColor: Colors.grey[400],
                          focusColor: Colors.grey[400],
                          hintText: 'Search here...',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.grey[400],
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF000000)),
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: horizScroll,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(contactList.length, (index) {
                        return InkWell(
                          onTap: () {
                            indexContac = index;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 70,
                              child: Column(
                                children: [
                                  CircleAvatarDotGreen(
                                      isOnl: contactList[index].isOnl!,
                                      imgPath: contactList[index].imgPath!),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      contactList[index].name,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: StreamBuilder<List<ContactModel>>(
                      stream: _chat(),
                      builder: (context, snapshot) {
                        return SingleChildScrollView(
                          controller: vertiScroll,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                snapshot.data?.length ?? contactList.length,
                                (i) {
                              final it = snapshot.data?[i];

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return TemplateContact(
                                func: () {
                                  indexContac = i;
                                  setState(() {});
                                },
                                name: it!.name,
                                lastedMes: it.lastedMess!.last.content,
                                imgPath: it.imgPath!,
                                isOnl: it.isOnl,
                              );
                            }),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 16,
            child: ChannelChats(
              contactModel: contactList[indexContac],
            ),
          ),
        ],
      ),
    );
  }
}
