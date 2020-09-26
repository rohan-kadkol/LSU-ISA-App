import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:isa_app/models/chat_message.dart';
import 'package:isa_app/models/user_1.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../constants.dart';

class ChatMessageCard extends StatelessWidget {
  final ChatMessage chatMessage;
  final User1 currentUser;

  const ChatMessageCard({
    @required this.chatMessage,
    @required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = chatMessage.uid == currentUser?.uid;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .6,
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultMargin, vertical: kDefaultMargin / 2),
          margin: const EdgeInsets.symmetric(vertical: kDefaultMargin / 4),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            color: isMe ? kAccentColorLight : Colors.white,
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                chatMessage.message,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: kDefaultMargin / 2,
              ),
              Text(
                _getDisplayTime(chatMessage.timestamp),
                // '${dateFormat.format(chatMessage.timestamp)}',
                textAlign: TextAlign.end,
              )
            ],
          ),
        ),
      ],
    );
  }

  String _getDisplayTime(DateTime timestamp) {
    final DateFormat timeFormat = DateFormat('hh:mm aa');
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    String time = '${timeFormat.format(chatMessage.timestamp)}';

    DateTime now = DateTime.now();
    // Between 1 minute and 1 hour
    if (timestamp.day == now.day &&
        now.difference(timestamp) >= Duration(minutes: 1) &&
        now.difference(timestamp) < Duration(hours: 1)) {
      return timeago.format(timestamp);
    }
    // Difference in 1 day
    if (timestamp.day != now.day &&
        now.difference(timestamp) <= Duration(days: 1)) {
      return 'Yesterday $time';
    }
    // Same day
    if (timestamp.day == now.day &&
        now.difference(timestamp) <= Duration(days: 1)) {
      return 'Today $time';
    }
    return '${dateFormat.format(timestamp)} $time';
  }
}
