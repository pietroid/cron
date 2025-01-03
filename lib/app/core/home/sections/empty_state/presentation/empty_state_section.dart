import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus/app/core/home/sections/core/home_section.dart';
import 'package:focus/app/core/thing.dart';
import 'package:focus/app/data/repositories/thing_repository.dart';
import 'package:focus/app/data/stream_cubit.dart';

class EmptyStateSection extends StatefulWidget {
  const EmptyStateSection({super.key});

  @override
  State<EmptyStateSection> createState() => _EmptyStateSectionState();
}

class _EmptyStateSectionState extends State<EmptyStateSection> {
  late StreamCubit<List<Thing>> _hasThingsCubit;

  @override
  void initState() {
    //TODO change this query on the future because of performance (limit it or return just bool)
    _hasThingsCubit = StreamCubit<List<Thing>>(
      stream: context.read<ThingRepository>().watchTodoThings(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StreamCubit<List<Thing>>, List<Thing>>(
      bloc: _hasThingsCubit,
      builder: (context, state) => HomeSection(
        mustRender: _hasThingsCubit.state.isEmpty,
        title: '📝 Nada por aqui',
        content: const Text('Clique no + para criar alguma nota ou tarefa!'),
      ),
    );
  }
}
