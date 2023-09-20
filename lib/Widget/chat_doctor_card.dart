import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_vet_care/controllers/auth_controller.dart';
import 'package:smart_vet_care/model/chat_user.dart';
import 'package:smart_vet_care/screen/doctor_screens/DocChatDetailScreen.dart';

import '../model/chat_messages_model.dart';
class ChatDoctorCard extends StatefulWidget {
  final ChatUser user;
  const ChatDoctorCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatDoctorCard> createState() => _ChatDoctorCardState();
}

class _ChatDoctorCardState extends State<ChatDoctorCard> {
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => DocChatDetail(user: widget.user)));
        },
        child: StreamBuilder(
          stream: AuthController.getLastDocMessages(widget.user),
            builder: (context, snapshot){
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
                    imageUrl: widget.user.image,
                    fit: BoxFit.fill,
                    //placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(child: Icon(Icons.person_outline),),
                  ),
                ),

                title: Text('${widget.user.firstname} ${widget.user.lastname}'),

                subtitle: Text(_message != null ? _message!.msg: ' ', maxLines: 1,),

                //trailing: const Text('12:00 PM', style: TextStyle(color: Colors.black54),),
              );
            }
        )
      ),
    );
  }
}
