import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  List<MessageModel> messages = [];
  ScrollController chatScrollController = ScrollController();

  void sendMessage({
    required String text,
    required String time,
    required String senderId,
    required String receiverId,
  }) {
    emit(SendMessageLoadingState());
    MessageModel messageModel = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      dateTime: DateTime.now().toString(),
    );
    FirebaseDatabase.instance
        .ref('users/$senderId/chats/$receiverId/messages')
        .push()
        .set(messageModel.toMap())
        .then((value) {
      FirebaseDatabase.instance
          .ref('users/$receiverId/chats/$senderId/messages')
          .push()
          .set(messageModel.toMap())
          .then((value) {
        chatScrollController.animateTo(
          chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
        emit(SendMessageSuccessState());
      }).catchError((onError) {
        emit(SendMessageErrorState());
      });
    }).catchError((onError) {
      emit(SendMessageErrorState());
    });
  }

  void getMessages({
    required String senderId,
    required String receiverId,
  }) {
    emit(GetMessagesLoadingState());
    try {
      FirebaseDatabase.instance
          .ref('users/$senderId/chats/$receiverId/messages')
          .orderByChild('dateTime')
          .onValue
          .listen((event) {
        messages.clear();
        for (var element in event.snapshot.children) {
          messages.add(
              MessageModel.fromJson(element.value as Map<dynamic, dynamic>));
        }
        //chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
        emit(GetMessagesSuccessState());
      });
    } catch (e) {
      print(e.toString());
      emit(GetMessagesSuccessState());
    }
  }
}
