import 'package:flutter/material.dart';
import 'package:isa_app/services/networking.dart';
import 'package:isa_app/widgets/apartments_screen/apartments_stream_builder.dart';

class ApartmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Networking.downloadApartments(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Apartments'),
      ),
      body: ApartmentsStreamBuilder(),
    );
  }
}
