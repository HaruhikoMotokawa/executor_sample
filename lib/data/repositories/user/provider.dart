import 'package:executor_sample/data/repositories/user/repository.dart';
import 'package:executor_sample/domain/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) => UserRepository(ref);

@riverpod
Future<List<User>> users(Ref ref) => ref.read(userRepositoryProvider).findAll();
