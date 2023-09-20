import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {

    var primaryColor = Theme.of(context).primaryColor;

    return BottomAppBar(
      notchMargin: 5,
      color: primaryColor,
      shape: const CircularNotchedRectangle(),

      child: SizedBox(
        height: 63,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            IconButton(

              onPressed: (){
                controller.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                },

                icon: const Icon(Icons.home),
            ),

            const SizedBox(),

            IconButton(

              onPressed: (){
                controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                },

              icon: const Icon(Icons.bookmark),
            ),

          ],
        ),

      ),

    );

  }

}