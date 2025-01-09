import 'package:flutter/material.dart';
import 'package:focus/app/core/elements/nested_draggable_list/nested_draggable_list.dart';
import 'package:focus/app/core/home/core/sections/timely/timely_data.dart';
import 'package:focus/app/core/thing.dart';
import 'package:focus/app/ui/base_card.dart';
import 'package:provider/provider.dart';

class Timely extends StatelessWidget {
  const Timely({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedDraggableList<Thing, Thing>(
      delegate: context.read<TodaySectionDelegate>(),
      keyForList: (thing) => ValueKey(thing.id),
      itemsForList: (list) => list.children,
      listHeader: (list) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          list.content,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      keyForItem: (item) => ValueKey(item.id),
      itemBuilder: (item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: BaseCard(
          thing: item,
        ),
      ),
      onItemReorder:
          (Thing oldList, Thing oldItem, Thing newList, int newItemIndex) {
        context.read<TodaySectionDelegate>().editThing(
              thing: oldItem,
              newParent: newList,
              newIndex: newItemIndex,
            );
      },
    );
  }
}