//import 'dart:convert';
//import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_vet_care/Widget/user_message_card.dart';
import 'package:smart_vet_care/model/chat_doctor.dart';

import '../controllers/auth_controller.dart';
import '../model/chat_messages_model.dart';

// import 'package:grouped_list/grouped_list.dart';
//import 'package:intl/intl.dart';

class ChatDetail extends StatefulWidget {
  final ChatDoctor doctor;

  const ChatDetail({Key? key, required this.doctor}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  List<Message> list = [];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: AuthController.getAllUserMessages(widget.doctor),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    return const Center(
                    child: CircularProgressIndicator(),
                    );
                    case ConnectionState.waiting:

                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;

                      list = data?.map((e) => Message.fromJson(e.data())).toList() ??
                      [];

                      if (list.isNotEmpty) {
                        return ListView.builder(
                          reverse: true,
                            itemCount: list.length,
                            padding: const EdgeInsets.only(top: 3),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              //return ChatDoctorCard(user: list[index]);
                              return UserMessageCard(message: list[index]);
                            });
                      } else {
                        return const Center(
                          child: Text(
                            'Say Hi!',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            height: 40,
            width: 40,
            imageUrl: widget.doctor.image,
            //placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => const CircleAvatar(
              child: Icon(Icons.person_outline),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.doctor.firstname,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        )
      ],
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(children: [
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: " Type Something...",
                    hintStyle: TextStyle(color: Colors.deepPurple),
                    border: InputBorder.none,
                  ),
                )),
              ],
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            if(_textController.text.isNotEmpty){
              AuthController.sendUserMessage(widget.doctor, _textController.text);
              _textController.text = '';
            }
          },
          minWidth: 0,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
          shape: const CircleBorder(),
          color: Colors.deepPurple,
          child: const Icon(
            Icons.send,
            color: Colors.white,
            size: 28,
          ),
        )
      ]),
    );
  }
}
