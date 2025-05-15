import 'package:camera/camera.dart';

class CameraService {
  late CameraController _controller;
  late List<CameraDescription> _cameras;

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras.first, ResolutionPreset.medium);
    await _controller.initialize();
  }

  CameraController get controller => _controller;

  Future<void> disposeCamera() async {
    await _controller.dispose();
  }
}
