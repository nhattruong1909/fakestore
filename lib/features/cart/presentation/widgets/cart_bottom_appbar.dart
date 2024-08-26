
import 'package:flutter/material.dart';

class CartBottomAppbar extends StatefulWidget {
  const CartBottomAppbar({super.key, this.sumPrice = 0.0});
  final double sumPrice;

  @override
  State<CartBottomAppbar> createState() => _CartBottomAppbarState();
}

class _CartBottomAppbarState extends State<CartBottomAppbar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Text(
                '${widget.sumPrice} \$',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  fixedSize: Size(200, 100),
                  backgroundColor: Colors.black),
              child: Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
