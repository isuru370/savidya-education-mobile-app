part of 'quick_image_bloc.dart';

sealed class QuickImageEvent extends Equatable {
  const QuickImageEvent();

  @override
  List<Object> get props => [];
}

class QuickImageSaveEvent extends QuickImageEvent {
  final QuickImageModel quickImageModel;
  final File quickImageFilePath;
  const QuickImageSaveEvent({
    required this.quickImageModel,
    required this.quickImageFilePath,
  });
}

class GetAllQuickImageEvent extends QuickImageEvent {
  final String? imageUrl;
  const GetAllQuickImageEvent({this.imageUrl});
}
