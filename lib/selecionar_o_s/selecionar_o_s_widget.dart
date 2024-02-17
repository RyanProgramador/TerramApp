import '/backend/api_requests/api_calls.dart';
import '/components/carregando_os_widget.dart';
import '/components/loading_comp_widget.dart';
import '/components/pesquisa_avanadabtn_widget.dart';
import '/components/vazio_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'selecionar_o_s_model.dart';
export 'selecionar_o_s_model.dart';

class SelecionarOSWidget extends StatefulWidget {
  const SelecionarOSWidget({super.key});

  @override
  State<SelecionarOSWidget> createState() => _SelecionarOSWidgetState();
}

class _SelecionarOSWidgetState extends State<SelecionarOSWidget>
    with TickerProviderStateMixin {
  late SelecionarOSModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelecionarOSModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      _model.checkgps = await actions.checkGps();
      _model.temInternetOsLoad = await actions.temInternet();
      if (!_model.checkgps!) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Por favor, ative sua localização.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
        return;
      }
      if ((FFAppState().trOsDeslocamentosJsonFinalizados.length != 0) &&
          (FFAppState().sincronizcaoAutomatica == true) &&
          _model.temInternetOsLoad!) {
        _model.apiResultxxdOnLoadPage =
            await SincronizarGroup.trSincronizaCelularComBDCall.call(
          urlapicall: FFAppState().urlapicall,
          lista: functions.jsonListToStr(
              FFAppState().trOsDeslocamentosJsonFinalizados.toList()),
          listaGeo: functions.jsonListToStr(FFAppState().trDeslocGeo2.toList()),
        );
        _model.trSincTalhao =
            await SincronizarGroup.trSincronizaTalhaoContornoCall.call(
          talhao: functions
              .jsonListToStr(FFAppState().grupoContornoFazendas.toList()),
          contorno:
              functions.jsonListToStr(FFAppState().contornoFazenda.toList()),
          urlapicall: FFAppState().urlapicall,
          recorte: functions
              .jsonListToStr(FFAppState().latlngRecorteTalhao.toList()),
        );
        _model.sincPontosMedicaoEPerfilEProfundidaAPI =
            await SincronizarGroup.trSincronizaPontosMedicaoCall.call(
          urlapicall: FFAppState().urlapicall,
          pontosColetados:
              functions.jsonListToStr(FFAppState().PontosColetados.toList()),
        );
        if (SincronizarGroup.trSincronizaCelularComBDCall.statusSincComCelular(
              (_model.apiResultxxdOnLoadPage?.jsonBody ?? ''),
            )! &&
            getJsonField(
              (_model.trSincTalhao?.jsonBody ?? ''),
              r'''$.status''',
            )) {
          setState(() {
            FFAppState().grupoContornoFazendasPosSincronizado = functions
                .juntarDuasListasJson(
                    FFAppState().grupoContornoFazendas.toList(),
                    FFAppState().grupoContornoFazendasPosSincronizado.toList())!
                .toList()
                .cast<dynamic>();
            FFAppState().contornoFazendaPosSincronizado = functions
                .juntarDuasListasJson(FFAppState().contornoFazenda.toList(),
                    FFAppState().contornoFazendaPosSincronizado.toList())!
                .toList()
                .cast<dynamic>();
          });
          setState(() {
            FFAppState().grupoContornoFazendasPosSincronizado = functions
                .juntarDuasListasJsonignoraDuplicados(
                    FFAppState().grupoContornoFazendasPosSincronizado.toList(),
                    SincronizarGroup.trSincronizaTalhaoContornoCall
                        .dadosGrupoContornoSincDoWeb(
                          (_model.trSincTalhao?.jsonBody ?? ''),
                        )
                        ?.toList())!
                .toList()
                .cast<dynamic>();
            FFAppState().contornoFazendaPosSincronizado = functions
                .juntarDuasListasJsonignoraDuplicados(
                    FFAppState().contornoFazendaPosSincronizado.toList(),
                    SincronizarGroup.trSincronizaTalhaoContornoCall
                        .dadosContornosSincDaWeb(
                          (_model.trSincTalhao?.jsonBody ?? ''),
                        )
                        ?.toList())!
                .toList()
                .cast<dynamic>();
            FFAppState().latlngRecorteTalhaoPosSincronizado = functions
                .juntarDuasListasJsonignoraDuplicados(
                    FFAppState().latlngRecorteTalhao.toList(),
                    FFAppState().latlngRecorteTalhaoPosSincronizado.toList())!
                .toList()
                .cast<dynamic>();
            FFAppState().pontosDeColeta = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundidaAPI?.jsonBody ?? ''),
              r'''$.pontos_de_coleta[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().perfilprofundidades = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundidaAPI?.jsonBody ?? ''),
              r'''$.perfil_profundidades[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().profundidades = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundidaAPI?.jsonBody ?? ''),
              r'''$.profundidades[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().perfis = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundidaAPI?.jsonBody ?? ''),
              r'''$.perfis[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().profundidadesPonto = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundidaAPI?.jsonBody ?? ''),
              r'''$.pontos_profundidades[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().listaContornoColeta = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundidaAPI?.jsonBody ?? ''),
              r'''$.contornos[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
          });
          FFAppState().update(() {
            FFAppState().trOsDeslocamentosJsonFinalizados = [];
            FFAppState().trDeslocamentoGeo = [];
            FFAppState().trDeslocGeo2 = [];
            FFAppState().contornoGrupoID = '';
            FFAppState().grupoContornoFazendas = [];
            FFAppState().contornoFazenda = [];
            FFAppState().PontosColetados = [];
          });
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: Text('Ops!'),
                content: Text(
                    'Um erro inesperado aconteceu ao sincronizar automaticamente'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
          setState(() {
            FFAppState().grupoContornoFazendasPosSincronizado = functions
                .juntarDuasListasJsonignoraDuplicados(
                    FFAppState().grupoContornoFazendasPosSincronizado.toList(),
                    SincronizarGroup.trSincronizaTalhaoContornoCall
                        .dadosGrupoContornoSincDoWeb(
                          (_model.trSincTalhao?.jsonBody ?? ''),
                        )
                        ?.toList())!
                .toList()
                .cast<dynamic>();
            FFAppState().contornoFazendaPosSincronizado = functions
                .juntarDuasListasJsonignoraDuplicados(
                    FFAppState().contornoFazendaPosSincronizado.toList(),
                    SincronizarGroup.trSincronizaTalhaoContornoCall
                        .dadosContornosSincDaWeb(
                          (_model.trSincTalhao?.jsonBody ?? ''),
                        )
                        ?.toList())!
                .toList()
                .cast<dynamic>();
            FFAppState().latlngRecorteTalhaoPosSincronizado = functions
                .juntarDuasListasJsonignoraDuplicados(
                    FFAppState().latlngRecorteTalhao.toList(),
                    FFAppState().latlngRecorteTalhaoPosSincronizado.toList())!
                .toList()
                .cast<dynamic>();
          });
        }
      } else if ((FFAppState().sincronizcaoAutomatica == false) &&
          (FFAppState().servicosFinalizadosComSucesso.length != 0)) {
      } else if ((FFAppState().trOrdemServicos.length <= 0) &&
          _model.foiAtualizado) {
      } else {
        _model.sincPontosMedicaoPontosAPI =
            await SincronizarGroup.trSincronizaPontosMedicaoCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        FFAppState().update(() {
          FFAppState().pontosDeColeta = getJsonField(
            (_model.sincPontosMedicaoPontosAPI?.jsonBody ?? ''),
            r'''$.pontos_de_coleta[:]''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          FFAppState().perfilprofundidades = getJsonField(
            (_model.sincPontosMedicaoPontosAPI?.jsonBody ?? ''),
            r'''$.perfil_profundidades[:]''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          FFAppState().profundidades = getJsonField(
            (_model.sincPontosMedicaoPontosAPI?.jsonBody ?? ''),
            r'''$.profundidades[:]''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          FFAppState().perfis = getJsonField(
            (_model.sincPontosMedicaoPontosAPI?.jsonBody ?? ''),
            r'''$.perfis[:]''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          FFAppState().profundidadesPonto = getJsonField(
            (_model.sincPontosMedicaoPontosAPI?.jsonBody ?? ''),
            r'''$.pontos_profundidades[:]''',
            true,
          )!
              .toList()
              .cast<dynamic>();
          FFAppState().listaContornoColeta = getJsonField(
            (_model.sincPontosMedicaoPontosAPI?.jsonBody ?? ''),
            r'''$.contornos[:]''',
            true,
          )!
              .toList()
              .cast<dynamic>();
        });
      }

      await requestPermission(locationPermission);
      await requestPermission(notificationsPermission);
      setState(() {
        FFAppState().AtualLocalizcao = currentUserLocationValue!.toString();
      });
      if (FFAppState().trOsServicos.length == 0) {
        _model.trOsTecnicosSincroniza =
            await SincronizarGroup.trOsTecnicoCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        _model.sincOsRet = await SincronizarGroup.ordemDeServicoCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        _model.trFazendasSinc = await SincronizarGroup.trFazendasCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        _model.sincPontosMedicaoEPerfilEProfundida2 =
            await SincronizarGroup.trSincronizaPontosMedicaoCall.call(
          urlapicall: FFAppState().urlapicall,
          pontosColetados:
              functions.jsonListToStr(FFAppState().PontosColetados.toList()),
        );
        _model.trServicosSinc = await SincronizarGroup.trServicosCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        _model.trOsServicosSinc = await SincronizarGroup.trOsServicosCall.call(
          urlapicall: FFAppState().urlapicall,
          tecId: FFAppState().tecID,
        );
        _model.trTecnicosSinc = await SincronizarGroup.trTecnicosCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        _model.trEmpresas = await SincronizarGroup.trEmpresasCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        _model.trCFG = await SincronizarGroup.trCFGCall.call(
          urlapicall: FFAppState().urlapicall,
        );
        FFAppState().update(() {});
        if ((_model.trTecnicosSinc?.succeeded ?? true) &&
            (_model.trOsServicosSinc?.succeeded ?? true) &&
            (_model.trServicosSinc?.succeeded ?? true) &&
            (_model.trFazendasSinc?.succeeded ?? true) &&
            (_model.sincOsRet?.succeeded ?? true) &&
            (_model.trOsTecnicosSincroniza?.succeeded ?? true)) {
          FFAppState().update(() {
            FFAppState().trOrdemServicos = SincronizarGroup.ordemDeServicoCall
                .ordemServicoDados(
                  (_model.sincOsRet?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().trFazendas = SincronizarGroup.trFazendasCall
                .dadosTrFazendas(
                  (_model.trFazendasSinc?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().trOsTecnicos = SincronizarGroup.trOsTecnicoCall
                .dadosTrOsTecnico(
                  (_model.trOsTecnicosSincroniza?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().trOsServicos = SincronizarGroup.trOsServicosCall
                .dadosTrOsServicos(
                  (_model.trOsServicosSinc?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().trServicos = SincronizarGroup.trServicosCall
                .dadosTrServicos(
                  (_model.trServicosSinc?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().trTecnicos = SincronizarGroup.trTecnicosCall
                .dadosTrTecnicos(
                  (_model.trTecnicosSinc?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().trEmpresas = SincronizarGroup.trEmpresasCall
                .dadosTrEmpresas(
                  (_model.trEmpresas?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
            FFAppState().tempoEmSegundosPadraoDeCapturaDeLocal =
                SincronizarGroup.trCFGCall.dadosCFG(
              (_model.trCFG?.jsonBody ?? ''),
            );
            FFAppState().distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra =
                SincronizarGroup.trCFGCall.geoTolerancia(
              (_model.trCFG?.jsonBody ?? ''),
            );
            FFAppState().pontosDeColeta = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundida2?.jsonBody ?? ''),
              r'''$.pontos_de_coleta[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().perfilprofundidades = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundida2?.jsonBody ?? ''),
              r'''$.perfil_profundidades[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().profundidades = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundida2?.jsonBody ?? ''),
              r'''$.profundidades[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().perfis = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundida2?.jsonBody ?? ''),
              r'''$.perfis[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().listaContornoColeta = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundida2?.jsonBody ?? ''),
              r'''$.contornos[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
            FFAppState().profundidadesPonto = getJsonField(
              (_model.sincPontosMedicaoEPerfilEProfundida2?.jsonBody ?? ''),
              r'''$.pontos_profundidades[:]''',
              true,
            )!
                .toList()
                .cast<dynamic>();
          });
          FFAppState().update(() {});
          return;
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: Text('Ops!'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
          return;
        }
      } else {
        _model.temInternetOsLoad01 = await actions.temInternet();
        if (_model.temInternetOsLoad01!) {
          _model.trOsTecnicosSincroniza2 =
              await SincronizarGroup.trOsTecnicoCall.call(
            urlapicall: FFAppState().urlapicall,
          );
          _model.sincOsRet2 = await SincronizarGroup.ordemDeServicoCall.call(
            urlapicall: FFAppState().urlapicall,
          );
          _model.trFazendasSinc2 = await SincronizarGroup.trFazendasCall.call(
            urlapicall: FFAppState().urlapicall,
          );
          _model.trServicosSinc2 = await SincronizarGroup.trServicosCall.call(
            urlapicall: FFAppState().urlapicall,
          );
          _model.trOsServicosSinc2 =
              await SincronizarGroup.trOsServicosCall.call(
            urlapicall: FFAppState().urlapicall,
            tecId: FFAppState().tecID,
          );
          _model.trTecnicosSinc2 = await SincronizarGroup.trTecnicosCall.call(
            urlapicall: FFAppState().urlapicall,
          );
          _model.trEmpresas2 = await SincronizarGroup.trEmpresasCall.call(
            urlapicall: FFAppState().urlapicall,
          );
          _model.trCFG2 = await SincronizarGroup.trCFGCall.call(
            urlapicall: FFAppState().urlapicall,
          );
          _model.sincPontosMedicaoEPerfilEProfundida =
              await SincronizarGroup.trSincronizaPontosMedicaoCall.call(
            urlapicall: FFAppState().urlapicall,
            pontosColetados:
                functions.jsonListToStr(FFAppState().PontosColetados.toList()),
          );
          FFAppState().update(() {});
          if ((_model.trTecnicosSinc2?.succeeded ?? true) &&
              (_model.trOsServicosSinc2?.succeeded ?? true) &&
              (_model.trServicosSinc2?.succeeded ?? true) &&
              (_model.trFazendasSinc2?.succeeded ?? true) &&
              (_model.sincOsRet2?.succeeded ?? true) &&
              (_model.trOsTecnicosSincroniza2?.succeeded ?? true)) {
            FFAppState().update(() {
              FFAppState().trOrdemServicos = functions
                  .juntarDuasListasJson(
                      SincronizarGroup.ordemDeServicoCall
                          .ordemServicoDados(
                            (_model.sincOsRet2?.jsonBody ?? ''),
                          )
                          ?.toList(),
                      FFAppState().trOrdemServicos.toList())!
                  .toList()
                  .cast<dynamic>();
              FFAppState().trFazendas = functions
                  .juntarDuasListasJson(
                      SincronizarGroup.trFazendasCall
                          .dadosTrFazendas(
                            (_model.trFazendasSinc2?.jsonBody ?? ''),
                          )
                          ?.toList(),
                      FFAppState().trFazendas.toList())!
                  .toList()
                  .cast<dynamic>();
              FFAppState().trOsTecnicos = functions
                  .juntarDuasListasJson(
                      SincronizarGroup.trOsTecnicoCall
                          .dadosTrOsTecnico(
                            (_model.trOsTecnicosSincroniza2?.jsonBody ?? ''),
                          )
                          ?.toList(),
                      FFAppState().trOsTecnicos.toList())!
                  .toList()
                  .cast<dynamic>();
              FFAppState().trOsServicos = functions
                  .juntarDuasListasJson(
                      SincronizarGroup.trOsServicosCall
                          .dadosTrOsServicos(
                            (_model.trOsServicosSinc2?.jsonBody ?? ''),
                          )
                          ?.toList(),
                      FFAppState().trOsServicos.toList())!
                  .toList()
                  .cast<dynamic>();
              FFAppState().trServicos = functions
                  .juntarDuasListasJson(
                      SincronizarGroup.trServicosCall
                          .dadosTrServicos(
                            (_model.trServicosSinc2?.jsonBody ?? ''),
                          )
                          ?.toList(),
                      FFAppState().trServicos.toList())!
                  .toList()
                  .cast<dynamic>();
              FFAppState().trTecnicos = functions
                  .juntarDuasListasJson(
                      SincronizarGroup.trTecnicosCall
                          .dadosTrTecnicos(
                            (_model.trTecnicosSinc2?.jsonBody ?? ''),
                          )
                          ?.toList(),
                      FFAppState().trTecnicos.toList())!
                  .toList()
                  .cast<dynamic>();
              FFAppState().trEmpresas = functions
                  .juntarDuasListasJson(
                      SincronizarGroup.trEmpresasCall
                          .dadosTrEmpresas(
                            (_model.trEmpresas2?.jsonBody ?? ''),
                          )
                          ?.toList(),
                      FFAppState().trEmpresas.toList())!
                  .toList()
                  .cast<dynamic>();
              FFAppState().tempoEmSegundosPadraoDeCapturaDeLocal =
                  SincronizarGroup.trCFGCall.dadosCFG(
                (_model.trCFG2?.jsonBody ?? ''),
              );
              FFAppState().distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra =
                  SincronizarGroup.trCFGCall.geoTolerancia(
                (_model.trCFG2?.jsonBody ?? ''),
              );
              FFAppState().pontosDeColeta = getJsonField(
                (_model.sincPontosMedicaoEPerfilEProfundida?.jsonBody ?? ''),
                r'''$.pontos_de_coleta[:]''',
                true,
              )!
                  .toList()
                  .cast<dynamic>();
              FFAppState().perfilprofundidades = getJsonField(
                (_model.sincPontosMedicaoEPerfilEProfundida?.jsonBody ?? ''),
                r'''$.perfil_profundidades[:]''',
                true,
              )!
                  .toList()
                  .cast<dynamic>();
              FFAppState().profundidades = getJsonField(
                (_model.sincPontosMedicaoEPerfilEProfundida?.jsonBody ?? ''),
                r'''$.profundidades[:]''',
                true,
              )!
                  .toList()
                  .cast<dynamic>();
              FFAppState().perfis = getJsonField(
                (_model.sincPontosMedicaoEPerfilEProfundida?.jsonBody ?? ''),
                r'''$.perfis[:]''',
                true,
              )!
                  .toList()
                  .cast<dynamic>();
              FFAppState().listaContornoColeta = getJsonField(
                (_model.sincPontosMedicaoEPerfilEProfundida?.jsonBody ?? ''),
                r'''$.contornos[:]''',
                true,
              )!
                  .toList()
                  .cast<dynamic>();
              FFAppState().profundidadesPonto = getJsonField(
                (_model.sincPontosMedicaoEPerfilEProfundida?.jsonBody ?? ''),
                r'''$.pontos_profundidades[:]''',
                true,
              )!
                  .toList()
                  .cast<dynamic>();
            });
          } else {
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('Ops! Um erro inesperado aconteceu '),
                  content: Text('Codigo #02'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                );
              },
            );
            return;
          }

          return;
        } else {
          return;
        }
      }
    });

    _model.searchBarController ??= TextEditingController(
        text: (FFAppState().qualSwitchEstaAtivo == 5) &&
                (_model.calendarRange?.first != null)
            ? 'De: ${dateTimeFormat(
                'd/M/y',
                _model.calendarRange?.first,
                locale: FFLocalizations.of(context).languageCode,
              )} até ${dateTimeFormat(
                'd/M/y',
                _model.calendarRange?.last,
                locale: FFLocalizations.of(context).languageCode,
              )}'
            : null);
    _model.searchBarFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primary,
          body: SafeArea(
            top: true,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/terram-branco.png',
                                width: 350.0,
                                height: 66.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                      child: ClipRRect(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 0.0, 0.0),
                                    child: Text(
                                      'Ordens de serviço:',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 12.0, 8.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .searchBarController,
                                                      focusNode: _model
                                                          .searchBarFocusNode,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        '_model.searchBarController',
                                                        Duration(
                                                            milliseconds: 100),
                                                        () async {
                                                          setState(() {});
                                                        },
                                                      ),
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .words,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: () {
                                                          if (FFAppState()
                                                                  .qualSwitchEstaAtivo ==
                                                              4) {
                                                            return 'Pesquisar número da OS';
                                                          } else if (FFAppState()
                                                                  .qualSwitchEstaAtivo ==
                                                              2) {
                                                            return 'Pesquisar por fazenda';
                                                          } else if (FFAppState()
                                                                  .qualSwitchEstaAtivo ==
                                                              3) {
                                                            return 'Pesquisar por tipo de serviço';
                                                          } else if (FFAppState()
                                                                  .qualSwitchEstaAtivo ==
                                                              5) {
                                                            return 'Pesquisar por data de agendamento';
                                                          } else {
                                                            return 'Pesquisar por cliente';
                                                          }
                                                        }(),
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium,
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    24.0,
                                                                    24.0,
                                                                    20.0,
                                                                    24.0),
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                      minLines: 1,
                                                      validator: _model
                                                          .searchBarControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.95, 0.01),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 12.0, 12.0, 0.0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        Color(0x0080B9B6),
                                                    borderRadius: 30.0,
                                                    borderWidth: 1.0,
                                                    buttonSize: 50.0,
                                                    fillColor:
                                                        Color(0x0080B9B6),
                                                    icon: Icon(
                                                      Icons.search_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .lineColor,
                                                      size: 30.0,
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                              if (FFAppState()
                                                      .qualSwitchEstaAtivo ==
                                                  5)
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.calendarRange =
                                                        await actions
                                                            .calendarRangerAction(
                                                      context,
                                                    );
                                                    setState(() {});
                                                    setState(() {
                                                      _model.searchBarController
                                                          ?.text = ((FFAppState()
                                                                      .qualSwitchEstaAtivo ==
                                                                  5) &&
                                                              (_model.calendarRange
                                                                      ?.first !=
                                                                  null)
                                                          ? 'De: ${dateTimeFormat(
                                                              'd/M/y',
                                                              _model
                                                                  .calendarRange
                                                                  ?.first,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )} até ${dateTimeFormat(
                                                              'd/M/y',
                                                              _model
                                                                  .calendarRange
                                                                  ?.last,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )}'
                                                          : null!);
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: 65.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 12.0, 16.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () => _model.unfocusNode
                                                      .canRequestFocus
                                                  ? FocusScope.of(context)
                                                      .requestFocus(
                                                          _model.unfocusNode)
                                                  : FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child:
                                                    PesquisaAvanadabtnWidget(),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      text: '',
                                      icon: Icon(
                                        Icons.filter_list,
                                        size: 32.0,
                                      ),
                                      options: FFButtonOptions(
                                        width: 80.0,
                                        height: 58.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding: EdgeInsets.all(0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .success,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (_model.searchBarController.text == null ||
                                  _model.searchBarController.text == '')
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(),
                                    child: Visibility(
                                      visible: _model
                                                  .searchBarController.text ==
                                              null ||
                                          _model.searchBarController.text == '',
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 50.0),
                                        child: Builder(
                                          builder: (context) {
                                            final trOsServicos = FFAppState()
                                                .trOsServicos
                                                .toList();
                                            if (trOsServicos.isEmpty) {
                                              return Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: LoadingCompWidget(),
                                                ),
                                              );
                                            }
                                            return RefreshIndicator(
                                              onRefresh: () async {
                                                context.goNamed(
                                                  'blankRedirecona',
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 0),
                                                    ),
                                                  },
                                                );

                                                setState(() {
                                                  _model.foiAtualizado = true;
                                                });
                                              },
                                              child: SingleChildScrollView(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      trOsServicos.length,
                                                      (trOsServicosIndex) {
                                                    final trOsServicosItem =
                                                        trOsServicos[
                                                            trOsServicosIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  8.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 78.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          border: Border.all(
                                                            color: trOsServicosItem ==
                                                                    FFAppState()
                                                                        .trOsServicoEmAndamento
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .customColor1
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .lineColor,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              currentUserLocationValue =
                                                                  await getCurrentUserLocation(
                                                                      defaultLocation:
                                                                          LatLng(
                                                                              0.0,
                                                                              0.0));
                                                              var _shouldSetState =
                                                                  false;
                                                              showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => _model
                                                                            .unfocusNode
                                                                            .canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model
                                                                            .unfocusNode)
                                                                        : FocusScope.of(context)
                                                                            .unfocus(),
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          CarregandoOsWidget(),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              if (true) {
                                                                _model.temNetNoServico =
                                                                    await actions
                                                                        .temInternet();
                                                                _shouldSetState =
                                                                    true;
                                                                if (_model
                                                                    .temNetNoServico!) {
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                } else {
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'Ops!'),
                                                                        content:
                                                                            Text('Você não tem internet, você poderá usar o serviço de localização, entretanto, nenhuma rota será sugerida no momento.'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                            child:
                                                                                Text('Ok'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                  Navigator.pop(
                                                                      context);

                                                                  context
                                                                      .pushNamed(
                                                                    'IniciarDeslocamentoTela',
                                                                    queryParameters:
                                                                        {
                                                                      'etapade':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trServicos.toList(),
                                                                            'serv_id',
                                                                            'serv_nome',
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.oserv_id_serv''',
                                                                            ).toString()),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'fazendaNome':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trFazendas.toList(),
                                                                            'faz_id',
                                                                            'faz_nome',
                                                                            valueOrDefault<String>(
                                                                              functions.ligacaoEntreListas(
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  FFAppState().trOrdemServicos.toList(),
                                                                                  'oserv_id_os',
                                                                                  'os_id',
                                                                                  'os_id_faz'),
                                                                              '404',
                                                                            )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'latlngFaz':
                                                                          serializeParam(
                                                                        functions.strToLatLng(
                                                                            functions.ligaoDeNome(
                                                                                FFAppState().trFazendas.toList(),
                                                                                'faz_id',
                                                                                'faz_latitude',
                                                                                valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                )),
                                                                            functions.ligaoDeNome(
                                                                                FFAppState().trFazendas.toList(),
                                                                                'faz_id',
                                                                                'faz_longitude',
                                                                                valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                ))),
                                                                        ParamType
                                                                            .LatLng,
                                                                      ),
                                                                      'cidadeFaz':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trFazendas.toList(),
                                                                            'faz_id',
                                                                            'faz_cidade',
                                                                            valueOrDefault<String>(
                                                                              functions.ligacaoEntreListas(
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  FFAppState().trOrdemServicos.toList(),
                                                                                  'oserv_id_os',
                                                                                  'os_id',
                                                                                  'os_id_faz'),
                                                                              '404',
                                                                            )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'estadoFaz':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trFazendas.toList(),
                                                                            'faz_id',
                                                                            'faz_estado',
                                                                            valueOrDefault<String>(
                                                                              functions.ligacaoEntreListas(
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  FFAppState().trOrdemServicos.toList(),
                                                                                  'oserv_id_os',
                                                                                  'os_id',
                                                                                  'os_id_faz'),
                                                                              '404',
                                                                            )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'observacao':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_observacao''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'tecnicoid':
                                                                          serializeParam(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions.ligacaoEntreListas(
                                                                              getJsonField(
                                                                                trOsServicosItem,
                                                                                r'''$''',
                                                                                true,
                                                                              ),
                                                                              FFAppState().trOsTecnicos.toList(),
                                                                              'oserv_id',
                                                                              'ostec_id_serv',
                                                                              'ostec_id_tec'),
                                                                          '404',
                                                                        ),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'servicoid':
                                                                          serializeParam(
                                                                        functions
                                                                            .intToSring(getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_id''',
                                                                        )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'data':
                                                                          serializeParam(
                                                                        functions
                                                                            .strToData(valueOrDefault<String>(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_dthr_agendamento''',
                                                                          )?.toString(),
                                                                          '2099-01-01 00:00:00',
                                                                        )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'hora':
                                                                          serializeParam(
                                                                        functions
                                                                            .strToHORA(valueOrDefault<String>(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_dthr_agendamento''',
                                                                          )?.toString(),
                                                                          '2099-01-01 00:00:00',
                                                                        )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'jsonServico':
                                                                          serializeParam(
                                                                        trOsServicosItem,
                                                                        ParamType
                                                                            .JSON,
                                                                      ),
                                                                      'deslocamentoAtualFinalizado':
                                                                          serializeParam(
                                                                        FFAppState()
                                                                            .servicosFinalizadosComSucesso
                                                                            .contains(getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.oserv_id''',
                                                                            ).toString()),
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                      'polylinhaQueVemDoMenuInicial':
                                                                          serializeParam(
                                                                        null,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'fazid':
                                                                          serializeParam(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions.ligacaoEntreListas(
                                                                              getJsonField(
                                                                                trOsServicosItem,
                                                                                r'''$''',
                                                                                true,
                                                                              ),
                                                                              FFAppState().trOrdemServicos.toList(),
                                                                              'oserv_id_os',
                                                                              'os_id',
                                                                              'os_id_faz'),
                                                                          '404',
                                                                        ),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'autoAuditoria':
                                                                          serializeParam(
                                                                        functions
                                                                            .strToBool(getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_auto_auditoria ''',
                                                                        ).toString()),
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                      'autoAuditoriaQuantidadePontos':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_quantos_pontos ''',
                                                                        ),
                                                                        ParamType
                                                                            .int,
                                                                      ),
                                                                    }.withoutNulls,
                                                                    extra: <String,
                                                                        dynamic>{
                                                                      kTransitionInfoKey:
                                                                          TransitionInfo(
                                                                        hasTransition:
                                                                            true,
                                                                        transitionType:
                                                                            PageTransitionType.fade,
                                                                        duration:
                                                                            Duration(milliseconds: 0),
                                                                      ),
                                                                    },
                                                                  );

                                                                  if (_shouldSetState)
                                                                    setState(
                                                                        () {});
                                                                  return;
                                                                }

                                                                _model.polyline1 =
                                                                    await ApiRotasPolylinesCall
                                                                        .call(
                                                                  latitudeOrigem:
                                                                      functions.separadorLatDeLng(
                                                                          true,
                                                                          functions
                                                                              .latLngToStr(currentUserLocationValue)),
                                                                  longitudeOrigem:
                                                                      functions.separadorLatDeLng(
                                                                          false,
                                                                          functions
                                                                              .latLngToStr(currentUserLocationValue)),
                                                                  latitudeDestino: functions.separadorLatDeLng(
                                                                      true,
                                                                      functions.latLngToStr(functions.strToLatLng(
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_latitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              )),
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_longitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              ))))),
                                                                  longitudeDestonp: functions.separadorLatDeLng(
                                                                      false,
                                                                      functions.latLngToStr(functions.strToLatLng(
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_latitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              )),
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_longitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              ))))),
                                                                  key:
                                                                      'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                                                                );
                                                                _shouldSetState =
                                                                    true;
                                                                Navigator.pop(
                                                                    context);

                                                                context
                                                                    .pushNamed(
                                                                  'IniciarDeslocamentoTela',
                                                                  queryParameters:
                                                                      {
                                                                    'etapade':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trServicos.toList(),
                                                                          'serv_id',
                                                                          'serv_nome',
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_id_serv''',
                                                                          ).toString()),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'fazendaNome':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trFazendas.toList(),
                                                                          'faz_id',
                                                                          'faz_nome',
                                                                          valueOrDefault<String>(
                                                                            functions.ligacaoEntreListas(
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                FFAppState().trOrdemServicos.toList(),
                                                                                'oserv_id_os',
                                                                                'os_id',
                                                                                'os_id_faz'),
                                                                            '404',
                                                                          )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'latlngFaz':
                                                                        serializeParam(
                                                                      functions.strToLatLng(
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_latitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              )),
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_longitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              ))),
                                                                      ParamType
                                                                          .LatLng,
                                                                    ),
                                                                    'cidadeFaz':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trFazendas.toList(),
                                                                          'faz_id',
                                                                          'faz_cidade',
                                                                          valueOrDefault<String>(
                                                                            functions.ligacaoEntreListas(
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                FFAppState().trOrdemServicos.toList(),
                                                                                'oserv_id_os',
                                                                                'os_id',
                                                                                'os_id_faz'),
                                                                            '404',
                                                                          )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'estadoFaz':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trFazendas.toList(),
                                                                          'faz_id',
                                                                          'faz_estado',
                                                                          valueOrDefault<String>(
                                                                            functions.ligacaoEntreListas(
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                FFAppState().trOrdemServicos.toList(),
                                                                                'oserv_id_os',
                                                                                'os_id',
                                                                                'os_id_faz'),
                                                                            '404',
                                                                          )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'observacao':
                                                                        serializeParam(
                                                                      getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_observacao''',
                                                                      ).toString(),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'tecnicoid':
                                                                        serializeParam(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions.ligacaoEntreListas(
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$''',
                                                                              true,
                                                                            ),
                                                                            FFAppState().trOsTecnicos.toList(),
                                                                            'oserv_id',
                                                                            'ostec_id_serv',
                                                                            'ostec_id_tec'),
                                                                        '404',
                                                                      ),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'servicoid':
                                                                        serializeParam(
                                                                      functions
                                                                          .intToSring(
                                                                              getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_id''',
                                                                      )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'data':
                                                                        serializeParam(
                                                                      functions.strToData(
                                                                          valueOrDefault<
                                                                              String>(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_dthr_agendamento''',
                                                                        )?.toString(),
                                                                        '2099-01-01 00:00:00',
                                                                      )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'hora':
                                                                        serializeParam(
                                                                      functions.strToHORA(
                                                                          valueOrDefault<
                                                                              String>(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_dthr_agendamento''',
                                                                        )?.toString(),
                                                                        '2099-01-01 00:00:00',
                                                                      )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'jsonServico':
                                                                        serializeParam(
                                                                      trOsServicosItem,
                                                                      ParamType
                                                                          .JSON,
                                                                    ),
                                                                    'deslocamentoAtualFinalizado':
                                                                        serializeParam(
                                                                      FFAppState()
                                                                          .servicosFinalizadosComSucesso
                                                                          .contains(
                                                                              getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_id''',
                                                                          ).toString()),
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                    'polylinhaQueVemDoMenuInicial':
                                                                        serializeParam(
                                                                      ApiRotasPolylinesCall
                                                                          .criptografadapolyline(
                                                                        (_model.polyline1?.jsonBody ??
                                                                            ''),
                                                                      ),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'fazid':
                                                                        serializeParam(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions.ligacaoEntreListas(
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$''',
                                                                              true,
                                                                            ),
                                                                            FFAppState().trOrdemServicos.toList(),
                                                                            'oserv_id_os',
                                                                            'os_id',
                                                                            'os_id_faz'),
                                                                        '404',
                                                                      ),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'autoAuditoria':
                                                                        serializeParam(
                                                                      functions
                                                                          .strToBool(
                                                                              getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_auto_auditoria ''',
                                                                      ).toString()),
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                    'autoAuditoriaQuantidadePontos':
                                                                        serializeParam(
                                                                      getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_quantos_pontos ''',
                                                                      ),
                                                                      ParamType
                                                                          .int,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    kTransitionInfoKey:
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              0),
                                                                    ),
                                                                  },
                                                                );
                                                              }
                                                              if (_shouldSetState)
                                                                setState(() {});
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        if (functions.ligaoDeNome(
                                                                                FFAppState().trServicos.toList(),
                                                                                'serv_id',
                                                                                'serv_nome',
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$.oserv_id_serv''',
                                                                                ).toString()) ==
                                                                            'Coleta')
                                                                          FaIcon(
                                                                            FontAwesomeIcons.vials,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        if (() {
                                                                          if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Contorno') {
                                                                            return true;
                                                                          } else if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Atualização de contorno') {
                                                                            return false;
                                                                          } else {
                                                                            return false;
                                                                          }
                                                                        }())
                                                                          FaIcon(
                                                                            FontAwesomeIcons.motorcycle,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        if (() {
                                                                          if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Contorno') {
                                                                            return false;
                                                                          } else if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Atualização de contorno') {
                                                                            return true;
                                                                          } else {
                                                                            return false;
                                                                          }
                                                                        }())
                                                                          FaIcon(
                                                                            FontAwesomeIcons.route,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 7,
                                                                  child:
                                                                      ClipRRect(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '#${getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.oserv_id_os''',
                                                                            ).toString()}',
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  fontSize: 12.0,
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            'Fazenda: ${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_nome', valueOrDefault<String>(
                                                                                      functions.ligacaoEntreListas(
                                                                                          getJsonField(
                                                                                            trOsServicosItem,
                                                                                            r'''$''',
                                                                                            true,
                                                                                          ),
                                                                                          FFAppState().trOrdemServicos.toList(),
                                                                                          'oserv_id_os',
                                                                                          'os_id',
                                                                                          'os_id_faz'),
                                                                                      '404',
                                                                                    ))}'
                                                                                .maybeHandleOverflow(
                                                                              maxChars: 20,
                                                                              replacement: '…',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            '${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_cidade', valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                ))}, ${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_estado', valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                ))}',
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  fontSize: 12.0,
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (!FFAppState()
                                                                    .servicosFinalizadosComSucesso
                                                                    .contains(
                                                                        getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id''',
                                                                    ).toString()))
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward,
                                                                        color:
                                                                            () {
                                                                          if ((getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id''',
                                                                                  ) ==
                                                                                  FFAppState().trOsServicoEmAndamento) &&
                                                                              (FFAppState().trDesloacamentoIniciado == true) &&
                                                                              (FFAppState().DeslocamentoPausado == false)) {
                                                                            return FlutterFlowTheme.of(context).secondary;
                                                                          } else if ((getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id''',
                                                                                  ) ==
                                                                                  FFAppState().trOsServicoEmAndamento) &&
                                                                              (FFAppState().DeslocamentoPausado == true)) {
                                                                            return FlutterFlowTheme.of(context).error;
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).lineColor;
                                                                          }
                                                                        }(),
                                                                        size:
                                                                            34.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (FFAppState()
                                                                    .servicosFinalizadosComSucesso
                                                                    .contains(
                                                                        getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id''',
                                                                    ).toString()))
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .task_alt,
                                                                        color: Color(
                                                                            0xFF249677),
                                                                        size:
                                                                            34.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (_model.searchBarController.text != null &&
                                  _model.searchBarController.text != '')
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(),
                                    child: Visibility(
                                      visible: _model
                                                  .searchBarController.text !=
                                              null &&
                                          _model.searchBarController.text != '',
                                      child: Builder(
                                        builder: (context) {
                                          final trOsServicos = (FFAppState()
                                                              .qualSwitchEstaAtivo ==
                                                          5
                                                      ? functions
                                                          .retornaListaPelaData(
                                                              _model
                                                                  .calendarRange
                                                                  ?.first,
                                                              _model
                                                                  .calendarRange
                                                                  ?.last,
                                                              'oserv_dthr_agendamento',
                                                              FFAppState()
                                                                  .trOsServicos
                                                                  .toList())
                                                      : functions.sortListJson(
                                                          FFAppState()
                                                              .JsonPathPesquisaAvancada,
                                                          true,
                                                          FFAppState()
                                                              .trOsServicos
                                                              .toList(), () {
                                                          if ((FFAppState()
                                                                      .JsonPathPesquisaAvancada ==
                                                                  'oserv_id_os') &&
                                                              (FFAppState()
                                                                      .qualSwitchEstaAtivo ==
                                                                  4)) {
                                                            return _model
                                                                .searchBarController
                                                                .text;
                                                          } else if (FFAppState()
                                                                  .qualSwitchEstaAtivo ==
                                                              2) {
                                                            return functions.retornaLigacaoFaz(
                                                                FFAppState()
                                                                    .trFazendas
                                                                    .toList(),
                                                                FFAppState()
                                                                    .trOrdemServicos
                                                                    .toList(),
                                                                _model
                                                                    .searchBarController
                                                                    .text);
                                                          } else if (FFAppState()
                                                                  .qualSwitchEstaAtivo ==
                                                              3) {
                                                            return functions
                                                                .retornaIdPeloNome(
                                                                    'serv_nome',
                                                                    'serv_id',
                                                                    _model
                                                                        .searchBarController
                                                                        .text,
                                                                    FFAppState()
                                                                        .trServicos
                                                                        .toList());
                                                          } else {
                                                            return functions.retornaLigacaoEmp(
                                                                FFAppState()
                                                                    .trEmpresas
                                                                    .toList(),
                                                                FFAppState()
                                                                    .trOrdemServicos
                                                                    .toList(),
                                                                _model
                                                                    .searchBarController
                                                                    .text);
                                                          }
                                                        }()))
                                                  ?.toList() ??
                                              [];
                                          if (trOsServicos.isEmpty) {
                                            return Center(
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: VazioWidget(),
                                              ),
                                            );
                                          }
                                          return RefreshIndicator(
                                            onRefresh: () async {
                                              context.goNamed(
                                                'blankRedirecona',
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 0),
                                                  ),
                                                },
                                              );

                                              setState(() {
                                                _model.foiAtualizado = true;
                                              });
                                            },
                                            child: SingleChildScrollView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    trOsServicos.length,
                                                    (trOsServicosIndex) {
                                                  final trOsServicosItem =
                                                      trOsServicos[
                                                          trOsServicosIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 8.0,
                                                                16.0, 0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Aguarde...',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    950),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                          ),
                                                        );
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: Duration(
                                                            milliseconds: 100),
                                                        curve: Curves.easeInOut,
                                                        width: double.infinity,
                                                        height: 78.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          border: Border.all(
                                                            color: trOsServicosItem ==
                                                                    FFAppState()
                                                                        .trOsServicoEmAndamento
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .customColor1
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .lineColor,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      12.0,
                                                                      8.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              currentUserLocationValue =
                                                                  await getCurrentUserLocation(
                                                                      defaultLocation:
                                                                          LatLng(
                                                                              0.0,
                                                                              0.0));
                                                              var _shouldSetState =
                                                                  false;
                                                              showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                useSafeArea:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => _model
                                                                            .unfocusNode
                                                                            .canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model
                                                                            .unfocusNode)
                                                                        : FocusScope.of(context)
                                                                            .unfocus(),
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          CarregandoOsWidget(),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              if (true ==
                                                                  false) {
                                                                _model.temInternetOsInicia =
                                                                    await actions
                                                                        .temInternet();
                                                                _shouldSetState =
                                                                    true;
                                                                if (!_model
                                                                    .temInternetOsInicia!) {
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'Ops!'),
                                                                        content:
                                                                            Text('Você não tem internet, você poderá usar o serviço de localização, entretanto, nenhuma rota será sugerida no momento.'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                            child:
                                                                                Text('Ok'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );

                                                                  context
                                                                      .pushNamed(
                                                                    'IniciarDeslocamentoTela',
                                                                    queryParameters:
                                                                        {
                                                                      'etapade':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trServicos.toList(),
                                                                            'serv_id',
                                                                            'serv_nome',
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.oserv_id_serv''',
                                                                            ).toString()),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'fazendaNome':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trFazendas.toList(),
                                                                            'faz_id',
                                                                            'faz_nome',
                                                                            valueOrDefault<String>(
                                                                              functions.ligacaoEntreListas(
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  FFAppState().trOrdemServicos.toList(),
                                                                                  'oserv_id_os',
                                                                                  'os_id',
                                                                                  'os_id_faz'),
                                                                              '404',
                                                                            )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'latlngFaz':
                                                                          serializeParam(
                                                                        functions.strToLatLng(
                                                                            functions.ligaoDeNome(
                                                                                FFAppState().trFazendas.toList(),
                                                                                'faz_id',
                                                                                'faz_latitude',
                                                                                valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                )),
                                                                            functions.ligaoDeNome(
                                                                                FFAppState().trFazendas.toList(),
                                                                                'faz_id',
                                                                                'faz_longitude',
                                                                                valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                ))),
                                                                        ParamType
                                                                            .LatLng,
                                                                      ),
                                                                      'cidadeFaz':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trFazendas.toList(),
                                                                            'faz_id',
                                                                            'faz_cidade',
                                                                            valueOrDefault<String>(
                                                                              functions.ligacaoEntreListas(
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  FFAppState().trOrdemServicos.toList(),
                                                                                  'oserv_id_os',
                                                                                  'os_id',
                                                                                  'os_id_faz'),
                                                                              '404',
                                                                            )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'estadoFaz':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trFazendas.toList(),
                                                                            'faz_id',
                                                                            'faz_estado',
                                                                            valueOrDefault<String>(
                                                                              functions.ligacaoEntreListas(
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  FFAppState().trOrdemServicos.toList(),
                                                                                  'oserv_id_os',
                                                                                  'os_id',
                                                                                  'os_id_faz'),
                                                                              '404',
                                                                            )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'observacao':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_observacao''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'tecnicoid':
                                                                          serializeParam(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions.ligacaoEntreListas(
                                                                              getJsonField(
                                                                                trOsServicosItem,
                                                                                r'''$''',
                                                                                true,
                                                                              ),
                                                                              FFAppState().trOsTecnicos.toList(),
                                                                              'oserv_id',
                                                                              'ostec_id_serv',
                                                                              'ostec_id_tec'),
                                                                          '404',
                                                                        ),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'servicoid':
                                                                          serializeParam(
                                                                        functions
                                                                            .intToSring(getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_id''',
                                                                        )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'data':
                                                                          serializeParam(
                                                                        functions
                                                                            .strToData(valueOrDefault<String>(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_dthr_agendamento''',
                                                                          )?.toString(),
                                                                          '2099-01-01 00:00:00',
                                                                        )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'hora':
                                                                          serializeParam(
                                                                        functions
                                                                            .strToHORA(valueOrDefault<String>(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_dthr_agendamento''',
                                                                          )?.toString(),
                                                                          '2099-01-01 00:00:00',
                                                                        )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'jsonServico':
                                                                          serializeParam(
                                                                        trOsServicosItem,
                                                                        ParamType
                                                                            .JSON,
                                                                      ),
                                                                      'deslocamentoAtualFinalizado':
                                                                          serializeParam(
                                                                        FFAppState()
                                                                            .servicosFinalizadosComSucesso
                                                                            .contains(getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.oserv_id''',
                                                                            ).toString()),
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                      'polylinhaQueVemDoMenuInicial':
                                                                          serializeParam(
                                                                        null,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'fazid':
                                                                          serializeParam(
                                                                        functions.ligaoDeNome(
                                                                            FFAppState().trFazendas.toList(),
                                                                            'faz_id',
                                                                            'faz_id',
                                                                            valueOrDefault<String>(
                                                                              functions.ligacaoEntreListas(
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$''',
                                                                                    true,
                                                                                  ),
                                                                                  FFAppState().trOrdemServicos.toList(),
                                                                                  'oserv_id_os',
                                                                                  'os_id',
                                                                                  'os_id_faz'),
                                                                              '404',
                                                                            )),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'autoAuditoria':
                                                                          serializeParam(
                                                                        functions
                                                                            .strToBool(getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_auto_auditoria''',
                                                                        ).toString()),
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                      'autoAuditoriaQuantidadePontos':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_quantos_pontos''',
                                                                        ),
                                                                        ParamType
                                                                            .int,
                                                                      ),
                                                                    }.withoutNulls,
                                                                    extra: <String,
                                                                        dynamic>{
                                                                      kTransitionInfoKey:
                                                                          TransitionInfo(
                                                                        hasTransition:
                                                                            true,
                                                                        transitionType:
                                                                            PageTransitionType.fade,
                                                                        duration:
                                                                            Duration(milliseconds: 0),
                                                                      ),
                                                                    },
                                                                  );

                                                                  if (_shouldSetState)
                                                                    setState(
                                                                        () {});
                                                                  return;
                                                                }
                                                                _model.polyline2 =
                                                                    await ApiRotasPolylinesCall
                                                                        .call(
                                                                  latitudeOrigem:
                                                                      functions.separadorLatDeLng(
                                                                          true,
                                                                          functions
                                                                              .latLngToStr(currentUserLocationValue)),
                                                                  longitudeOrigem:
                                                                      functions.separadorLatDeLng(
                                                                          false,
                                                                          functions
                                                                              .latLngToStr(currentUserLocationValue)),
                                                                  latitudeDestino: functions.separadorLatDeLng(
                                                                      true,
                                                                      functions.latLngToStr(functions.strToLatLng(
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_latitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              )),
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_longitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              ))))),
                                                                  longitudeDestonp: functions.separadorLatDeLng(
                                                                      false,
                                                                      functions.latLngToStr(functions.strToLatLng(
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_latitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              )),
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_longitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              ))))),
                                                                  key:
                                                                      'AIzaSyDpk1wIZmA1OTS57D_cB13BD01zqrTiQNI',
                                                                );
                                                                _shouldSetState =
                                                                    true;

                                                                context
                                                                    .pushNamed(
                                                                  'IniciarDeslocamentoTela',
                                                                  queryParameters:
                                                                      {
                                                                    'etapade':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trServicos.toList(),
                                                                          'serv_id',
                                                                          'serv_nome',
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_id_serv''',
                                                                          ).toString()),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'fazendaNome':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trFazendas.toList(),
                                                                          'faz_id',
                                                                          'faz_nome',
                                                                          valueOrDefault<String>(
                                                                            functions.ligacaoEntreListas(
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                FFAppState().trOrdemServicos.toList(),
                                                                                'oserv_id_os',
                                                                                'os_id',
                                                                                'os_id_faz'),
                                                                            '404',
                                                                          )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'latlngFaz':
                                                                        serializeParam(
                                                                      functions.strToLatLng(
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_latitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              )),
                                                                          functions.ligaoDeNome(
                                                                              FFAppState().trFazendas.toList(),
                                                                              'faz_id',
                                                                              'faz_longitude',
                                                                              valueOrDefault<String>(
                                                                                functions.ligacaoEntreListas(
                                                                                    getJsonField(
                                                                                      trOsServicosItem,
                                                                                      r'''$''',
                                                                                      true,
                                                                                    ),
                                                                                    FFAppState().trOrdemServicos.toList(),
                                                                                    'oserv_id_os',
                                                                                    'os_id',
                                                                                    'os_id_faz'),
                                                                                '404',
                                                                              ))),
                                                                      ParamType
                                                                          .LatLng,
                                                                    ),
                                                                    'cidadeFaz':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trFazendas.toList(),
                                                                          'faz_id',
                                                                          'faz_cidade',
                                                                          valueOrDefault<String>(
                                                                            functions.ligacaoEntreListas(
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                FFAppState().trOrdemServicos.toList(),
                                                                                'oserv_id_os',
                                                                                'os_id',
                                                                                'os_id_faz'),
                                                                            '404',
                                                                          )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'estadoFaz':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trFazendas.toList(),
                                                                          'faz_id',
                                                                          'faz_estado',
                                                                          valueOrDefault<String>(
                                                                            functions.ligacaoEntreListas(
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                FFAppState().trOrdemServicos.toList(),
                                                                                'oserv_id_os',
                                                                                'os_id',
                                                                                'os_id_faz'),
                                                                            '404',
                                                                          )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'observacao':
                                                                        serializeParam(
                                                                      getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_observacao''',
                                                                      ).toString(),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'tecnicoid':
                                                                        serializeParam(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions.ligacaoEntreListas(
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$''',
                                                                              true,
                                                                            ),
                                                                            FFAppState().trOsTecnicos.toList(),
                                                                            'oserv_id',
                                                                            'ostec_id_serv',
                                                                            'ostec_id_tec'),
                                                                        '404',
                                                                      ),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'servicoid':
                                                                        serializeParam(
                                                                      functions
                                                                          .intToSring(
                                                                              getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_id''',
                                                                      )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'data':
                                                                        serializeParam(
                                                                      functions.strToData(
                                                                          valueOrDefault<
                                                                              String>(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_dthr_agendamento''',
                                                                        )?.toString(),
                                                                        '2099-01-01 00:00:00',
                                                                      )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'hora':
                                                                        serializeParam(
                                                                      functions.strToHORA(
                                                                          valueOrDefault<
                                                                              String>(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_dthr_agendamento''',
                                                                        )?.toString(),
                                                                        '2099-01-01 00:00:00',
                                                                      )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'jsonServico':
                                                                        serializeParam(
                                                                      trOsServicosItem,
                                                                      ParamType
                                                                          .JSON,
                                                                    ),
                                                                    'deslocamentoAtualFinalizado':
                                                                        serializeParam(
                                                                      FFAppState()
                                                                          .servicosFinalizadosComSucesso
                                                                          .contains(
                                                                              getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_id''',
                                                                          ).toString()),
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                    'polylinhaQueVemDoMenuInicial':
                                                                        serializeParam(
                                                                      ApiRotasPolylinesCall
                                                                          .criptografadapolyline(
                                                                        (_model.polyline2?.jsonBody ??
                                                                            ''),
                                                                      ),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'fazid':
                                                                        serializeParam(
                                                                      functions.ligaoDeNome(
                                                                          FFAppState().trFazendas.toList(),
                                                                          'faz_id',
                                                                          'faz_id',
                                                                          valueOrDefault<String>(
                                                                            functions.ligacaoEntreListas(
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$''',
                                                                                  true,
                                                                                ),
                                                                                FFAppState().trOrdemServicos.toList(),
                                                                                'oserv_id_os',
                                                                                'os_id',
                                                                                'os_id_faz'),
                                                                            '404',
                                                                          )),
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'autoAuditoria':
                                                                        serializeParam(
                                                                      functions
                                                                          .strToBool(
                                                                              getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_auto_auditoria''',
                                                                      ).toString()),
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                    'autoAuditoriaQuantidadePontos':
                                                                        serializeParam(
                                                                      getJsonField(
                                                                        trOsServicosItem,
                                                                        r'''$.oserv_quantos_pontos''',
                                                                      ),
                                                                      ParamType
                                                                          .int,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    kTransitionInfoKey:
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              0),
                                                                    ),
                                                                  },
                                                                );

                                                                if (_shouldSetState)
                                                                  setState(
                                                                      () {});
                                                                return;
                                                              } else {
                                                                if (_shouldSetState)
                                                                  setState(
                                                                      () {});
                                                                return;
                                                              }

                                                              if (_shouldSetState)
                                                                setState(() {});
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        if (functions.ligaoDeNome(
                                                                                FFAppState().trServicos.toList(),
                                                                                'serv_id',
                                                                                'serv_nome',
                                                                                getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$.oserv_id_serv''',
                                                                                ).toString()) ==
                                                                            'Coleta')
                                                                          FaIcon(
                                                                            FontAwesomeIcons.vials,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        if (() {
                                                                          if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Contorno') {
                                                                            return true;
                                                                          } else if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Atualização de contorno') {
                                                                            return false;
                                                                          } else {
                                                                            return false;
                                                                          }
                                                                        }())
                                                                          FaIcon(
                                                                            FontAwesomeIcons.motorcycle,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        if (() {
                                                                          if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Contorno') {
                                                                            return false;
                                                                          } else if (functions.ligaoDeNome(
                                                                                  FFAppState().trServicos.toList(),
                                                                                  'serv_id',
                                                                                  'serv_nome',
                                                                                  getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id_serv''',
                                                                                  ).toString()) ==
                                                                              'Atualização de contorno') {
                                                                            return true;
                                                                          } else {
                                                                            return false;
                                                                          }
                                                                        }())
                                                                          FaIcon(
                                                                            FontAwesomeIcons.route,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 7,
                                                                  child:
                                                                      ClipRRect(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '#${getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.oserv_id_os''',
                                                                            ).toString()}',
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  fontSize: 12.0,
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            'Fazenda: ${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_nome', valueOrDefault<String>(
                                                                                      functions.ligacaoEntreListas(
                                                                                          getJsonField(
                                                                                            trOsServicosItem,
                                                                                            r'''$''',
                                                                                            true,
                                                                                          ),
                                                                                          FFAppState().trOrdemServicos.toList(),
                                                                                          'oserv_id_os',
                                                                                          'os_id',
                                                                                          'os_id_faz'),
                                                                                      '404',
                                                                                    ))}'
                                                                                .maybeHandleOverflow(
                                                                              maxChars: 20,
                                                                              replacement: '…',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            '${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_cidade', valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                ))}, ${functions.ligaoDeNome(FFAppState().trFazendas.toList(), 'faz_id', 'faz_estado', valueOrDefault<String>(
                                                                                  functions.ligacaoEntreListas(
                                                                                      getJsonField(
                                                                                        trOsServicosItem,
                                                                                        r'''$''',
                                                                                        true,
                                                                                      ),
                                                                                      FFAppState().trOrdemServicos.toList(),
                                                                                      'oserv_id_os',
                                                                                      'os_id',
                                                                                      'os_id_faz'),
                                                                                  '404',
                                                                                ))}',
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  fontFamily: 'Readex Pro',
                                                                                  fontSize: 12.0,
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (!FFAppState()
                                                                    .servicosFinalizadosComSucesso
                                                                    .contains(
                                                                        getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id''',
                                                                    ).toString()))
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward,
                                                                        color:
                                                                            () {
                                                                          if ((getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id''',
                                                                                  ) ==
                                                                                  FFAppState().trOsServicoEmAndamento) &&
                                                                              (FFAppState().trDesloacamentoIniciado == true) &&
                                                                              (FFAppState().DeslocamentoPausado == false)) {
                                                                            return FlutterFlowTheme.of(context).secondary;
                                                                          } else if ((getJsonField(
                                                                                    trOsServicosItem,
                                                                                    r'''$.oserv_id''',
                                                                                  ) ==
                                                                                  FFAppState().trOsServicoEmAndamento) &&
                                                                              (FFAppState().DeslocamentoPausado == true)) {
                                                                            return FlutterFlowTheme.of(context).error;
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).lineColor;
                                                                          }
                                                                        }(),
                                                                        size:
                                                                            34.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (FFAppState()
                                                                    .servicosFinalizadosComSucesso
                                                                    .contains(
                                                                        getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.oserv_id''',
                                                                    ).toString()))
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .task_alt,
                                                                        color: Color(
                                                                            0xFF249677),
                                                                        size:
                                                                            34.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ).animateOnPageLoad(
                              animationsMap['columnOnPageLoadAnimation']!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
