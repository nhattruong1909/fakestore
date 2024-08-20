import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartBottomAppbar extends StatefulWidget {
  const CartBottomAppbar({super.key, this.totalPrice});
  final int? totalPrice;

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
          SizedBox(
            height: 50,
            width: 200,
            child: Center(
              child: Text(
                '${widget.totalPrice} \$',
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
