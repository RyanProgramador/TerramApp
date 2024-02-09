import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: FlutterFlowTheme.of(context).primary,
                child: Center(
                  child: Image.asset(
                    'assets/images/splash.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: FlutterFlowTheme.of(context).primary,
                    child: Center(
                      child: Image.asset(
                        'assets/images/splash.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : LoginWidget(),
          routes: [
            FFRoute(
              name: 'MultiplePlacesPicker',
              path: 'multiplePlacesPicker',
              builder: (context, params) => MultiplePlacesPickerWidget(),
            ),
            FFRoute(
              name: 'MultiplePlacesPickerCopy',
              path: 'multiplePlacesPickerCopy',
              builder: (context, params) => MultiplePlacesPickerCopyWidget(),
            ),
            FFRoute(
              name: 'Login',
              path: 'login',
              builder: (context, params) => LoginWidget(),
            ),
            FFRoute(
              name: 'SelecionarOS',
              path: 'selecionarOS',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'SelecionarOS')
                  : SelecionarOSWidget(),
            ),
            FFRoute(
              name: 'Alertas',
              path: 'alertas',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Alertas')
                  : AlertasWidget(),
            ),
            FFRoute(
              name: 'EsqueceuSenha',
              path: 'esqueceuSenha',
              builder: (context, params) => EsqueceuSenhaWidget(),
            ),
            FFRoute(
              name: 'Configuracoes',
              path: 'configuracoes',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Configuracoes')
                  : ConfiguracoesWidget(),
            ),
            FFRoute(
              name: 'GpsTecToFazenda',
              path: 'gpsTecToFazenda',
              builder: (context, params) => GpsTecToFazendaWidget(
                jsonServico: params.getParam('jsonServico', ParamType.JSON),
                tecnicoId: params.getParam('tecnicoId', ParamType.String),
                servicoId: params.getParam('servicoId', ParamType.String),
                fazNome: params.getParam('fazNome', ParamType.String),
                latlngFaz: params.getParam('latlngFaz', ParamType.LatLng),
                retornoAPI: params.getParam('retornoAPI', ParamType.String),
                retornopolylines:
                    params.getParam('retornopolylines', ParamType.String),
                comRota: params.getParam('comRota', ParamType.bool),
                rotaInversa: params.getParam('rotaInversa', ParamType.bool),
                rotaInversaString:
                    params.getParam('rotaInversaString', ParamType.String),
                cidadeFaz: params.getParam('cidadeFaz', ParamType.String),
                estadoFaz: params.getParam('estadoFaz', ParamType.String),
                observacao: params.getParam('observacao', ParamType.String),
                data: params.getParam('data', ParamType.String),
                horar: params.getParam('horar', ParamType.String),
                fazid: params.getParam('fazid', ParamType.String),
                autoAuditoria: params.getParam('autoAuditoria', ParamType.bool),
                autoAuditoriaQuantidadePontos: params.getParam(
                    'autoAuditoriaQuantidadePontos', ParamType.int),
                etapaDe: params.getParam('etapaDe', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'testecontorno',
              path: 'testecontorno',
              builder: (context, params) => TestecontornoWidget(
                contornoGrupo: params.getParam('contornoGrupo', ParamType.JSON),
              ),
            ),
            FFRoute(
              name: 'ContornoDaFazenda',
              path: 'contornoDaFazenda',
              builder: (context, params) => ContornoDaFazendaWidget(
                fazendaNome: params.getParam('fazendaNome', ParamType.String),
                oservID: params.getParam('oservID', ParamType.String),
                idDoContorno: params.getParam('idDoContorno', ParamType.String),
                fazid: params.getParam('fazid', ParamType.String),
                fazlatlng: params.getParam('fazlatlng', ParamType.LatLng),
              ),
            ),
            FFRoute(
              name: 'ListaContornos',
              path: 'listaContornos',
              builder: (context, params) => ListaContornosWidget(
                nomeFazenda: params.getParam('nomeFazenda', ParamType.String),
                oservID: params.getParam('oservID', ParamType.String),
                fazid: params.getParam('fazid', ParamType.String),
                fazlatlng: params.getParam('fazlatlng', ParamType.LatLng),
              ),
            ),
            FFRoute(
              name: 'blankRedirecona',
              path: 'blankRedirecona',
              builder: (context, params) => BlankRedireconaWidget(),
            ),
            FFRoute(
              name: 'MedicaoColeta',
              path: 'medicaoColeta',
              builder: (context, params) => MedicaoColetaWidget(
                fazNome: params.getParam('fazNome', ParamType.String),
                idContorno: params.getParam('idContorno', ParamType.String),
                autoAuditoria: params.getParam('autoAuditoria', ParamType.bool),
                quantosPontosAutoAuditoria: params.getParam(
                    'quantosPontosAutoAuditoria', ParamType.int),
              ),
            ),
            FFRoute(
              name: 'ContornoRecorteDaFazenda',
              path: 'contornoRecorteDaFazenda',
              builder: (context, params) => ContornoRecorteDaFazendaWidget(
                fazendaNome: params.getParam('fazendaNome', ParamType.String),
                oservID: params.getParam('oservID', ParamType.String),
                idDoContorno: params.getParam('idDoContorno', ParamType.String),
                fazid: params.getParam('fazid', ParamType.String),
                fazlatlng: params.getParam('fazlatlng', ParamType.LatLng),
                listaLatLngTalhao: params.getParam<String>(
                    'listaLatLngTalhao', ParamType.String, true),
              ),
            ),
            FFRoute(
              name: 'ListaContornosParaColeta',
              path: 'listaContornosParaColeta',
              builder: (context, params) => ListaContornosParaColetaWidget(
                nomeFazenda: params.getParam('nomeFazenda', ParamType.String),
                oservID: params.getParam('oservID', ParamType.String),
                fazid: params.getParam('fazid', ParamType.String),
                fazlatlng: params.getParam('fazlatlng', ParamType.LatLng),
              ),
            ),
            FFRoute(
              name: 'IniciarDeslocamentoTela',
              path: 'iniciarDeslocamentoTela',
              builder: (context, params) => IniciarDeslocamentoTelaWidget(
                etapade: params.getParam('etapade', ParamType.String),
                fazendaNome: params.getParam('fazendaNome', ParamType.String),
                latlngFaz: params.getParam('latlngFaz', ParamType.LatLng),
                cidadeFaz: params.getParam('cidadeFaz', ParamType.String),
                estadoFaz: params.getParam('estadoFaz', ParamType.String),
                observacao: params.getParam('observacao', ParamType.String),
                tecnicoid: params.getParam('tecnicoid', ParamType.String),
                servicoid: params.getParam('servicoid', ParamType.String),
                data: params.getParam('data', ParamType.String),
                hora: params.getParam('hora', ParamType.String),
                jsonServico: params.getParam('jsonServico', ParamType.JSON),
                deslocamentoAtualFinalizado: params.getParam(
                    'deslocamentoAtualFinalizado', ParamType.bool),
                polylinhaQueVemDoMenuInicial: params.getParam(
                    'polylinhaQueVemDoMenuInicial', ParamType.String),
                fazid: params.getParam('fazid', ParamType.String),
                autoAuditoria: params.getParam('autoAuditoria', ParamType.bool),
                autoAuditoriaQuantidadePontos: params.getParam(
                    'autoAuditoriaQuantidadePontos', ParamType.int),
              ),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
