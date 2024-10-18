import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WhereIsOrderScreen extends StatefulWidget {
  const WhereIsOrderScreen({super.key});

  @override
  State<WhereIsOrderScreen> createState() => _WhereIsOrderScreenState();
}

class _WhereIsOrderScreenState extends State<WhereIsOrderScreen> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: const MapOptions(
          initialCenter: LatLng(37.862499, 58.238056),
          initialZoom: 9.2,
          keepAlive: true,
          interactionOptions: InteractionOptions(
            flags: ~InteractiveFlag.doubleTapDragZoom,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.halkmarket_ecommerce',
          ),
        ],
      ),
    );
  }
}
