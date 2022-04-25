import 'package:latlong2/latlong.dart' as ll;

final mapMarkers = [
  MapMarker('626553e0955589ea4ac8a3fb', 'Hôpital Habib Thameur',
      'Montfleury, Tunis', ll.LatLng(36.78683658491015, 10.176596979029252)),
  MapMarker(
      '62655736955589ea4ac8a415',
      'Hôpital régional Taher Maamouri Nabeul',
      'Avenue eazzdine chelbi Mrezgua 8000 nabeul',
      ll.LatLng(36.43869079046181, 10.674216563518055)),
  MapMarker(
      '62655753955589ea4ac8a418',
      'Hôpital Aziza Othmana',
      'Boulevard 9 Avril 1938, Tunis-1006 tn',
      ll.LatLng(36.79754360929281, 10.169297840415407)),
  MapMarker(
      '62655770955589ea4ac8a41b',
      'Hôpital Mongi Slim',
      'Sidi Daoud, la Marsa, 2070 tn',
      ll.LatLng(36.86708115446899, 10.290127009528966)),
];

class MapMarker {
  final String id;
  final String title;
  final String address;
  final ll.LatLng coords;

  MapMarker(this.id, this.title, this.address, this.coords);
  @override
  String toString() {
    return 'HopitalData{nomHospital: $title, addresseHospital: $address, phoneHospital: $coords}';
  }
}
