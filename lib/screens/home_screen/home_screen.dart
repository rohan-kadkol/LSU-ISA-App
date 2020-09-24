import 'package:flutter/material.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/screens/airbnbs_screen/airbnbs_screen.dart';
import 'package:isa_app/screens/apartments_screen/apartments_screen.dart';
import 'package:isa_app/screens/events_screen/events_screen.dart';
import 'package:isa_app/screens/hotels_screen/hotels_screen.dart';
import 'package:isa_app/screens/officers_screen/officers_screen.dart';

import 'widgets/page_selector_bar.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurrentPageScreen(),
    );
  }
}

class CurrentPageScreen extends StatefulWidget {
  @override
  _CurrentPageScreenState createState() => _CurrentPageScreenState();
}

class _CurrentPageScreenState extends State<CurrentPageScreen> {
  final List<String> pages = [
    'Apartments',
    'Hotels near LSU',
    'Airbnbs',
    'Committee Members',
    'Events'
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> pageWidgets = {
      0: ApartmentsScreen(),
      1: HotelsScreen(),
      2: AirbnbsScreen(),
      3: OfficersScreen(),
      4: EventsScreen(),
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: kToolbarHeight * 1.5,
        title: Image(
          image: AssetImage('assets/images/logo.png'),
          height: kToolbarHeight * 1.5,
          width: kToolbarHeight * 2 * 1.5,
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   color: Theme.of(context).primaryColor,
          //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: kDefaultMargin / 4, vertical: kDefaultMargin / 2),
          //     child: Center(
          //       child: Text(
          //         'International Student Association at LSU',
          //         textAlign: TextAlign.center,
          //         style: Theme.of(context).textTheme.headline4.copyWith(
          //             color: Theme.of(context).accentColor,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(kDefaultBorderRadius),
              //   bottomRight: Radius.circular(kDefaultBorderRadius),
              // ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultMargin / 2),
              child: PageSelectorBar(
                pages: pages,
                onPageSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedIndex: selectedIndex,
              ),
            ),
          ),
          Expanded(
            child: pageWidgets[selectedIndex],
          )
        ],
      ),
    );
  }
}
