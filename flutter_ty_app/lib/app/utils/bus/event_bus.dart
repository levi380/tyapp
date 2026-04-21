import 'dart:async';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-297d9986-5827-4a9d-9203-35ac8474b668-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  全局通知类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全局通知类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 全局通知单例
    】】】
 *
 */
class EventBus {
  final StreamController _streamController;
  static EventBus? _instance;

  factory EventBus() {
    _instance ??= EventBus._();
    return _instance!;
  }

  EventBus._({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  Stream<T> on<T>() {
    return _streamController.stream.where((event) => event is T).cast<T>();
  }

  void fire(dynamic event) {
    _streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}
