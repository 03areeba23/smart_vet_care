// import 'dart:convert';

// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'threedots.dart';
// import 'ChatMessage.dart';
// import 'package:http/http.dart' as http;

// final headers = {
//   'Authorization': 'Bearer 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'
// };

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<ChatMessage> _messages = [];
//   late OpenAI? chatGPT;
//   bool _isImageSearch = false;

//   bool _isTyping = false;

//   get kTranslateModelV3 => null;

//   late int receiveTimeout;

//   @override
//   void initState() {
//     // chatGPT = OpenAI.instance.build(
//     //     token:
//     //         dotenv.env["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"],
//     //     baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     chatGPT?.close();
//     chatGPT?.genImgClose();
//     super.dispose();
//   }

//   // Link for api - https://beta.openai.com/account/api-keys

//   void _sendMessage() async {
//     if (_controller.text.isEmpty) return;
//     ChatMessage message = ChatMessage(
//       text: _controller.text,
//       sender: "user",
//       isImage: false,
//     );

//     setState(() {
//       _messages.insert(0, message);
//       _isTyping = true;
//     });

//     _controller.clear();

//     if (_isImageSearch) {
//       final request = GenerateImage(
//         message.text,
//         1,
//         size: ImageSize.size256,
//       );

//       final response = await chatGPT!.generateImage(request);
//       Vx.log(response!.data!.last!.url!);
//       insertNewData(response.data!.last!.url!, isImage: true);
//     } else {
//       Future<String> generateResponse(String prompt) async {
//         const apiKey = "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";

//         var url = Uri.https("api.openai.com", "/v1/completions");
//         final response = await http.post(
//           url,
//           headers: {
//             'Content-Type': 'application/json',
//             "Authorization": "Bearer $apiKey"
//           },
//           body: json.encode({
//             "model": "text-davinci-003",
//             "prompt": prompt,
//             'temperature': 0,
//             'max_tokens': 2000,
//             'top_p': 1,
//             'frequency_penalty': 0.0,
//             'presence_penalty': 0.0,
//           }),
//         );

//         // Do something with the response
//         Map<String, dynamic> newresponse = jsonDecode(response.body);

//         return newresponse['choices'][0]['text'];
//       }
//     }
//   }

//   void insertNewData(String response, {bool isImage = false}) {
//     ChatMessage botMessage = ChatMessage(
//       text: response,
//       sender: "bot",
//       isImage: isImage,
//     );

//     setState(() {
//       _isTyping = false;
//       _messages.insert(0, botMessage);
//     });
//   }

//   Widget _buildTextComposer() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _controller,
//             onSubmitted: (value) => _sendMessage(),
//             decoration: const InputDecoration.collapsed(
//                 hintText: "Question/description"),
//           ),
//         ),
//         ButtonBar(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.send),
//               onPressed: () {
//                 _isImageSearch = false;
//                 _sendMessage();
//               },
//             ),
//             TextButton(
//                 onPressed: () {
//                   _isImageSearch = true;
//                   _sendMessage();
//                 },
//                 child: const Text("Generate Image"))
//           ],
//         ),
//       ],
//     ).px16();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("ChatBot")),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Flexible(
//                   child: ListView.builder(
//                 reverse: true,
//                 padding: Vx.m8,
//                 itemCount: _messages.length,
//                 itemBuilder: (context, index) {
//                   return _messages[index];
//                 },
//               )),
//               if (_isTyping) const ThreeDots(),
//               const Divider(
//                 height: 1.0,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                 ),
//                 child: _buildTextComposer(),
//               )
//             ],
//           ),
//         ));
//   }
// }

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

import 'model/message_model.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  bool inProgress = false;
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messageList = [];
  final openAI = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 6)),
      isLog: true);

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Widget buildMessageListWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildSingleMessageRow(messageList[index]);
      },
      reverse: true,
      itemCount: messageList.length,
    );
  }

  Widget buildSingleMessageRow(MessageModel messageModel) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment:
            messageModel.sentByMe ? Alignment.topRight : Alignment.topLeft,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: messageModel.sentByMe
                  ? Colors.deepPurple[200]
                  : Colors.grey.shade300,
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              messageModel.message,
              style: const TextStyle(
                fontSize: 16,
              ),
            )),
      ),
    );
  }

  Widget buildSendWidget() {
    return Container(
      // color: AppColor().bgColor,
      height: 60,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: messageController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: "How can i help you?",
              hintStyle: TextStyle(color: Colors.black),
              border: InputBorder.none,
            ),
          )),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              String question = messageController.text.toString();
              if (question.isEmpty) return;
              messageController.clear();
              addMessageToMessageList(question, true);
              sendMessageToAPI(question);
            },
            elevation: 0,
            child: const Icon(
              Icons.send,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  void sendMessageToAPI(String question) async {
    setState(() {
      inProgress = true;
    });
    final request = CompleteText(
      prompt: question,
      model: kTextDavinci3,
      maxTokens: 4000,
    );
    try {
      final response = await openAI.onCompletion(request: request);
      String answer = response?.choices.last.text.trim() ?? "";
      addMessageToMessageList(answer, false);
    } catch (e) {
      print(e);
      addMessageToMessageList("Failed to get response please try again", false);
    }
    setState(() {
      inProgress = false;
    });
  }

  void addMessageToMessageList(String message, bool sentByMe) {
    setState(() {
      messageList.insert(0, MessageModel(message: message, sentByMe: sentByMe));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor().botBackgroundColor,
      appBar: AppBar(
        title: const Text("ChatBot"),
        // backgroundColor: AppColor().bgColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: messageList.isEmpty
                    ? const Center(
                        child: Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'monospace',
                              color: Colors.white),
                        ),
                      )
                    : buildMessageListWidget()),
            if (inProgress)
              const LinearProgressIndicator(
                minHeight: 2,
              ),
            buildSendWidget(),
          ],
        ),
      ),
    );
  }
}
