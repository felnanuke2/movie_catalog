import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AnimatedArrowScrollWidget extends StatefulWidget {
  final void Function() scrollToStart;
  final Stream<bool?> isExpandedStream;
  const AnimatedArrowScrollWidget({
    Key? key,
    required this.scrollToStart,
    required this.isExpandedStream,
  }) : super(key: key);

  @override
  State<AnimatedArrowScrollWidget> createState() =>
      _AnimatedArrowScrollWidgetState();
}

class _AnimatedArrowScrollWidgetState extends State<AnimatedArrowScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: widget.isExpandedStream,
      builder: (context, snapshot) => AnimatedContainer(
        width: snapshot.data == true ? 40 : 0,
        duration: Duration(milliseconds: 250),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Get.theme.primaryColor.withOpacity(0.4),
              padding: EdgeInsets.only(left: 8)),
          onPressed: widget.scrollToStart,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
