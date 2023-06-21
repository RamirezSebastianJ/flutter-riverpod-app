import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:uuid/uuid.dart';

import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';

const _uuid = Uuid();

final filteredGuestProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todosStateNotifierProvider);

  switch (selectedFilter) {
    case TodoFilter.completed:
      return todos.where((todo) => todo.done).toList();
    case TodoFilter.pending:
      return todos.where((todo) => !todo.done).toList();
    default:
      return todos;
  }
});

final todosStateNotifierProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier()
      : super(
          [
            Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null,
            ),
            Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: DateTime.now(),
            ),
            Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null,
            ),
          ],
        );

  void addTodo() {
    state = [
      ...state,
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id != id) {
        return todo;
      }

      if (todo.done) {
        return todo.copyWith(
          completedAt: null,
        );
      }

      return todo.copyWith(
        completedAt: DateTime.now(),
      );
    }).toList();
  }
}
