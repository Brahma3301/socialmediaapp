import 'package:flutter/material.dart';

class Squaretile extends StatelessWidget {
  final String imagepath;
  final Function()? onTap;
  const Squaretile({
    Key? key,
    required this.imagepath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagepath,
          height: 40,
        ),
      ),
    );
  }
}
