// services/gpx_service.dart
import 'package:gpx/gpx.dart' as gpx;
import 'package:yandex_mapkit/yandex_mapkit.dart';

class GpxService {
  static Future<List<PlacemarkMapObject>> parseWaypoints(String gpxContent) async {
    final gpxData = gpx.GpxReader.fromString(gpxContent);

    return gpxData.wpts.map((wpt) {
      return PlacemarkMapObject(
        mapId: MapObjectId('waypoint_${wpt.lat}_${wpt.lon}'),
        point: Point(latitude: wpt.lat!, longitude: wpt.lon!),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/icons/pin_red.png'),
            scale: 1.0,
          ),
        ),
        opacity: 1.0,
        onTap: (placemark, point) {
          print('Тап на точку: ${wpt.name ?? 'Без имени'}');
        },
      );
    }).toList();
  }

  static Future<List<PolylineMapObject>> parseTracks(String gpxContent) async {
    final gpxData = gpx.GpxReader.fromString(gpxContent);

    List<PolylineMapObject> polylines = [];

    for (var trk in gpxData.trks) {
      for (var segment in trk.trkseg) {
        final points = segment.trkpts.map((pt) => 
          Point(latitude: pt.lat!, longitude: pt.lon!)
        ).toList();

        if (points.isNotEmpty) {
          polylines.add(
            PolylineMapObject(
              mapId: MapObjectId('track_${trk.name ?? DateTime.now().millisecondsSinceEpoch}'),
              polyline: Polyline(points: points),
              strokeColor: Colors.redAccent,
              strokeWidth: 4.0,
              outlineColor: Colors.redAccent.withOpacity(0.3),
              outlineWidth: 8.0,
            ),
          );
        }
      }
    }

    return polylines;
  }
}