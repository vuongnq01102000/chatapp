import 'package:chatsapp/utils/data_fake.dart';
import 'package:chatsapp/widgets/avatar_dot_green.dart';
import 'package:chatsapp/widgets/template_contac.dart';
import 'package:flutter/material.dart';

class ListContact extends StatelessWidget {
  const ListContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        excludeHeaderSemantics: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Chats',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
        bottom: PreferredSize(
          preferredSize: const Size(double.maxFinite, 50),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 4,
            height: 50,
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                      borderSide: const BorderSide(color: Color(0xFF000000)),
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      contactList.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(left: 17),
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
                          )),
                ),
              )),
          Expanded(
            flex: 7,
            child: ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, i) {
                  return TemplateContact(
                    name: contactList[i].name,
                    lastedMes: contactList[i].lastedMess!,
                    imgPath: contactList[i].imgPath!,
                    isOnl: contactList[i].isOnl,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
