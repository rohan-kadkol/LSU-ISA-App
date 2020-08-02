import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isa_app/models/apartment.dart';
import 'package:isa_app/models/offer.dart';
import 'package:isa_app/widgets/custom_progress_indicator.dart';
import 'package:isa_app/utils/offer_utils.dart';
import 'package:isa_app/widgets/offers_screen/offer_card.dart';
import 'package:isa_app/widgets/offers_screen/offers_stream_builder.dart';
import 'package:isa_app/constants.dart';

class OffersScreen extends StatelessWidget {
  static final String routeName = '/offers';
  final Apartment apartment;

  OffersScreen(this.apartment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OfferCard(apartment.offers[index]);
        },
        itemCount: apartment.offers.length,
      ),
    );
  }
}
