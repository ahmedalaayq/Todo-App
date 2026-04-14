enum TaskItemActionEnum {
  check(id: 1, name: 'Check'),
  displayId(id: 2, name: 'Display Id'),
  edit(id: 3, name: 'Edit'),
  remove(id: 4, name: 'Remove');

  final String name;
  final int id;
  const TaskItemActionEnum({required this.id, required this.name});
}
