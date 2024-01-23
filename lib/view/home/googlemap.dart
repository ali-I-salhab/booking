import 'package:booking/controller/home/authaccountcontroller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Googlemap extends StatelessWidget {
  const Googlemap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // AuthaccountinfoController controller = Get.find();

    // MapController mapController = MapController(
    //   initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    //   areaLimit: BoundingBox(
    //     east: 10.4922941,
    //     north: 47.8084648,
    //     south: 45.817995,
    //     west: 5.9559113,
    //   ),
    // );
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Location"),
    //     ),
    //     body: OSMFlutter(
    //         controller: mapController,
    //         osmOption: OSMOption(
    //           userTrackingOption: const UserTrackingOption(
    //             enableTracking: true,
    //             unFollowUser: false,
    //           ),
    //           zoomOption: const ZoomOption(
    //             initZoom: 8,
    //             minZoomLevel: 3,
    //             maxZoomLevel: 19,
    //             stepZoom: 1.0,
    //           ),
    //           userLocationMarker: UserLocationMaker(
    //             personMarker: const MarkerIcon(
    //               icon: Icon(
    //                 Icons.location_history_rounded,
    //                 color: Colors.red,
    //                 size: 48,
    //               ),
    //             ),
    //             directionArrowMarker: const MarkerIcon(
    //               icon: Icon(
    //                 Icons.double_arrow,
    //                 size: 48,
    //               ),
    //             ),
    //           ),
    //           roadConfiguration: const RoadOption(
    //             roadColor: Colors.yellowAccent,
    //           ),
    //           markerOption: MarkerOption(
    //               defaultMarker: const MarkerIcon(
    //             icon: Icon(
    //               Icons.person_pin_circle,
    //               color: Colors.blue,
    //               size: 56,
    //             ),
    //           )),
    //         )));
  }
}
