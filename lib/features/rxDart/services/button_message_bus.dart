import 'package:rxdart/rxdart.dart';

class ButtonMessagebus {
  // BehaviourSubject will always broadcast the last value on the stream if you subscribe and all emitted values there after
  final BehaviorSubject<int> _buttonIdSubject = BehaviorSubject<int>.seeded(-1);

  // expose the stream as idStream
  Stream<int> get idStream => _buttonIdSubject.stream;

  // place ID's onto the stream
  void broadcastId(int id) {
    _buttonIdSubject.add(id);
  }
}
