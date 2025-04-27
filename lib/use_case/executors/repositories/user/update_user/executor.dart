import 'package:executor_sample/data/repositories/user/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'executor.g.dart';

@riverpod
class UpdateUserExecutor extends _$UpdateUserExecutor {
  @override
  Future<void> build() async {}

  Future<void> call({required bool throwException}) async =>
      state = await AsyncValue.guard(() async {
        await ref
            .read(userRepositoryProvider)
            .update(throwException: throwException);
      });
}
