import 'package:flutter/material.dart';
import 'package:shop_catalog/models/shop_item.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({super.key, required this.shopItem});
  final ShopItem shopItem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: shopItem.isImageUrl
                  ? Image.network(shopItem.ImageHref,
                      height: 100,
                      fit: BoxFit.cover)
                  : Image.asset(shopItem.ImageHref,
                  
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.width / 2,

                      fit: BoxFit.cover)),
          SizedBox(height: 10,),
          Text(shopItem.Name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    );
  }
}
