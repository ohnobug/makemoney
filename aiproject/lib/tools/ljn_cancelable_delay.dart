class LJNCancelableDelay {
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

