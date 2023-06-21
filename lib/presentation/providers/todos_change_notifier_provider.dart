import 'package:flutter/widgets.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_app/domain/domain.dart';
import 'package:riverpod_app/config/helpers/random_generator.dart';

const _uuid = Uuid();

final filteredGuestChangeNotifierProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todosProvider = ref.watch(todosChangeNotifierProvider);

  switch (selectedFilter) {
    case TodoFilter.completed:
      return todosProvider.todos.where((todo) => todo.done).toList();
    case TodoFilter.pending:
      return todosProvider.todos.where((todo) => !todo.done).toList();
    default:
      return todosProvider.todos;
  }
});

final todosChangeNotifierProvider =
    ChangeNotifierProvider<TodoChangeNotifier>((ref) {
  return TodoChangeNotifier();
});

class TodoChangeNotifier extends ChangeNotifier {
  List<Todo> todos = [
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
  ];

  void addTodo() {
    todos = [
      ...todos,
      Todo(
        id: _uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];

    notifyListeners();
  }

  void toggleTodo(String id) {
    todos = todos.map((todo) {
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

    notifyListeners();
  }
}
