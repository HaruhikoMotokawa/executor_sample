import 'package:executor_sample/application/services/notification/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'executor.g.dart';

@riverpod
class ScheduleTodoNotificationExecutor
    extends _$ScheduleTodoNotificationExecutor {
  @override
  FutureOr<void> build() {}

  FutureOr<void> call({required String todoId}) async =>
      state = await AsyncValue.guard(() async {
        await ref
            .read(notificationServiceProvider)
            .scheduleTodoNotification(todoId: todoId);
      });
}
