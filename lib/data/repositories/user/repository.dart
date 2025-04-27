import 'dart:math';

import 'package:executor_sample/core/log/logger.dart';
import 'package:executor_sample/data/repositories/user/exception.dart';
import 'package:executor_sample/domain/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserRepository {
  UserRepository(this.ref);
  final Ref ref;

  /// 新規作成
  Future<void> create(
    User user, {
    bool throwException = true,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      if (throwException) {
        _throwException(_Action.create);
      }

      logger.d('create');
    } on DuplicateUserNameException catch (e) {
      throw DuplicateUserNameException(e.message);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e.message);
    } on Exception catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// 更新
  Future<void> update({
    bool throwException = true,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      if (throwException) {
        _throwException(_Action.update);
      }
      logger.d('update');
    } on UserNotFoundException catch (e) {
      throw UserNotFoundException(e.message);
    } on ServerErrorException catch (e) {
      throw ServerErrorException(e.message);
    } on Exception catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// 取得
  Future<List<User>> findAll() async {
    // 適当にユーザーを生成
    return List.generate(
      20,
      (index) => User(
        id: '$index',
        name: 'User $index',
        email: 'user$index@example.com',
      ),
    );
  }
}

extension on UserRepository {
  /// Exceptionをランダムにthrowする
  void _throwException(_Action action) {
    final random = Random();
    final index = random.nextInt(_UserRepositoryError.values.length);
    switch (_UserRepositoryError.values[index]) {
      case _UserRepositoryError.firstException:
        final exception = switch (action) {
          _Action.create => DuplicateUserNameException('Duplicate user name'),
          _Action.update => UserNotFoundException('User not found'),
        };
        throw exception;
      case _UserRepositoryError.serverError:
        throw ServerErrorException('Server error');
      case _UserRepositoryError.exception:
        throw Exception('An unexpected error occurred');
    }
  }
}

enum _UserRepositoryError {
  firstException,
  serverError,
  exception,
}

enum _Action {
  create,
  update,
}
