// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:untitled/utils/log/app_log.dart';
// import 'package:untitled/utils/log/error_log.dart';
//
// class LocationService {
//   /// Initialize location service
//   static Future<void> init() async {
//     await _ensureLocationAccess();
//   }
//
//   /// Check and request location service + permission
//   static Future<bool> _ensureLocationAccess() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await Geolocator.openLocationSettings();
//       if (!serviceEnabled) return false;
//     }
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     if (permission == LocationPermission.deniedForever) {
//       appLog('Location permission permanently denied');
//       return false;
//     }
//     return permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse;
//   }
//
//   static Future<Position?> getCurrentPosition() async {
//     try {
//       final hasAccess = await _ensureLocationAccess();
//       if (!hasAccess) return null;
//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } catch (e) {
//       errorLog('getCurrentPosition error: $e');
//       return null;
//     }
//   }
//
//   static Future<List<Location>> addressToCoordinate(String address) async {
//     try {
//       final hasAccess = await _ensureLocationAccess();
//       if (!hasAccess) return [];
//       return await locationFromAddress(address);
//     } catch (e) {
//       errorLog('addressToCoordinate error: $e');
//       return [];
//     }
//   }
//
//   static Future<List<Placemark>> coordinateToAddress({
//     required double latitude,
//     required double longitude,
//   }) async {
//     try {
//       final hasAccess = await _ensureLocationAccess();
//       if (!hasAccess) return [];
//       return await placemarkFromCoordinates(latitude, longitude);
//     } catch (e) {
//       errorLog('coordinateToAddress error: $e');
//       return [];
//     }
//   }
// }
