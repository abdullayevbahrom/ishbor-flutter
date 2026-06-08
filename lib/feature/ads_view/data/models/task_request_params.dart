class TaskRequestParams {
  final dynamic taskId;
  final String message;
  final String price;

  const TaskRequestParams({
    required this.taskId,
    required this.message,
    required this.price,
  });
}
