import 'package:flutter/material.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/models/offer.dart';
import 'package:isa_app/widgets/bed_bath.dart';
import 'package:isa_app/widgets/icon_number.dart';
import 'package:isa_app/widgets/offers_screen/option_card.dart';
import 'package:isa_app/widgets/offers_screen/wrap_row.dart';
import 'package:isa_app/widgets/text_bubble.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  OfferCard(this.offer);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kCardMargin,
      padding: kCardPadding,
      decoration: BoxDecoration(
        boxShadow: kPrimaryBoxShadow,
        borderRadius: BorderRadius.all(Radius.circular(kDefaultBorderRadius)),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BedBathRow(numBeds: [offer.numBeds], numBaths: [offer.numBaths],),
              TextBubble(
                text: 'AVAILABLE',
                availabilityType: AvailabilityType.AVAILABLE_NOW,
              )
            ],
          ),
          WrapRow(
            children: _getOptionCards(offer.options),
          ),
          WrapRow(
            children: _getTextBubbles(offer),
          )
        ],
      ),
    );
  }

  List<OptionCard> _getOptionCards(List<Option> options) {
    print('!!!${options[0].type}');
    print('!!!${options.length}');
    print('!!!${options[0].name}');
    List<OptionCard> optionCards = [];
    for (Option option in options) {
      optionCards.add(OptionCard(option));
    }
    return optionCards;
  }

  List<TextBubble> _getTextBubbles(Offer offer) {
    List<TextBubble> textBubbles = [];

    if (offer.deposit != null) {
      textBubbles.add(TextBubble(text: '\$${offer.deposit.floor()} deposit'));
    }
    if (offer.furnished != null) {
      String text = offer.furnished ? 'Furnished' : 'Not furnished';
      textBubbles.add(TextBubble(
        text: text,
      ));
    }
    if (offer.petsAllowed != null) {
      String text = offer.petsAllowed ? 'Pets allowed' : 'Pets now allowed';
      textBubbles.add(TextBubble(
        text: text,
      ));
    }
    if (offer.sqft != null) {
      String text;
      switch (offer.sqft.type) {
        case SqftType.EXACT:
          text = '${offer.sqft.sqft.floor()} sqft.';
          break;
        case SqftType.RANGE:
          text =
              '${offer.sqft.sqft.floor()} - ${offer.sqft.sqftMax.floor()} sqft.';
      }
      textBubbles.add(TextBubble(text: text));

      return textBubbles;
    }
  }
}
