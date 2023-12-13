import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'maps_revisao_widget.dart' show MapsRevisaoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MapsRevisaoModel extends FlutterFlowModel<MapsRevisaoWidget> {
  ///  Local state fields for this component.

  List<dynamic> latlng = [];
  void addToLatlng(dynamic item) => latlng.add(item);
  void removeFromLatlng(dynamic item) => latlng.remove(item);
  void removeAtIndexFromLatlng(int index) => latlng.removeAt(index);
  void insertAtIndexInLatlng(int index, dynamic item) =>
      latlng.insert(index, item);
  void updateLatlngAtIndex(int index, Function(dynamic) updateFn) =>
      latlng[index] = updateFn(latlng[index]);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
