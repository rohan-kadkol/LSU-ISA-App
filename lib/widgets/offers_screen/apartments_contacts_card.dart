import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class ApartmentContactsCard extends StatelessWidget {
  final String title;
  final IconData leading;
  final String url;

  final Color textColor;

  ApartmentContactsCard({this.title = '', this.leading, this.url = '', this.textColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor),),
      leading: Icon(
        leading,
        color: textColor ?? Colors.blueGrey,
      ),
      trailing: GestureDetector(
          child: Icon(
            Icons.open_in_new,
            color: textColor ?? Colors.blueGrey,
          ),
          onTap: () async {
            if (await canLaunch(url)) {
              launch(url);
            } else {
              print('Error launching the url: $url');
              Alert(context: context, title: 'Sorry, couldn\'t open that.')
                  .show();
            }
          }),
    );
  }
}
