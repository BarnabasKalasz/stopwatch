import 'package:flutter/material.dart';

class SwipeableStopwatchDisplay extends StatefulWidget {
  final List<Widget> children;

  const SwipeableStopwatchDisplay({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  _SwipeableStopwatchDisplayState createState() =>
      _SwipeableStopwatchDisplayState();
}

class _SwipeableStopwatchDisplayState extends State<SwipeableStopwatchDisplay> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: widget.children.map((child) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Center(
                  child: child,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
