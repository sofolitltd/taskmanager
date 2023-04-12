class Urls {
  static String baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registrationUrl = '$baseUrl/registration';
  static String loginUrl = '$baseUrl/login';
  static String createTaskUrl = '$baseUrl/createTask';
  static String newTaskUrl = '$baseUrl/listTaskByStatus/New';
  static String completedTaskUrl = '$baseUrl/listTaskByStatus/Completed';
  static String canceledTaskUrl = '$baseUrl/listTaskByStatus/Canceled';
  static String progressTaskUrl = '$baseUrl/listTaskByStatus/Progress';

  static String changeStatus(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) => '$baseUrl/deleteTask/$taskId';
}
