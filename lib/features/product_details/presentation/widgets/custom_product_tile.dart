import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomProductTile extends StatelessWidget {
  const CustomProductTile({super.key, this.imgUrl, this.label, this.price});

  final String? imgUrl;
  final String? label;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imgUrl ?? ''), fit: BoxFit.contain)),
          )),
          Text(
            label ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            price ?? '',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
