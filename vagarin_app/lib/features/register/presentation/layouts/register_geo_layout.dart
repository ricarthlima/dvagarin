import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vagarin_app/core/services/geocoding_service.dart';
import 'package:vagarin_app/shared/widgets/location_map.dart';

import '../../../../core/services/location_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/injection_container.dart';
import '../stores/register_store.dart';
import '../widget/register_scaffold_layout.dart';

class RegisterGeoLayout extends StatelessWidget {
  const RegisterGeoLayout({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterStore registerStore = getIt<RegisterStore>();

    return RegisterScaffoldLayout(
      title: "Onde você está?",
      subtitle: "Compartilhe sua localização para achar pessoas perto de você!",
      child: Observer(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              SizedBox(
                width: 256,
                height: 256,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: !registerStore.hasLocation
                      ? Icon(Icons.location_on, size: 92)
                      : ClipRect(
                          child: LocationMap(
                            position: registerStore.geoPosition!,
                          ),
                        ),
                ),
              ),
              if (registerStore.hasLocation)
                FutureBuilder(
                  future: GeocodingService.getAddressFromPosition(
                    registerStore.geoPosition!,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data ?? '',
                        textAlign: TextAlign.center,
                      );
                    }
                    return SizedBox();
                  },
                ),
              ElevatedButton(
                onPressed: () {
                  _shareLocalization(
                    context: context,
                    registerStore: registerStore,
                  );
                },
                child: Text("Compartilhar localização"),
              ),
              if (registerStore.hasLocation)
                ElevatedButton(
                  onPressed: () {
                    registerStore.cleanGeo();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.error),
                  ),
                  child: Text("Remover localização"),
                ),
            ],
          );
        },
      ),
    );
  }

  void _shareLocalization({
    required BuildContext context,
    required RegisterStore registerStore,
  }) async {
    try {
      Position pos = await LocationService.getPosition();
      registerStore.setGeo(pos: pos);
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Ocorreu um problema"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }
}
