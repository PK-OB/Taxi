import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

void main() => runApp(const MyApp1());

class MyApp1 extends StatefulWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.542117, 126.881813);
  late PickResult selectedDeparture;
  late PickResult selectedArrival;

  @override
  void initState() {
    super.initState();
    selectedDeparture = PickResult(); // 초기값 설정
    selectedArrival = PickResult();   // 초기값 설정
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _handlePressButton(BuildContext context, bool isDeparture) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PlacePicker(
            apiKey: 'AIzaSyAdS0OgXmm2YzCS4z_UX8UHP7TO6WA3w8E', // 본인의 API 키로 변경
            initialPosition: _center,
            useCurrentLocation: true,
          );
        },
      ),
    );

    // 선택한 장소의 정보를 처리합니다.
    if (result != null && result is PickResult) {
      if (result.geometry != null && result.geometry!.location != null) {
        final LatLng selectedLocation = LatLng(
          result.geometry!.location.lat,
          result.geometry!.location.lng,
        );
        print("Selected Location: $selectedLocation");

        if (isDeparture) {
          setState(() {
            selectedDeparture = result;
          });
        } else {
          setState(() {
            selectedArrival = result;
          });
        }
      }
      if (result.formattedAddress != null) {
        print("Selected Place Address: ${result.formattedAddress}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Column(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _handlePressButton(context, true),
                  child: Text('출발 장소 선택'),
                ),
                ElevatedButton(
                  onPressed: () => _handlePressButton(context, false),
                  child: Text('도착 장소 선택'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('출발 장소: ${selectedDeparture?.formattedAddress ?? "선택 안됨"}'),
            Text('도착 장소: ${selectedArrival?.formattedAddress ?? "선택 안됨"}'),
          ],
        ),
      ),
    );
  }
}
