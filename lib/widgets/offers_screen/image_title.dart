import 'package:flutter/material.dart';
import 'package:isa_app/constants.dart';
import 'package:isa_app/utils/image_utils.dart';

class ImageAndTitle extends StatelessWidget {
  final Size size;
  final String imageUrl;
  final String title;
  final String heroId;

  const ImageAndTitle(
      {@required this.size, @required this.imageUrl, @required this.title, @required this.heroId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .4,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Hero(
            tag: 'apartment_image$heroId',
            child: Container(
              height: size.height * .4 - 35,
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover, image: ImageUtils.getApartmentImage(imageUrl))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(kDefaultMargin),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    boxShadow: kSecondaryBoxShadow,
                    borderRadius: BorderRadius.all(
                        Radius.circular(kDefaultBorderRadius))),
                height: 70,
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
