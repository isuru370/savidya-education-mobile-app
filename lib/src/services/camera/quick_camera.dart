import 'package:image_picker/image_picker.dart';

Future<XFile?> getImageFromCamera() async {
  final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (imageFile != null) {
    return imageFile;
  } else {
    return null;
  }
}
