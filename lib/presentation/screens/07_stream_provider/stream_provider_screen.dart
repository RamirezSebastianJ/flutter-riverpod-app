import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: const _StreamView(),
    );
  }
}

class _StreamView extends ConsumerWidget {
  const _StreamView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInChatStream = ref.watch(usersInChatProvider);

    if (!userInChatStream.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: userInChatStream.value?.length ?? 0,
      itemBuilder: (context, index) {
        final name = userInChatStream.value?[index] ?? '';
        return ListTile(
          title: Text(name),
        );
      },
    );
  }
}
