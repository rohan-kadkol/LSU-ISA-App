import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:isa_app/models/chat_message.dart';
import 'package:isa_app/models/user_1.dart';
import 'package:isa_app/screens/chat_screen/widgets/heart_button.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../constants.dart';

class ChatMessageCard extends StatelessWidget {
  final ChatMessage chatMessage;
  final User1 currentUser;

  const ChatMessageCard({
    @required this.chatMessage,
    @required this.currentUser,
  });

  Widget _buildChatMessageCard(
      {@required BuildContext context,
      @required bool isMe,
      List<Widget> children,
      Function onLongPress}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultMargin / 4),
      child: Material(
        color: isMe ? kAccentColorLight : Colors.white,
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          onLongPress: onLongPress,
          child: Container(
            width: MediaQuery.of(context).size.width * .6,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultMargin,
              vertical: kDefaultMargin / 2,
            ),
            // margin: const EdgeInsets.symmetric(vertical: kDefaultMargin / 4),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              // color: isMe ? kAccentColorLight : Colors.white,
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children ?? [],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisibleMessage(bool isMe) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => chatMessage.delete(currentUser),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) => _buildChatMessageCard(
          context: context,
          isMe: isMe,
          onLongPress: () {
            Slidable.of(context).open(actionType: SlideActionType.secondary);
          },
          children: [
            Text(
              chatMessage.message,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: kDefaultMargin / 2,
            ),
            Row(
              children: [
                HeartButton(
                  chatMessage: chatMessage,
                  currentUser: currentUser,
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(chatMessage.name ?? ''),
                    Text(
                      _getDisplayText(chatMessage.timestamp),
                      // '${dateFormat.format(chatMessage.timestamp)}',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDeletedMessage(bool isMe) {
    return Builder(
      builder: (BuildContext context) => _buildChatMessageCard(
        context: context,
        isMe: isMe,
        children: [
          Text('Deleted by sender'),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMe = chatMessage.uid == currentUser?.firebaseUser?.uid;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        chatMessage.deleted == null
            ? _buildVisibleMessage(isMe)
            : _buildDeletedMessage(isMe)
      ],
    );
  }

  String _getDisplayText(DateTime timestamp) {
    final DateFormat timeFormat = DateFormat('hh:mm aa');
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    String time = '${timeFormat.format(chatMessage.timestamp)}';

    DateTime now = DateTime.now();
    // Between 1 minute and 1 hour
    // if (timestamp.day == now.day &&
    //     now.difference(timestamp) >= Duration(minutes: 1) &&
    //     now.difference(timestamp) < Duration(hours: 1)) {
    //   return timeago.format(timestamp);
    // }
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
