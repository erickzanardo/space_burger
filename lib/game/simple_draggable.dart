import 'package:flame/components.dart';
import 'package:flame/gestures.dart';

// TODO(luan) possibly import this onto Flame
mixin SimpleDraggable on Draggable {
  Vector2? previousDrag;

  void handleDragMovement(Vector2 ds);

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    previousDrag = info.eventPosition.game;
    return true;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    final newPosition = info.eventPosition.game;
    final previousDrag = this.previousDrag;
    this.previousDrag = newPosition;
    if (previousDrag == null) {
      return false;
    }

    final ds = newPosition - previousDrag;
    handleDragMovement(ds);
    return true;
  }

  @override
  bool onDragCancel(int pointerId) {
    this.previousDrag = null;
    return true;
  }

  @override
  bool onDragEnd(int pointerId, DragEndInfo info) {
    this.previousDrag = null;
    return true;
  }
}
