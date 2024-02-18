
import 'package:flutter/material.dart';

class VoiceRecordButton extends StatelessWidget {
  const VoiceRecordButton({super.key,    required this.onLongPressStart,
    required this.onLongPressEnd,
    required this.onLongPressMoveUpdate,});

  final Function(LongPressStartDetails details) onLongPressStart;
  final Function(LongPressEndDetails details) onLongPressEnd;
  final Function(LongPressMoveUpdateDetails details) onLongPressMoveUpdate;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onLongPressStart:(details){
        onLongPressStart(details);

      },
      onLongPressEnd:(details){
        onLongPressEnd(details);

      },
      onLongPressMoveUpdate:(details){
        onLongPressMoveUpdate(details);
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF).withOpacity(1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '按下说话',
          style: const TextStyle(
              fontSize: 12,color: Color(0xFF000000)
          ),
        ),
      ),);
  }
}


// class VoiceRecordButton extends StatefulWidget {
//   const VoiceRecordButton({
//     Key? key,
//     required this.onLongPressStart,
//     required this.onLongPressEnd,
//     required this.onLongPressMoveUpdate,
//   }) : super(key: key);
//
//   final Function(LongPressStartDetails details) onLongPressStart;
//   final Function(LongPressEndDetails details) onLongPressEnd;
//   final Function(LongPressMoveUpdateDetails details) onLongPressMoveUpdate;
//
//   @override
//   State<VoiceRecordButton> createState() => _VoiceRecordButtonState();
// }
//
// class _VoiceRecordButtonState extends State<VoiceRecordButton> {
//
//   bool _pressing = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPressStart:(details){
//         widget.onLongPressStart(details);
//         setState(() {
//           _pressing = true;
//         });
//       },
//       onLongPressEnd:(details){
//         widget.onLongPressEnd(details);
//         setState(() {
//           _pressing = false;
//         });
//       },
//       onLongPressMoveUpdate:(details){
//         widget.onLongPressMoveUpdate(details);
//       },
//       child: Container(
//       height: 40,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: const Color(0xFFFFFFFF).withOpacity(_pressing ? 0.3 : 1),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         _pressing ? '松开发送':'按下说话',
//         style: const TextStyle(
//           fontSize: 12,color: Color(0xFF000000)
//         ),
//       ),
//     ),);
//   }
// }

