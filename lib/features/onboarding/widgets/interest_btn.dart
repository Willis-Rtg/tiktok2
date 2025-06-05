import 'package:flutter/material.dart';

class Interest_btn extends StatefulWidget {
  const Interest_btn({super.key, required this.interest});

  final String interest;

  @override
  State<Interest_btn> createState() => _Interest_btnState();
}

class _Interest_btnState extends State<Interest_btn> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 3000),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? Theme.of(context).primaryColor : Colors.white,
            border: Border.all(
              color: selected ? Theme.of(context).primaryColor : Colors.black12,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).shadowColor,
                blurRadius: 4,
                // blurStyle: BlurStyle.solid,
                // offset: Offset(0, 0),
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.interest,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
