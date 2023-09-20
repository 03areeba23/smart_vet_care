
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_vet_care/controllers/auth_controller.dart';
import 'package:smart_vet_care/model/chat_messages_model.dart';

class UserMessageCard extends StatefulWidget {
  final Message message;

  const UserMessageCard({Key? key, required this.message}) : super(key: key);

  @override
  State<UserMessageCard> createState() => _UserMessageCardState();
}

class _UserMessageCardState extends State<UserMessageCard> {
  @override
  Widget build(BuildContext context) {
    return AuthController.user.uid == widget.message.fromId
        ? _purpleMessage()
        : _blueMessage();
  }

  Widget _blueMessage() {
    if(widget.message.read.isEmpty){
      AuthController.updateMessageReadStatus(widget.message);
      log('message read updated');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Text(
              widget.message.msg,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
        Row(
          children:  [
            SizedBox(width: 20,),

             // Icon(Icons.done_all_rounded, color: Colors.blue, size: 20,),
        ]
        )
      ],
    );
  }

  Widget _purpleMessage() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Row(
          children: [
            SizedBox(width: 20,),
            if(widget.message.read.isNotEmpty)
              Icon(Icons.done_all_rounded, color: Colors.blue, size: 20,),
        ]
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Text(
              widget.message.msg,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
