import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GalleryViews {
  static Container viewCard(
      {Widget child, EdgeInsets padding, double borderRadius = 5}) {
    return new Container(
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              new BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, offset: Offset(2, 2)),
            ]
        ),
        child: new Container(
          padding: padding != null ? padding : new EdgeInsets.all(0),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              // border: Border.all(color: Colors.black.withOpacity(0.14))
          ),
          child: child,
        )
    );
  }

  static Widget sizedImage(double width, double height, String image,
      {BoxFit fit = BoxFit.contain, BorderRadius borderRadius}) {
    return new SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: fit != null ? fit : BoxFit.cover),
            borderRadius: borderRadius != null ? borderRadius : BorderRadius.circular(0)
        ),
      ),
    );
  }

  static Widget sizedImageFromURL(double width, double height, String imageUrl,
      {BoxFit fit, BorderRadius borderRadius}) {
    return imageUrl != null
        ? new Container(
      width: width, height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: new CachedNetworkImageProvider(imageUrl),
            fit: fit != null ? fit : BoxFit.cover,
          ),
          borderRadius: borderRadius != null ? borderRadius : BorderRadius.circular(0)
      ),
    )
        : new Container(
        width: width, height: height,
        decoration: BoxDecoration(
            borderRadius: borderRadius != null ? borderRadius : BorderRadius.circular(0)
        )
    );
  }
}