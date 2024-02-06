import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Sincronizar Group Code

class SincronizarGroup {
  static String baseUrl = 'http';
  static Map<String, String> headers = {};
  static OrdemDeServicoCall ordemDeServicoCall = OrdemDeServicoCall();
  static TrOsTecnicoCall trOsTecnicoCall = TrOsTecnicoCall();
  static TrFazendasCall trFazendasCall = TrFazendasCall();
  static TrServicosCall trServicosCall = TrServicosCall();
  static TrOsServicosCall trOsServicosCall = TrOsServicosCall();
  static TrTecnicosCall trTecnicosCall = TrTecnicosCall();
  static TrSincronizaCelularComBDCall trSincronizaCelularComBDCall =
      TrSincronizaCelularComBDCall();
  static TrEmpresasCall trEmpresasCall = TrEmpresasCall();
  static TrCFGCall trCFGCall = TrCFGCall();
  static TrSincronizaTalhaoContornoCall trSincronizaTalhaoContornoCall =
      TrSincronizaTalhaoContornoCall();
  static TrSincronizaPontosMedicaoCall trSincronizaPontosMedicaoCall =
      TrSincronizaPontosMedicaoCall();
}

class OrdemDeServicoCall {
  Future<ApiCallResponse> call({
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_os"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ordemDeServico',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? ordemServicoOsUsuAlt(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_usu_alt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? ordemServicoOsdthrAlt(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_dthr_alt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? ordemServicoOsUsuCad(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_usu_cad''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? ordemServicoOsDthrCad(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_dthr_cad''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? ordemServicoOsStatus(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? ordemServicoOsObservacao(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_observacao''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? ordemServicoOsDthrFinalizao(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].os_dthr_finalizacao''',
        true,
      ) as List?;
  List<String>? ordemServicoOsDthrAgendamento(dynamic response) =>
      (getJsonField(
        response,
        r'''$.dados[:].os_dthr_agendamento''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? ordemServicoOsIDFaz(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_id_faz''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? ordemServicoOsIDEmp(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_id_emp''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? ordemServicoOsID(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].os_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? ordemServicoDados(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  bool? ordemServicoStatus(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  dynamic itensNumOrdemServico(dynamic response) => getJsonField(
        response,
        r'''$.itens''',
      );
}

class TrOsTecnicoCall {
  Future<ApiCallResponse> call({
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_tr_os_tecnicos"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trOsTecnico',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? ostecusualtTrOsTecnico(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].ostec_usu_alt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? ostecdthraltTrOsTecnico(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].ostec_dthr_alt''',
        true,
      ) as List?;
  List<String>? ostecusucadTrOsTecnico(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].ostec_usu_cad''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? ostecdthrcadTrOsTecnico(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].ostec_dthr_cad''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? ostecidtecTrOsTecnico(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].ostec_id_tec''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? ostecidservTrOsTecnico(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].ostec_id_serv''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? ostecidTrOsTecnico(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].ostec_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? dadosTrOsTecnico(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  bool? statusTrOsTecnico(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  dynamic itensTrOsTecnico(dynamic response) => getJsonField(
        response,
        r'''$.itens''',
      );
}

class TrFazendasCall {
  Future<ApiCallResponse> call({
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
"tipo": "apk_sinc_tr_fazendas"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trFazendas',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? fazusualtTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_usu_alt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazdthraltTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_dthr_alt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazusucadTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_usu_cad''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazdthrcadTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_dthr_cad''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazstatusTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazestadoTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_estado''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazpontorefTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_ponto_ref''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazcidadeTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_cidade''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazlongitudeTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fazlatitudeTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_latitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? faznomeTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_nome''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? fazidempTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_id_emp''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? fazidTrFazendas(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].faz_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? dadosTrFazendas(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  bool? statusTrFazendas(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  dynamic itensTrFazenda(dynamic response) => getJsonField(
        response,
        r'''$.itens''',
      );
}

class TrServicosCall {
  Future<ApiCallResponse> call({
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_tr_servicos"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trServicos',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? servusualtTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].serv_usu_alt''',
        true,
      ) as List?;
  List? servdthraltTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].serv_dthr_alt''',
        true,
      ) as List?;
  List? servusucadTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].serv_usu_cad''',
        true,
      ) as List?;
  List? servdthrcadTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].serv_dthr_cad''',
        true,
      ) as List?;
  List? servnomeTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].serv_nome''',
        true,
      ) as List?;
  List? servidtpTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].serv_id_tp''',
        true,
      ) as List?;
  List? servidTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].serv_id''',
        true,
      ) as List?;
  List? dadosTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  dynamic statusTrServicos(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
}

class TrOsServicosCall {
  Future<ApiCallResponse> call({
    String? tecId = '',
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_tr_os_servicos",
  "id_tec": "${tecId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trOsServicos',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? oservusualtTrOsServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].oserv_usu_alt''',
        true,
      ) as List?;
  List? oservdthraltTrOsServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].oserv_dthr_alt''',
        true,
      ) as List?;
  List? oservusucadTrOsServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].oserv_usu_cad''',
        true,
      ) as List?;
  List? oservdthrcadTrOsServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].oserv_dthr_cad''',
        true,
      ) as List?;
  List<String>? oservstatusTrOsServicos(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].oserv_status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? oservobservacaoTrOsServicos(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].oserv_observacao''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? oservdthrexecucaoTrOsServicos(dynamic response) =>
      (getJsonField(
        response,
        r'''$.dados[:].oserv_dthr_execucao''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? oservgeoTrOsServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].oserv_geo''',
        true,
      ) as List?;
  List<int>? oservidservTrOsServicos(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].oserv_id_serv''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<int>? oservidTrOsServicos(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].oserv_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? dadosTrOsServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  bool? statusTrOsServicos(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List<int>? oservidosTrOsServicos(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].oserv_id_os''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? oservdthragendamentoTrOsServicos(dynamic response) =>
      (getJsonField(
        response,
        r'''$.dados[:].oserv_dthr_agendamento''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? oservQuantosPontos(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].oserv_quantos_pontos''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<bool>? oservAutoAuditoria(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].oserv_auto_auditoria''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
}

