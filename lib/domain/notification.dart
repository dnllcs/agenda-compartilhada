class Notification {
  late dynamic? id;
  late String type;
  late String title;
  late String content;

  Notification(String type, String title, String content) {
    this.type = type;
    this.title = title;
    this.content = content;
    validateFields();
  }
  validateFields() {
    
  }
}
