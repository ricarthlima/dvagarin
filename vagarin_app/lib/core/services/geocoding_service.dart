import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeocodingService {
  static Future<String> getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Se não achar nenhum resultado
      if (placemarks.isEmpty) {
        return "Endereço não encontrado";
      }

      Placemark place = placemarks[0];

      String subLocality = place.subLocality ?? "";
      String locality = place.subAdministrativeArea ?? "";
      String adminArea = place.administrativeArea ?? "";

      List<String> cityParts = [];
      if (subLocality.isNotEmpty) {
        cityParts.add(subLocality);
      }
      if (locality.isNotEmpty) {
        cityParts.add(locality);
      }

      String cityAddress = cityParts.join(', ');

      List<String> finalAddressParts = [];
      if (cityAddress.isNotEmpty) {
        finalAddressParts.add(cityAddress);
      }
      if (adminArea.isNotEmpty) {
        finalAddressParts.add(adminArea);
      }

      String finalAddress = finalAddressParts.join(' - ');

      if (finalAddress.isEmpty) {
        return "Endereço não encontrado";
      }

      return finalAddress;
    } catch (e) {
      return "Não foi possível buscar o endereço";
    }
  }
}