class TrTecnicosCall {
  Future<ApiCallResponse> call({
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_tr_tecnicos"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trTecnicos',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? tecusualtTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].tec_usu_alt''',
        true,
      ) as List?;
  List? tecdthraltTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].tec_dthr_alt''',
        true,
      ) as List?;
  List? tecusucadTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].tec_usu_cad''',
        true,
      ) as List?;
  List? tecdthrcadTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].tec_dthr_cad''',
        true,
      ) as List?;
  List? tecnomeTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].tec_nome''',
        true,
      ) as List?;
  List? tecidunidTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].tec_id_unid''',
        true,
      ) as List?;
  List? tecidTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].tec_id''',
        true,
      ) as List?;
  List? dadosTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  dynamic statusTrTecnicos(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
}

class TrSincronizaCelularComBDCall {
  Future<ApiCallResponse> call({
    String? lista = '',
    String? listaGeo = '',
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_do_celular",
  "insert": "${lista}",
  "insert_geo": "${listaGeo}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'TrSincronizaCelularComBD',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? retornoSincComCelular(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  bool? statusSincComCelular(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class TrEmpresasCall {
  Future<ApiCallResponse> call({
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_tr_empresas"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trEmpresas',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? dadosTrEmpresas(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  bool? statusTrEmpresas(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class TrCFGCall {
  Future<ApiCallResponse> call({
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_cfg"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trCFG',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  dynamic statusCFG(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
  dynamic dadosCFG(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
      );
  dynamic geoTolerancia(dynamic response) => getJsonField(
        response,
        r'''$.geo_tolerancia''',
      );
}

class TrSincronizaTalhaoContornoCall {
  Future<ApiCallResponse> call({
    String? talhao = '',
    String? contorno = '',
    String? recorte = '',
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_talhao_contornos",
  "talhao": "${talhao}",
  "contorno": "${contorno}",
"recorte":"${recorte}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trSincronizaTalhaoContorno',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? dadosGrupoContornoSincDoWeb(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  List? dadosContornosSincDaWeb(dynamic response) => getJsonField(
        response,
        r'''$.dados_cont_e_rec''',
        true,
      ) as List?;
  List? dadosRecortes(dynamic response) => getJsonField(
        response,
        r'''$.recortes''',
        true,
      ) as List?;
}

class TrSincronizaPontosMedicaoCall {
  Future<ApiCallResponse> call({
    String? pontosColetados = '',
    String? urlapicall = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_pontos_medicao",
  "pontosColetados": "${pontosColetados}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trSincronizaPontosMedicao',
      apiUrl: '${SincronizarGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Sincronizar Group Code

/// Start ModuloSegura Group Code

class ModuloSeguraGroup {
  static String baseUrl = 'http';
  static Map<String, String> headers = {};
  static LoginsCall loginsCall = LoginsCall();
  static EsqueceuSenhaCall esqueceuSenhaCall = EsqueceuSenhaCall();
}

class LoginsCall {
  Future<ApiCallResponse> call({
    String? login = '',
    String? senha = '',
    String? urlapicall = '',
    String? protocolo = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_login",
  "login": "${login}",
  "senha": "${senha}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Logins',
      apiUrl: '${ModuloSeguraGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? messageLogin(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  bool? statusLogin(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  String? nomeLogin(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.nome''',
      ));
  int? idLogin(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class EsqueceuSenhaCall {
  Future<ApiCallResponse> call({
    String? login = '',
    String? urlapicall = '',
    String? protocolo = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_esqueci_senha",
  "login": "${login}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'EsqueceuSenha',
      apiUrl: '${ModuloSeguraGroup.baseUrl}${urlapicall}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  dynamic statusEsqueceuSenha(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
  dynamic messageEsqueceuSenha(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

/// End ModuloSegura Group Code

class ApiRotasDirectionsCall {
  static Future<ApiCallResponse> call({
    String? destino = '',
    String? origem = '',
    String? key = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ApiRotasDirections',
      apiUrl:
          'https://maps.googleapis.com/maps/api/directions/json?origin=${origem}&destination=${destino}&key=${key}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic? tudo(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class ApiRotasPolylinesCall {
  static Future<ApiCallResponse> call({
    String? key = '',
    String? latitudeOrigem = '',
    String? longitudeOrigem = '',
    String? latitudeDestino = '',
    String? longitudeDestonp = '',
  }) async {
    final ffApiRequestBody = '''
{
  "origin": {
    "location": {
      "latLng": {
        "latitude": "${latitudeOrigem}",
        "longitude": "${longitudeOrigem}"
      }
    }
  },
  "destination": {
    "location": {
      "latLng": {
        "latitude": "${latitudeDestino}",
        "longitude": "${longitudeDestonp}"
      }
    }
  },
  "travelMode": "DRIVE",
  "routingPreference": "TRAFFIC_AWARE",
  "polylineQuality": "OVERVIEW",
  "departureTime": "2024-12-27T12:00:00Z",
  "computeAlternativeRoutes": true,
  "routeModifiers": {
    "avoidTolls": false,
    "avoidHighways": false
  },
  "languageCode": "en-US",
  "regionCode": "US",
  "units": "METRIC"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'apiRotasPolylines',
      apiUrl:
          'https://routes.googleapis.com/directions/v2:computeRoutes?key=${key}',
      callType: ApiCallType.POST,
      headers: {
        'X-Goog-FieldMask':
            'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? criptografadapolyline(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.routes[0].polyline.encodedPolyline''',
      ));
}

class HttpsdemoconceittosistemascombrterramwsflutterflowindexphpCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "tipo": "apk_sinc_tr_os_servicos",
  "id_tec": "10"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'httpsdemoconceittosistemascombrterramwsflutterflowindexphp',
      apiUrl:
          'https://demo.conceittosistemas.com.br/terram/ws_flutterflow/index.php',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
