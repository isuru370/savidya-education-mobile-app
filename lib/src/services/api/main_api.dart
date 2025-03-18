class API {
  static String uploadImageAPI = "https://admin.savidyaeducation.com/api";

  //https://admin.coopcitycollege.com/api
  //https://edu.alokait.lk/apiA
  //https://savidya.alokait.lk/api

  static String mainAPI = "https://api.savidyaeducation.com/api";

  //https://api.savidyaeducation.com/api
  //https://api.alokait.lk/api
  //http://192.168.1.101/Aloka-Mobile-App-Backend/Savidya-Education-Mobile-App-Backend/api
  //http://192.168.43.73/Aloka-Mobile-App-Backend/savidya/api

  static String passwordForgot = "$mainAPI/forgot-password";
  static String passwordReset = "$mainAPI/reset-password";

  //User
  static String user = "$mainAPI/user";

  //Student
  static String studentImage = "$mainAPI/student_image";
  static String student = "$mainAPI/student";

  //Teacher
  static String teacher = "$mainAPI/teacher";

  //class
  static String studentClass = "$mainAPI/class_shedule";

  //bank details
  static String bank = "$mainAPI/bank_details";

  //student images
  static String serverUploadImage = "$uploadImageAPI/upload";
  // static String imageViewMainAPI = "https://edu.alokait.lk/";
  // static String studentViewImage = "$imageViewMainAPI/upload";

  //student qr read
  static String attendance = "$mainAPI/attendance";

  //payment
  static String payment = "$mainAPI/payment";

  //class attendance
  static String classAttendance = "$mainAPI/class_attendance";

  //class category
  static String classCategory = "$mainAPI/category";

  //class category Has Class
  static String classHasCategory = "$mainAPI/class_has_category";
  //class category Has Class
  static String admission = "$mainAPI/admission";

  //tute
  static String tute = "$mainAPI/tute";
  //pages
  static String pages = "$mainAPI/pages";

  static String sendSMG = "$mainAPI/send_sms";
  //Permission
  static String permission = "$mainAPI/permission";
}
