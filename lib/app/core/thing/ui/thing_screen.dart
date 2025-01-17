import 'package:flutter/material.dart';
import 'package:focus/app/core/elements/nested_draggable_list/nested_draggable_list.dart';
import 'package:focus/app/core/home/core/sections/timely/timely_data.dart';
import 'package:focus/app/core/home/core/sections/timely/timely_thing_extension.dart';
import 'package:focus/app/core/thing.dart';
import 'package:focus/app/core/thing/data/generic_thing_data.dart';
import 'package:focus/app/data/object_box.dart';
import 'package:focus/app/ui/base_card.dart';
import 'package:focus/app/ui/elements/global_scaffold.dart';
import 'package:provider/provider.dart';

class ThingScreen extends StatelessWidget {
  const ThingScreen({
    required this.thingId,
    super.key,
  });
  final int thingId;

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: NestedDraggableList<Thing, Thing>(
        data: GenericThingData(
          thingId: thingId,
          box: context.read<ObjectBox>(),
        ),
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
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: BaseCard(
            item.toBaseCardParams(context),
          ),
        ),
        onItemReorder:
            (Thing oldList, Thing oldItem, Thing newList, int newItemIndex) {
          context.read<TimelyData>().editThing(
                thing: oldItem,
                newParent: newList,
                newIndex: newItemIndex,
              );
        },
      ),
    );
  }
}
