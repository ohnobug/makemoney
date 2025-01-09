class CancelableDelay {
  bool _isCanceled = false;

  Future<void> delayed(Duration duration, Function() callback) async {
    await Future.delayed(duration);
    if (!_isCanceled) {
      callback();
    }
  }

  void cancel() {
    _isCanceled = true;
  }
}


// void main() {
//   final cancelableDelay = CancelableDelay();

//   // 创建一个可取消的延迟任务
//   cancelableDelay.delayed(Duration(seconds: 5), () {
//     print('任务完成');
//   });

//   // 模拟某些条件下取消任务
//   Future.delayed(Duration(seconds: 2), () {
//     print('取消延迟任务');
//     cancelableDelay.cancel();
//   });
// }