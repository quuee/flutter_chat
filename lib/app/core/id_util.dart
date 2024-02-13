
import 'dart:math';

class IdUtil{

  static int getId(){
    String randomstr = Random().nextInt(4).toString();
    // for (var i = 0; i < 3; i++) {
    //   var str = Random().nextInt(10);
    //   randomstr = "$randomstr$str";
    // }
    var timenumber = DateTime.now().millisecondsSinceEpoch;//时间
    var id = "$randomstr$timenumber";

    return int.parse(id);
  }
}