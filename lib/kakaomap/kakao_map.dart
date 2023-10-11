/*
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:flutter/material.dart';
class Map1DefaultScreen extends StatefulWidget {
  const Map1DefaultScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<Map1DefaultScreen> createState() => _Map1DefaultScreenState();
}

class _Map1DefaultScreenState extends State<Map1DefaultScreen> {
  late KakaoMapController mapController;
  String selectedTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? selectedTitle),
      ),
      body: KakaoMap(
        onMapTap: (latLng) {
          print(latLng);
        },
      ),
    );
  }
}
 */

/*
// 구글지도 버전1
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.542117, 126.881813);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
*/


/*
//구글 지도 버전2
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('GoogleMap'),
      ),
      body: MapSample(),
    ),
  ),
  );
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
*/


/*
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.542117, 126.881813);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Place Picker에서 선택된 위치를 처리하는 함수
  void _handlePressButton() async {
    // Navigator를 사용하여 Place Picker 화면을 엽니다.
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
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handlePressButton,
          tooltip: 'Pick Place',
          child: Icon(Icons.add_location),
        ),
      ),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.542117, 126.881813);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Place Picker에서 선택된 위치를 처리하는 함수
  void _handlePressButton(BuildContext context) async {
    // Navigator를 사용하여 Place Picker 화면을 엽니다.
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
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _handlePressButton(context);
          },
          tooltip: 'Pick Place',
          child: Icon(Icons.add_location),
        ),
      ),
    );
  }
}

*/

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 추가
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.542117, 126.881813);
  String selectedAddress = ''; // 선택된 주소를 저장할 변수 추가

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Place Picker에서 선택된 위치를 처리하는 함수
  void _handlePressButton(BuildContext context) async {
    // Navigator를 사용하여 Place Picker 화면을 엽니다.
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
      }
      if (result.formattedAddress != null) {
        final selectedAddress = result.formattedAddress!;
        print("Selected Place Address: $selectedAddress");
        setState(() {
          this.selectedAddress = selectedAddress;
        });
      } else {
        print("Selected Place Address is null.");
        setState(() {
          this.selectedAddress = ""; // 주소가 없을 때 빈 문자열로 설정
        });
      }
    }
  }

  // 주소를 클립보드에 복사하는 함수 추가
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: selectedAddress));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('주소가 클립보드에 복사되었습니다.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
          actions: [
            IconButton(
              icon: Icon(Icons.copy), // 클립보드 아이콘 추가
              onPressed: _copyToClipboard,
            ),
          ],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _handlePressButton(context);
          },
          tooltip: 'Pick Place',
          child: Icon(Icons.add_location),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 추가
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.542117, 126.881813);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Place Picker에서 선택된 위치를 처리하는 함수
  void _handlePressButton(BuildContext context) async {
    // Navigator를 사용하여 Place Picker 화면을 엽니다.
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
      }
      if (result.formattedAddress != null) {
        final selectedAddress = result.formattedAddress!;
        print("Selected Place Address: $selectedAddress");

        // 주소를 클립보드에 복사
        Clipboard.setData(ClipboardData(text: selectedAddress));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('주소가 클립보드에 복사되었습니다.'),
          ),
        );
      } else {
        print("Selected Place Address is null.");
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
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _handlePressButton(context);
          },
          tooltip: 'Pick Place',
          child: Icon(Icons.add_location),
        ),
      ),
    );
  }
}
