import 'package:cron/core/domain/thing.dart';
import 'package:cron/objectbox.g.dart';
import 'package:cron/shared/object_box.dart';
import 'package:cron/shared/streamed_data_source.dart';
import 'package:rxdart/subjects.dart';

class ThingRepository {
  ThingRepository({
    required this.box,
  });
  final ObjectBox box;

  void addOrEditThing({
    required Thing thing,
  }) {
    box.store.box<Thing>().put(thing);
  }

  void setAsDone({
    required Thing thing,
  }) {
    thing.done = true;
    box.store.box<Thing>().put(thing);
  }

  void setAsUndone({
    required Thing thing,
  }) {
    thing.done = false;
    box.store.box<Thing>().put(thing);
  }

  BehaviorSubject<List<Thing>> watchTodoThings() {
    QueryBuilder<Thing> query() =>
        box.store.box<Thing>().query(Thing_.done.equals(false));
    return SubjectQueryBuilder<Thing>(
      query: query,
    ).behaviorSubject;
  }

  BehaviorSubject<List<Thing>> watchDoneThings() {
    QueryBuilder<Thing> query() =>
        box.store.box<Thing>().query(Thing_.done.equals(true));
    return SubjectQueryBuilder<Thing>(
      query: query,
    ).behaviorSubject;
  }
}
