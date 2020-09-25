import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:isa_app/constants.dart';

import 'package:isa_app/models/event.dart';
import 'package:isa_app/screens/event_details/widgets/top_widget_stack_title.dart';
import 'widgets/top_widget_stack.dart';

class EventDetailsScreen extends StatelessWidget {
  static final String routeName = '/event_details';

  final Event event;

  const EventDetailsScreen(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopWidgetStack(
            title: TopWidgetStackTitle(
              title: event.name,
            ),
            size: MediaQuery.of(context).size,
            background: Container(
              color: kAccentColorLight,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  pauseAutoPlayOnTouch: true,
                  viewportFraction: 1
                ),
                items: event.imageUrls
                    .map((imageUrl) => Image(image: NetworkImage(imageUrl), height: double.infinity, width: double.infinity, fit: BoxFit.cover,))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
