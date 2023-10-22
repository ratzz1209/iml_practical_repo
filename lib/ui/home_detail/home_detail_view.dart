import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/common_colors.dart';

class HomeDetailView extends StatefulWidget {
  final Map<String, dynamic> mapData;

  const HomeDetailView({super.key, required this.mapData});

  @override
  State<HomeDetailView> createState() => _HomeDetailViewState();
}

class _HomeDetailViewState extends State<HomeDetailView> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: CommonColors.mWhite),
      ),
      body: Stack(
        children: [
          GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.mapData["lat"], widget.mapData["lon"]),
                zoom: 16.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("marker1"),
                  position:
                  LatLng(widget.mapData["lat"], widget.mapData["lon"]),
                  infoWindow: InfoWindow(
                    title: "current lat long",
                    snippet:
                    "${widget.mapData["lat"]},${widget.mapData["lon"]}",
                  ), // InfoWindow
                ),
              } //Mark,
          ),
          Positioned(
            bottom: 20,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: CommonColors.mWhite,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: CommonColors.mGrey,
                      blurRadius: .5,
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mapData["name"],
                        maxLines: 1,
                        style: const TextStyle(
                          color: CommonColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${widget.mapData["city"]},${widget.mapData["state"]}",
                        maxLines: 1,
                        style: const TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.mapData["country"],
                        maxLines: 1,
                        style: const TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.mapData["tz"],
                        maxLines: 1,
                        style: const TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.mapData["icao"],
                    maxLines: 1,
                    style: const TextStyle(
                      color: CommonColors.yellowColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}