import 'package:energise_test/data/model/ip_model.dart';
import 'package:energise_test/data/provider/map_provider.dart';
import 'package:energise_test/domain/network/api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class SecondScreen extends StatelessWidget {
  SecondScreen({super.key});
  late GoogleMapController mapController;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context, listen: false);
    fetchApi(IpApiCall(), provider);
    return SafeArea(
      child: Scaffold(
        body: Consumer<MapProvider>(builder: (context, mapData, child) {
          if (mapData.ipCallModel.lon != null) {
            return Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 400,
                  child: GoogleMap(
                    onMapCreated: (controller) => _onMapCreated(controller),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          mapData.ipCallModel.lat!, mapData.ipCallModel.lon!),
                      zoom: 10.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(mapData.ipCallModel.city!),
                        position: LatLng(mapData.ipCallModel.lat!,
                            mapData.ipCallModel.lon ?? 52),
                      )
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await fetchApi(IpApiCall(), provider);
                      await Future.delayed(const Duration(seconds: 2));
                      mapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(mapData.ipCallModel.lat!,
                                  mapData.ipCallModel.lon!),
                              zoom: 10)));
                    },
                    child: AnimationLimiter(
                      child: AnimatedList(
                        key: _listKey,
                        initialItemCount: mapData.listItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index, animation) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 300),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Card(
                                  elevation: 10,
                                  child: ListTile(
                                      title: Text(
                                          mapData.listItems[index].toString())),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await fetchApi(IpApiCall(), provider);
                    },
                    child: const Text("Reload")),
              ],
            );
          } else {
            return const Center(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  )),
            );
          }
        }),
      ),
    );
  }

  Future<IpCallModel> fetchApi(IpApiCall model, MapProvider mapProvider) async {
    var data = await model.fetchIpData();
    mapProvider.fillModel(data);
    return data;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
