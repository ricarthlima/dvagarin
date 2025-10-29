import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Pede permissão e busca a posição atual.
  /// Lança uma [Exception] com a mensagem de erro em caso de falha.
  static Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Testa se o serviço de localização (GPS) está ativado.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Você pode querer abrir as configurações aqui
      // await Geolocator.openLocationSettings();
      throw Exception('Os serviços de localização (GPS) estão desativados.');
    }

    // 2. Checa a permissão
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission(); // Pede a permissão
      if (permission == LocationPermission.denied) {
        throw Exception('A permissão de localização foi negada.');
      }
    }

    // 3. Checa se a permissão foi negada permanentemente
    if (permission == LocationPermission.deniedForever) {
      // Aqui você DEVE direcionar o usuário para as configs. do app.
      // Você pode usar o permission_handler aqui se quiser um popup melhor
      // await Geolocator.openAppSettings();
      throw Exception('A permissão de localização foi negada permanentemente.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
