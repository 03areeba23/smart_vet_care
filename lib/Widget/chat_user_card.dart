import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:smart_vet_care/controllers/auth_controller.dart';
import 'package:smart_vet_care/model/chat_doctor.dart';
import 'package:smart_vet_care/screen/ChatDetailScreen.dart';

import '../model/chat_messages_model.dart';

class ChatUserCard extends StatefulWidget {
  final ChatDoctor doctor;
  const ChatUserCard({Key? key, required this.doctor}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {

  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetail(doctor: widget.doctor,)));
        },
        child: StreamBuilder(
          stream: AuthController.getLastUserMessages(widget.doctor),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list = data?.map((e) => Message.fromJson(e.data())).toList() ??
                [];
            if(list.isNotEmpty){
              _message = list[0];
            }
            return ListTile(
              //leading: const CircleAvatar(child: Icon(Icons.person_outline),),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    height: 55,
                    width: 55,
                    imageUrl: widget.doctor.image,
                    //placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(child: Icon(Icons.person_outline),),
                  ),
                ),

                title: Text('${widget.doctor.firstname} ${widget.doctor.lastname}'),

                subtitle: Text(_message != null ? _message!.msg: ' ', maxLines: 1,),

              //trailing: const Text('12:00 PM', style: TextStyle(color: Colors.black54),),
            );
          },
        ),
      ),
    );
  }
}
