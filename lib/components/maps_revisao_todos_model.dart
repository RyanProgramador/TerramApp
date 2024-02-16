import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'maps_revisao_todos_widget.dart' show MapsRevisaoTodosWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MapsRevisaoTodosModel extends FlutterFlowModel<MapsRevisaoTodosWidget> {
  ///  Local state fields for this component.

  List<String> latlng = [];
  void addToLatlng(String item) => latlng.add(item);
  void removeFromLatlng(String item) => latlng.remove(item);
  void removeAtIndexFromLatlng(int index) => latlng.removeAt(index);
  void insertAtIndexInLatlng(int index, String item) =>
      latlng.insert(index, item);
  void updateLatlngAtIndex(int index, Function(String) updateFn) =>
      latlng[index] = updateFn(latlng[index]);

  Color? cor;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
