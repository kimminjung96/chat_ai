import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String sentTime;
  final bool isUserMessage;

  const ChatMessage(
      {super.key,
      required this.message,
      required this.sentTime,
      required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.80,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          child: Column(
            crossAxisAlignment: isUserMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Card(
                color: isUserMessage ? Colors.white : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: isUserMessage
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          bottomLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0),
                          bottomRight: Radius.circular(0.0))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          bottomLeft: Radius.circular(0.0),
                          topRight: Radius.circular(18.0),
                          bottomRight: Radius.circular(18.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        message,
                        style: const TextStyle(
                            color: Colors.black87, height: 1.6, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: isUserMessage
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Text(
                    sentTime,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
