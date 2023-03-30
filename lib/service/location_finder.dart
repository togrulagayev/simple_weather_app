import 'package:location/location.dart';

class LocationFinder {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    // ignore: unused_local_variable
    var accuracy = LocationAccuracy.high;
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;
  }
}
