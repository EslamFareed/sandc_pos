part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitialState extends ChatState {}
////////////////////////////////////////////

class SendMessageLoadingState extends ChatState {}

class SendMessageSuccessState extends ChatState {}

class SendMessageErrorState extends ChatState {}

////////////////////////////////////////////
class GetMessagesLoadingState extends ChatState {}

class GetMessagesSuccessState extends ChatState {}
