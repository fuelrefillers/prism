import 'package:flutter/material.dart';

class ProgressDialogContent extends StatefulWidget {
  final double progress;

  ProgressDialogContent({required this.progress});

  @override
  _ProgressDialogContentState createState() => _ProgressDialogContentState();
}

class _ProgressDialogContentState extends State<ProgressDialogContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(
          value: widget.progress,
        ),
        SizedBox(height: 16),
        Text(
          'Upload progress: ${(widget.progress * 100).toStringAsFixed(2)}%',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
