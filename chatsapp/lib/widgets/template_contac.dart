import 'package:chatsapp/widgets/avatar_dot_green.dart';
import 'package:flutter/material.dart';

class TemplateContact extends StatelessWidget {
  const TemplateContact({
    Key? key,
    required this.name,
    required this.lastedMes,
    required this.imgPath,
    this.isOnl = false,
  }) : super(key: key);
  final String name;
  final String lastedMes;
  final String imgPath;
  final bool? isOnl;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatarDotGreen(
        imgPath: imgPath,
        isOnl: isOnl!,
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        lastedMes,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
      trailing: Text(
        '${DateTime.now().day}',
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
