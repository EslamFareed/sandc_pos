import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/style/color/app_colors.dart';
import '../../core/style/text/app_text_style.dart';
import '../../cubits/chat_cubit/chat_cubit.dart';
import 'components/chat_bubble.dart';

class ContactWithAdminScreen extends StatefulWidget {
  final String userID;

  ContactWithAdminScreen({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<ContactWithAdminScreen> createState() => _ContactWithAdminScreenState();
}

class _ContactWithAdminScreenState extends State<ContactWithAdminScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context)
          .getMessages(senderId: widget.userID, receiverId: 'admin');
      return BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Contact with admin",
                style: AppTextStyle.appBarText().copyWith(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10.0.h,
                ),
                Expanded(
                  child: state is GetMessagesLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : cubit.messages.isEmpty
                          ? Center(
                              child: Text(
                                "no messages",
                                style: AppTextStyle.bodyText(),
                              ),
                            )
                          : ListView.separated(
                              controller: cubit.chatScrollController,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => ChatBubble(
                                messageModel: cubit.messages[index],
                                isCurrentUser: cubit.messages[index].senderId ==
                                    widget.userID,
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 15.h,
                              ),
                              itemCount: cubit.messages.length,
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0.w,
                      ),
                      borderRadius: BorderRadius.circular(
                        15.0.r,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              border: InputBorder.none,
                              hintText: "enter your message here",
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              cubit.sendMessage(
                                text: messageController.text,
                                time: DateTime.now().toString(),
                                senderId: widget.userID,
                                receiverId: 'admin',
                              );
                              messageController.clear();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
