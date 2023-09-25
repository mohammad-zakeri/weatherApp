import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/widgets/bottom_nav.dart';

void main(){

  final PageController pageController = PageController();

  testWidgets('click IconButton in bottom nav should moving to page 0 in pageView', (widgetTester) async{

    await widgetTester.pumpWidget(

        MaterialApp(

          home: Scaffold(

            body: PageView(
              controller: pageController,

              children: [
                Container(),
                Container(),
              ],

            ),

            bottomNavigationBar: BottomNav(controller: pageController),
          ),

        ),

    );

    await widgetTester.tap(find.widgetWithIcon(IconButton, Icons.home));

    await widgetTester.pumpAndSettle();

    expect(pageController.page, 0);

  });

  testWidgets('click IconButton in bottom nav should moving to page 1 in pageView', (widgetTester) async{

    await widgetTester.pumpWidget(

      MaterialApp(

        home: Scaffold(

          body: PageView(
            controller: pageController,

            children: [
              Container(),
              Container(),
            ],

          ),

          bottomNavigationBar: BottomNav(controller: pageController),
        ),

      ),

    );

    /// Tap the Icon Button
    await widgetTester.tap(find.widgetWithIcon(IconButton, Icons.bookmark));

    /// Rebuild the widget ofter the state has changed
    await widgetTester.pumpAndSettle();

    /// Expect to move to home screen
    expect(pageController.page, 1);

  });

}