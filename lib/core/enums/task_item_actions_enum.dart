enum TaskItemActionEnum {
  check(id: 1),
  remove(id: 2);

  final int id;

  const TaskItemActionEnum({required this.id});
}
