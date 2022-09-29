import 'package:flutter/material.dart';

import '../../../core/style/text/app_text_style.dart';
import '../../../models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel messageModel;
  final bool isCurrentUser;
  const ChatBubble({
    Key? key,
    required this.messageModel,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment:
                  isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isCurrentUser ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 1.0,
                      ),
                      Text(
                        messageModel.text.toString(),
                        textAlign:
                            isCurrentUser ? TextAlign.start : TextAlign.end,
                        style: AppTextStyle.bodyText().copyWith(
                          color: isCurrentUser ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
