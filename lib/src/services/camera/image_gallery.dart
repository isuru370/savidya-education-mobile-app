import 'package:image_picker/image_picker.dart';

Future<XFile?> getImageFromGallery() async {
  final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (imageFile != null) {
    return imageFile;
  } else {
    return null;
  }
}
