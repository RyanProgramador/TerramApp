import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _urlapicall = prefs.getString('ff_urlapicall') ?? _urlapicall;
    });
    _safeInit(() {
      _protocolo = prefs.getString('ff_protocolo') ?? _protocolo;
    });
    _safeInit(() {
      _tecID = prefs.getString('ff_tecID') ?? _tecID;
    });
    _safeInit(() {
      _tecNome = prefs.getString('ff_tecNome') ?? _tecNome;
    });
    _safeInit(() {
      _Erro =
          prefs.getStringList('ff_Erro')?.map(_latLngFromString).withoutNulls ??
              _Erro;
    });
    _safeInit(() {
      _locaisPercorridos2 = prefs
              .getStringList('ff_locaisPercorridos2')
              ?.map(_latLngFromString)
              .withoutNulls ??
          _locaisPercorridos2;
    });
    _safeInit(() {
      _trEmpresas = prefs.getStringList('ff_trEmpresas')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trEmpresas;
    });
    _safeInit(() {
      _trOrdemServicos = prefs.getStringList('ff_trOrdemServicos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trOrdemServicos;
    });
    _safeInit(() {
      _trFazendas = prefs.getStringList('ff_trFazendas')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trFazendas;
    });
    _safeInit(() {
      _trOsTecnicos = prefs.getStringList('ff_trOsTecnicos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trOsTecnicos;
    });
    _safeInit(() {
      _trOsServicos = prefs.getStringList('ff_trOsServicos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trOsServicos;
    });
    _safeInit(() {
      _trServicos = prefs.getStringList('ff_trServicos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trServicos;
    });
    _safeInit(() {
      _trTecnicos = prefs.getStringList('ff_trTecnicos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trTecnicos;
    });
    _safeInit(() {
      _trOsDeslocamentos =
          prefs.getStringList('ff_trOsDeslocamentos')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _trOsDeslocamentos;
    });
    _safeInit(() {
      _trDeslocamentoGeo =
          prefs.getStringList('ff_trDeslocamentoGeo')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _trDeslocamentoGeo;
    });
    _safeInit(() {
      _trDeslocGeo2 = prefs.getStringList('ff_trDeslocGeo2')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trDeslocGeo2;
    });
    _safeInit(() {
      _trDeslocamentoGeoDataType = prefs
              .getStringList('ff_trDeslocamentoGeoDataType')
              ?.map((x) {
                try {
                  return DeslocamentosGeoStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _trDeslocamentoGeoDataType;
    });
    _safeInit(() {
      _trOsDeslocamentoLatLng =
          prefs.getStringList('ff_trOsDeslocamentoLatLng')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _trOsDeslocamentoLatLng;
    });
    _safeInit(() {
      _trOsDeslocamentosJsonFinalizados =
          prefs.getStringList('ff_trOsDeslocamentosJsonFinalizados')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _trOsDeslocamentosJsonFinalizados;
    });
    _safeInit(() {
      _trOsDeslocamentoListaFinalizados =
          prefs.getStringList('ff_trOsDeslocamentoListaFinalizados') ??
              _trOsDeslocamentoListaFinalizados;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_teste')) {
        try {
          _teste = jsonDecode(prefs.getString('ff_teste') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_trOsServicoEmAndamento')) {
        try {
          _trOsServicoEmAndamento =
              jsonDecode(prefs.getString('ff_trOsServicoEmAndamento') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _MotivoPausaDeslocamento =
          prefs.getStringList('ff_MotivoPausaDeslocamento') ??
              _MotivoPausaDeslocamento;
    });
    _safeInit(() {
      _trDesloacamentoIniciado = prefs.getBool('ff_trDesloacamentoIniciado') ??
          _trDesloacamentoIniciado;
    });
    _safeInit(() {
      _DeslocamentoPausado =
          prefs.getBool('ff_DeslocamentoPausado') ?? _DeslocamentoPausado;
    });
    _safeInit(() {
      _trDeslocamentoFinalizado =
          prefs.getBool('ff_trDeslocamentoFinalizado') ??
              _trDeslocamentoFinalizado;
    });
    _safeInit(() {
      _strDeslocamentosJson =
          prefs.getString('ff_strDeslocamentosJson') ?? _strDeslocamentosJson;
    });
    _safeInit(() {
      _localizacaoZero =
          prefs.getString('ff_localizacaoZero') ?? _localizacaoZero;
    });
    _safeInit(() {
      _AtualLocalizcao =
          prefs.getString('ff_AtualLocalizcao') ?? _AtualLocalizcao;
    });
    _safeInit(() {
      _LocalAtual =
          _latLngFromString(prefs.getString('ff_LocalAtual')) ?? _LocalAtual;
    });
    _safeInit(() {
      _servicosFinalizadosComSucesso =
          prefs.getStringList('ff_servicosFinalizadosComSucesso') ??
              _servicosFinalizadosComSucesso;
    });
    _safeInit(() {
      _userLogin = prefs.getString('ff_userLogin') ?? _userLogin;
    });
    _safeInit(() {
      _psdwLogin = prefs.getString('ff_psdwLogin') ?? _psdwLogin;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_trOsDeslocamentoJsonAtual')) {
        try {
          _trOsDeslocamentoJsonAtual =
              jsonDecode(prefs.getString('ff_trOsDeslocamentoJsonAtual') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _Desenvolvimento =
          prefs.getBool('ff_Desenvolvimento') ?? _Desenvolvimento;
    });
    _safeInit(() {
      _sincronizcaoAutomatica =
          prefs.getBool('ff_sincronizcaoAutomatica') ?? _sincronizcaoAutomatica;
    });
    _safeInit(() {
      _JsonPathPesquisaAvancada =
          prefs.getString('ff_JsonPathPesquisaAvancada') ??
              _JsonPathPesquisaAvancada;
    });
    _safeInit(() {
      _qualSwitchEstaAtivo =
          prefs.getInt('ff_qualSwitchEstaAtivo') ?? _qualSwitchEstaAtivo;
    });
    _safeInit(() {
      _excluirLocal = _latLngFromString(prefs.getString('ff_excluirLocal')) ??
          _excluirLocal;
    });
    _safeInit(() {
      _tempoEmSegundosPadraoDeCapturaDeLocal =
          prefs.getInt('ff_tempoEmSegundosPadraoDeCapturaDeLocal') ??
              _tempoEmSegundosPadraoDeCapturaDeLocal;
    });
    _safeInit(() {
      _rotainversa = prefs.getStringList('ff_rotainversa')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _rotainversa;
    });
    _safeInit(() {
      _contornoFazenda = prefs.getStringList('ff_contornoFazenda')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _contornoFazenda;
    });
    _safeInit(() {
      _contornoFazendaPosSincronizado =
          prefs.getStringList('ff_contornoFazendaPosSincronizado')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _contornoFazendaPosSincronizado;
    });
    _safeInit(() {
      _grupoContornoFazendas =
          prefs.getStringList('ff_grupoContornoFazendas')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _grupoContornoFazendas;
    });
    _safeInit(() {
      _grupoContornoFazendasPosSincronizado = prefs
              .getStringList('ff_grupoContornoFazendasPosSincronizado')
              ?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _grupoContornoFazendasPosSincronizado;
    });
    _safeInit(() {
      _contornoGrupoID =
          prefs.getString('ff_contornoGrupoID') ?? _contornoGrupoID;
    });
    _safeInit(() {
      _PontosMovidos = prefs.getStringList('ff_PontosMovidos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _PontosMovidos;
    });
    _safeInit(() {
      _PontosColetados = prefs.getStringList('ff_PontosColetados')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _PontosColetados;
    });
    _safeInit(() {
      _PontosExcluidos = prefs.getStringList('ff_PontosExcluidos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _PontosExcluidos;
    });
    _safeInit(() {
      _distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra = prefs.getInt(
              'ff_distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra') ??
          _distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra;
    });
    _safeInit(() {
      _possiveisProfuncidadesDeColeta =
          prefs.getStringList('ff_possiveisProfuncidadesDeColeta') ??
              _possiveisProfuncidadesDeColeta;
    });
    _safeInit(() {
      _listaDeLocaisDeAreasParaColeta =
          prefs.getStringList('ff_listaDeLocaisDeAreasParaColeta') ??
              _listaDeLocaisDeAreasParaColeta;
    });
    _safeInit(() {
      _latLngListaMarcadoresArea =
          prefs.getStringList('ff_latLngListaMarcadoresArea') ??
              _latLngListaMarcadoresArea;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _urlapicall =
      's://dev.conceittosistemas.com.br/scriptcase/app/Terram/ws_flutterflow/index.php';
  String get urlapicall => _urlapicall;
  set urlapicall(String _value) {
    _urlapicall = _value;
    prefs.setString('ff_urlapicall', _value);
  }

  String _protocolo = 'https://';
  String get protocolo => _protocolo;
  set protocolo(String _value) {
    _protocolo = _value;
    prefs.setString('ff_protocolo', _value);
  }

  String _tecID = '';
  String get tecID => _tecID;
  set tecID(String _value) {
    _tecID = _value;
    prefs.setString('ff_tecID', _value);
  }

  String _tecNome = '';
  String get tecNome => _tecNome;
  set tecNome(String _value) {
    _tecNome = _value;
    prefs.setString('ff_tecNome', _value);
  }

  List<LatLng> _Erro = [
    LatLng(-29.8813641, -51.16721629999999),
    LatLng(-29.9151627, -51.1952651),
    LatLng(-29.9175426, -51.19687039999999)
  ];
  List<LatLng> get Erro => _Erro;
  set Erro(List<LatLng> _value) {
    _Erro = _value;
    prefs.setStringList('ff_Erro', _value.map((x) => x.serialize()).toList());
  }

  void addToErro(LatLng _value) {
    _Erro.add(_value);
    prefs.setStringList('ff_Erro', _Erro.map((x) => x.serialize()).toList());
  }

  void removeFromErro(LatLng _value) {
    _Erro.remove(_value);
    prefs.setStringList('ff_Erro', _Erro.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromErro(int _index) {
    _Erro.removeAt(_index);
    prefs.setStringList('ff_Erro', _Erro.map((x) => x.serialize()).toList());
  }

  void updateErroAtIndex(
    int _index,
    LatLng Function(LatLng) updateFn,
  ) {
    _Erro[_index] = updateFn(_Erro[_index]);
    prefs.setStringList('ff_Erro', _Erro.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInErro(int _index, LatLng _value) {
    _Erro.insert(_index, _value);
    prefs.setStringList('ff_Erro', _Erro.map((x) => x.serialize()).toList());
  }

  List<LatLng> _locaisPercorridos2 = [LatLng(-29.9077898, -51.1847036)];
  List<LatLng> get locaisPercorridos2 => _locaisPercorridos2;
  set locaisPercorridos2(List<LatLng> _value) {
    _locaisPercorridos2 = _value;
    prefs.setStringList(
        'ff_locaisPercorridos2', _value.map((x) => x.serialize()).toList());
  }

  void addToLocaisPercorridos2(LatLng _value) {
    _locaisPercorridos2.add(_value);
    prefs.setStringList('ff_locaisPercorridos2',
        _locaisPercorridos2.map((x) => x.serialize()).toList());
  }

  void removeFromLocaisPercorridos2(LatLng _value) {
    _locaisPercorridos2.remove(_value);
    prefs.setStringList('ff_locaisPercorridos2',
        _locaisPercorridos2.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromLocaisPercorridos2(int _index) {
    _locaisPercorridos2.removeAt(_index);
    prefs.setStringList('ff_locaisPercorridos2',
        _locaisPercorridos2.map((x) => x.serialize()).toList());
  }

  void updateLocaisPercorridos2AtIndex(
    int _index,
    LatLng Function(LatLng) updateFn,
  ) {
    _locaisPercorridos2[_index] = updateFn(_locaisPercorridos2[_index]);
    prefs.setStringList('ff_locaisPercorridos2',
        _locaisPercorridos2.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInLocaisPercorridos2(int _index, LatLng _value) {
    _locaisPercorridos2.insert(_index, _value);
    prefs.setStringList('ff_locaisPercorridos2',
        _locaisPercorridos2.map((x) => x.serialize()).toList());
  }

  List<dynamic> _trEmpresas = [];
  List<dynamic> get trEmpresas => _trEmpresas;
  set trEmpresas(List<dynamic> _value) {
    _trEmpresas = _value;
    prefs.setStringList(
        'ff_trEmpresas', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrEmpresas(dynamic _value) {
    _trEmpresas.add(_value);
    prefs.setStringList(
        'ff_trEmpresas', _trEmpresas.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrEmpresas(dynamic _value) {
    _trEmpresas.remove(_value);
    prefs.setStringList(
        'ff_trEmpresas', _trEmpresas.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrEmpresas(int _index) {
    _trEmpresas.removeAt(_index);
    prefs.setStringList(
        'ff_trEmpresas', _trEmpresas.map((x) => jsonEncode(x)).toList());
  }

  void updateTrEmpresasAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trEmpresas[_index] = updateFn(_trEmpresas[_index]);
    prefs.setStringList(
        'ff_trEmpresas', _trEmpresas.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrEmpresas(int _index, dynamic _value) {
    _trEmpresas.insert(_index, _value);
    prefs.setStringList(
        'ff_trEmpresas', _trEmpresas.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trOrdemServicos = [];
  List<dynamic> get trOrdemServicos => _trOrdemServicos;
  set trOrdemServicos(List<dynamic> _value) {
    _trOrdemServicos = _value;
    prefs.setStringList(
        'ff_trOrdemServicos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrOrdemServicos(dynamic _value) {
    _trOrdemServicos.add(_value);
    prefs.setStringList('ff_trOrdemServicos',
        _trOrdemServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrOrdemServicos(dynamic _value) {
    _trOrdemServicos.remove(_value);
    prefs.setStringList('ff_trOrdemServicos',
        _trOrdemServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrOrdemServicos(int _index) {
    _trOrdemServicos.removeAt(_index);
    prefs.setStringList('ff_trOrdemServicos',
        _trOrdemServicos.map((x) => jsonEncode(x)).toList());
  }

  void updateTrOrdemServicosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trOrdemServicos[_index] = updateFn(_trOrdemServicos[_index]);
    prefs.setStringList('ff_trOrdemServicos',
        _trOrdemServicos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrOrdemServicos(int _index, dynamic _value) {
    _trOrdemServicos.insert(_index, _value);
    prefs.setStringList('ff_trOrdemServicos',
        _trOrdemServicos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trFazendas = [];
  List<dynamic> get trFazendas => _trFazendas;
  set trFazendas(List<dynamic> _value) {
    _trFazendas = _value;
    prefs.setStringList(
        'ff_trFazendas', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrFazendas(dynamic _value) {
    _trFazendas.add(_value);
    prefs.setStringList(
        'ff_trFazendas', _trFazendas.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrFazendas(dynamic _value) {
    _trFazendas.remove(_value);
    prefs.setStringList(
        'ff_trFazendas', _trFazendas.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrFazendas(int _index) {
    _trFazendas.removeAt(_index);
    prefs.setStringList(
        'ff_trFazendas', _trFazendas.map((x) => jsonEncode(x)).toList());
  }

  void updateTrFazendasAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trFazendas[_index] = updateFn(_trFazendas[_index]);
    prefs.setStringList(
        'ff_trFazendas', _trFazendas.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrFazendas(int _index, dynamic _value) {
    _trFazendas.insert(_index, _value);
    prefs.setStringList(
        'ff_trFazendas', _trFazendas.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trOsTecnicos = [];
  List<dynamic> get trOsTecnicos => _trOsTecnicos;
  set trOsTecnicos(List<dynamic> _value) {
    _trOsTecnicos = _value;
    prefs.setStringList(
        'ff_trOsTecnicos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrOsTecnicos(dynamic _value) {
    _trOsTecnicos.add(_value);
    prefs.setStringList(
        'ff_trOsTecnicos', _trOsTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrOsTecnicos(dynamic _value) {
    _trOsTecnicos.remove(_value);
    prefs.setStringList(
        'ff_trOsTecnicos', _trOsTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrOsTecnicos(int _index) {
    _trOsTecnicos.removeAt(_index);
    prefs.setStringList(
        'ff_trOsTecnicos', _trOsTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void updateTrOsTecnicosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trOsTecnicos[_index] = updateFn(_trOsTecnicos[_index]);
    prefs.setStringList(
        'ff_trOsTecnicos', _trOsTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrOsTecnicos(int _index, dynamic _value) {
    _trOsTecnicos.insert(_index, _value);
    prefs.setStringList(
        'ff_trOsTecnicos', _trOsTecnicos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trOsServicos = [];
  List<dynamic> get trOsServicos => _trOsServicos;
  set trOsServicos(List<dynamic> _value) {
    _trOsServicos = _value;
    prefs.setStringList(
        'ff_trOsServicos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrOsServicos(dynamic _value) {
    _trOsServicos.add(_value);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrOsServicos(dynamic _value) {
    _trOsServicos.remove(_value);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrOsServicos(int _index) {
    _trOsServicos.removeAt(_index);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void updateTrOsServicosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trOsServicos[_index] = updateFn(_trOsServicos[_index]);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrOsServicos(int _index, dynamic _value) {
    _trOsServicos.insert(_index, _value);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trServicos = [];
  List<dynamic> get trServicos => _trServicos;
  set trServicos(List<dynamic> _value) {
    _trServicos = _value;
    prefs.setStringList(
        'ff_trServicos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrServicos(dynamic _value) {
    _trServicos.add(_value);
    prefs.setStringList(
        'ff_trServicos', _trServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrServicos(dynamic _value) {
    _trServicos.remove(_value);
    prefs.setStringList(
        'ff_trServicos', _trServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrServicos(int _index) {
    _trServicos.removeAt(_index);
    prefs.setStringList(
        'ff_trServicos', _trServicos.map((x) => jsonEncode(x)).toList());
  }

  void updateTrServicosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trServicos[_index] = updateFn(_trServicos[_index]);
    prefs.setStringList(
        'ff_trServicos', _trServicos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrServicos(int _index, dynamic _value) {
    _trServicos.insert(_index, _value);
    prefs.setStringList(
        'ff_trServicos', _trServicos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trTecnicos = [];
  List<dynamic> get trTecnicos => _trTecnicos;
  set trTecnicos(List<dynamic> _value) {
    _trTecnicos = _value;
    prefs.setStringList(
        'ff_trTecnicos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrTecnicos(dynamic _value) {
    _trTecnicos.add(_value);
    prefs.setStringList(
        'ff_trTecnicos', _trTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrTecnicos(dynamic _value) {
    _trTecnicos.remove(_value);
    prefs.setStringList(
        'ff_trTecnicos', _trTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrTecnicos(int _index) {
    _trTecnicos.removeAt(_index);
    prefs.setStringList(
        'ff_trTecnicos', _trTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void updateTrTecnicosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trTecnicos[_index] = updateFn(_trTecnicos[_index]);
    prefs.setStringList(
        'ff_trTecnicos', _trTecnicos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrTecnicos(int _index, dynamic _value) {
    _trTecnicos.insert(_index, _value);
    prefs.setStringList(
        'ff_trTecnicos', _trTecnicos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trOsDeslocamentos = [
    jsonDecode(
        '{\"osdes_id\":\"0\",\"osdes_id_oserv\":\"22\",\"osdes_id_tec\":\"7\",\"osdes_latitude_final\":\"-30.042934\",\"osdes_latitude_inicial\":\"\",\"osdes_longitude_inicial\":\"\",\"osdes_status\":\"\",\"osdes_dthr_inicio\":\"\",\"osdes_dthr_fim\":\"\",\"osdes_longitude_final\":\"-51.313421\"}'),
    jsonDecode(
        '{\"osdes_id\":\"0\",\"osdes_id_oserv\":\"22\",\"osdes_id_tec\":\"7\",\"osdes_latitude_final\":\"-30.042934\",\"osdes_latitude_inicial\":\"\",\"osdes_longitude_inicial\":\"\",\"osdes_status\":\"\",\"osdes_dthr_inicio\":\"\",\"osdes_dthr_fim\":\"\",\"osdes_longitude_final\":\"-51.313421\"}'),
    jsonDecode(
        '{\"osdes_id\":\"0\",\"osdes_id_oserv\":\"22\",\"osdes_id_tec\":\"7\",\"osdes_latitude_final\":\"-30.042934\",\"osdes_latitude_inicial\":\"\",\"osdes_longitude_inicial\":\"\",\"osdes_status\":\"\",\"osdes_dthr_inicio\":\"\",\"osdes_dthr_fim\":\"\",\"osdes_longitude_final\":\"-51.313421\"}'),
    jsonDecode(
        '{\"osdes_id\":\"0\",\"osdes_id_oserv\":\"22\",\"osdes_id_tec\":\"7\",\"osdes_latitude_final\":\"-30.042934\",\"osdes_latitude_inicial\":\"\",\"osdes_longitude_inicial\":\"\",\"osdes_status\":\"\",\"osdes_dthr_inicio\":\"\",\"osdes_dthr_fim\":\"\",\"osdes_longitude_final\":\"-51.313421\"}')
  ];
  List<dynamic> get trOsDeslocamentos => _trOsDeslocamentos;
  set trOsDeslocamentos(List<dynamic> _value) {
    _trOsDeslocamentos = _value;
    prefs.setStringList(
        'ff_trOsDeslocamentos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrOsDeslocamentos(dynamic _value) {
    _trOsDeslocamentos.add(_value);
    prefs.setStringList('ff_trOsDeslocamentos',
        _trOsDeslocamentos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrOsDeslocamentos(dynamic _value) {
    _trOsDeslocamentos.remove(_value);
    prefs.setStringList('ff_trOsDeslocamentos',
        _trOsDeslocamentos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrOsDeslocamentos(int _index) {
    _trOsDeslocamentos.removeAt(_index);
    prefs.setStringList('ff_trOsDeslocamentos',
        _trOsDeslocamentos.map((x) => jsonEncode(x)).toList());
  }

  void updateTrOsDeslocamentosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trOsDeslocamentos[_index] = updateFn(_trOsDeslocamentos[_index]);
    prefs.setStringList('ff_trOsDeslocamentos',
        _trOsDeslocamentos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrOsDeslocamentos(int _index, dynamic _value) {
    _trOsDeslocamentos.insert(_index, _value);
    prefs.setStringList('ff_trOsDeslocamentos',
        _trOsDeslocamentos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trDeslocamentoGeo = [];
  List<dynamic> get trDeslocamentoGeo => _trDeslocamentoGeo;
  set trDeslocamentoGeo(List<dynamic> _value) {
    _trDeslocamentoGeo = _value;
    prefs.setStringList(
        'ff_trDeslocamentoGeo', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrDeslocamentoGeo(dynamic _value) {
    _trDeslocamentoGeo.add(_value);
    prefs.setStringList('ff_trDeslocamentoGeo',
        _trDeslocamentoGeo.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrDeslocamentoGeo(dynamic _value) {
    _trDeslocamentoGeo.remove(_value);
    prefs.setStringList('ff_trDeslocamentoGeo',
        _trDeslocamentoGeo.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrDeslocamentoGeo(int _index) {
    _trDeslocamentoGeo.removeAt(_index);
    prefs.setStringList('ff_trDeslocamentoGeo',
        _trDeslocamentoGeo.map((x) => jsonEncode(x)).toList());
  }

  void updateTrDeslocamentoGeoAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trDeslocamentoGeo[_index] = updateFn(_trDeslocamentoGeo[_index]);
    prefs.setStringList('ff_trDeslocamentoGeo',
        _trDeslocamentoGeo.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrDeslocamentoGeo(int _index, dynamic _value) {
    _trDeslocamentoGeo.insert(_index, _value);
    prefs.setStringList('ff_trDeslocamentoGeo',
        _trDeslocamentoGeo.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trDeslocGeo2 = [];
  List<dynamic> get trDeslocGeo2 => _trDeslocGeo2;
  set trDeslocGeo2(List<dynamic> _value) {
    _trDeslocGeo2 = _value;
    prefs.setStringList(
        'ff_trDeslocGeo2', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrDeslocGeo2(dynamic _value) {
    _trDeslocGeo2.add(_value);
    prefs.setStringList(
        'ff_trDeslocGeo2', _trDeslocGeo2.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrDeslocGeo2(dynamic _value) {
    _trDeslocGeo2.remove(_value);
    prefs.setStringList(
        'ff_trDeslocGeo2', _trDeslocGeo2.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrDeslocGeo2(int _index) {
    _trDeslocGeo2.removeAt(_index);
    prefs.setStringList(
        'ff_trDeslocGeo2', _trDeslocGeo2.map((x) => jsonEncode(x)).toList());
  }

  void updateTrDeslocGeo2AtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trDeslocGeo2[_index] = updateFn(_trDeslocGeo2[_index]);
    prefs.setStringList(
        'ff_trDeslocGeo2', _trDeslocGeo2.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrDeslocGeo2(int _index, dynamic _value) {
    _trDeslocGeo2.insert(_index, _value);
    prefs.setStringList(
        'ff_trDeslocGeo2', _trDeslocGeo2.map((x) => jsonEncode(x)).toList());
  }

  List<DeslocamentosGeoStruct> _trDeslocamentoGeoDataType = [];
  List<DeslocamentosGeoStruct> get trDeslocamentoGeoDataType =>
      _trDeslocamentoGeoDataType;
  set trDeslocamentoGeoDataType(List<DeslocamentosGeoStruct> _value) {
    _trDeslocamentoGeoDataType = _value;
    prefs.setStringList('ff_trDeslocamentoGeoDataType',
        _value.map((x) => x.serialize()).toList());
  }

  void addToTrDeslocamentoGeoDataType(DeslocamentosGeoStruct _value) {
    _trDeslocamentoGeoDataType.add(_value);
    prefs.setStringList('ff_trDeslocamentoGeoDataType',
        _trDeslocamentoGeoDataType.map((x) => x.serialize()).toList());
  }

  void removeFromTrDeslocamentoGeoDataType(DeslocamentosGeoStruct _value) {
    _trDeslocamentoGeoDataType.remove(_value);
    prefs.setStringList('ff_trDeslocamentoGeoDataType',
        _trDeslocamentoGeoDataType.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromTrDeslocamentoGeoDataType(int _index) {
    _trDeslocamentoGeoDataType.removeAt(_index);
    prefs.setStringList('ff_trDeslocamentoGeoDataType',
        _trDeslocamentoGeoDataType.map((x) => x.serialize()).toList());
  }

  void updateTrDeslocamentoGeoDataTypeAtIndex(
    int _index,
    DeslocamentosGeoStruct Function(DeslocamentosGeoStruct) updateFn,
  ) {
    _trDeslocamentoGeoDataType[_index] =
        updateFn(_trDeslocamentoGeoDataType[_index]);
    prefs.setStringList('ff_trDeslocamentoGeoDataType',
        _trDeslocamentoGeoDataType.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInTrDeslocamentoGeoDataType(
      int _index, DeslocamentosGeoStruct _value) {
    _trDeslocamentoGeoDataType.insert(_index, _value);
    prefs.setStringList('ff_trDeslocamentoGeoDataType',
        _trDeslocamentoGeoDataType.map((x) => x.serialize()).toList());
  }

  List<dynamic> _trOsDeslocamentoLatLng = [];
  List<dynamic> get trOsDeslocamentoLatLng => _trOsDeslocamentoLatLng;
  set trOsDeslocamentoLatLng(List<dynamic> _value) {
    _trOsDeslocamentoLatLng = _value;
    prefs.setStringList(
        'ff_trOsDeslocamentoLatLng', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrOsDeslocamentoLatLng(dynamic _value) {
    _trOsDeslocamentoLatLng.add(_value);
    prefs.setStringList('ff_trOsDeslocamentoLatLng',
        _trOsDeslocamentoLatLng.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrOsDeslocamentoLatLng(dynamic _value) {
    _trOsDeslocamentoLatLng.remove(_value);
    prefs.setStringList('ff_trOsDeslocamentoLatLng',
        _trOsDeslocamentoLatLng.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrOsDeslocamentoLatLng(int _index) {
    _trOsDeslocamentoLatLng.removeAt(_index);
    prefs.setStringList('ff_trOsDeslocamentoLatLng',
        _trOsDeslocamentoLatLng.map((x) => jsonEncode(x)).toList());
  }

  void updateTrOsDeslocamentoLatLngAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trOsDeslocamentoLatLng[_index] = updateFn(_trOsDeslocamentoLatLng[_index]);
    prefs.setStringList('ff_trOsDeslocamentoLatLng',
        _trOsDeslocamentoLatLng.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrOsDeslocamentoLatLng(int _index, dynamic _value) {
    _trOsDeslocamentoLatLng.insert(_index, _value);
    prefs.setStringList('ff_trOsDeslocamentoLatLng',
        _trOsDeslocamentoLatLng.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trOsDeslocamentosJsonFinalizados = [];
  List<dynamic> get trOsDeslocamentosJsonFinalizados =>
      _trOsDeslocamentosJsonFinalizados;
  set trOsDeslocamentosJsonFinalizados(List<dynamic> _value) {
    _trOsDeslocamentosJsonFinalizados = _value;
    prefs.setStringList('ff_trOsDeslocamentosJsonFinalizados',
        _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrOsDeslocamentosJsonFinalizados(dynamic _value) {
    _trOsDeslocamentosJsonFinalizados.add(_value);
    prefs.setStringList('ff_trOsDeslocamentosJsonFinalizados',
        _trOsDeslocamentosJsonFinalizados.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrOsDeslocamentosJsonFinalizados(dynamic _value) {
    _trOsDeslocamentosJsonFinalizados.remove(_value);
    prefs.setStringList('ff_trOsDeslocamentosJsonFinalizados',
        _trOsDeslocamentosJsonFinalizados.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrOsDeslocamentosJsonFinalizados(int _index) {
    _trOsDeslocamentosJsonFinalizados.removeAt(_index);
    prefs.setStringList('ff_trOsDeslocamentosJsonFinalizados',
        _trOsDeslocamentosJsonFinalizados.map((x) => jsonEncode(x)).toList());
  }

  void updateTrOsDeslocamentosJsonFinalizadosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trOsDeslocamentosJsonFinalizados[_index] =
        updateFn(_trOsDeslocamentosJsonFinalizados[_index]);
    prefs.setStringList('ff_trOsDeslocamentosJsonFinalizados',
        _trOsDeslocamentosJsonFinalizados.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrOsDeslocamentosJsonFinalizados(
      int _index, dynamic _value) {
    _trOsDeslocamentosJsonFinalizados.insert(_index, _value);
    prefs.setStringList('ff_trOsDeslocamentosJsonFinalizados',
        _trOsDeslocamentosJsonFinalizados.map((x) => jsonEncode(x)).toList());
  }

  List<String> _trOsDeslocamentoListaFinalizados = [];
  List<String> get trOsDeslocamentoListaFinalizados =>
      _trOsDeslocamentoListaFinalizados;
  set trOsDeslocamentoListaFinalizados(List<String> _value) {
    _trOsDeslocamentoListaFinalizados = _value;
    prefs.setStringList('ff_trOsDeslocamentoListaFinalizados', _value);
  }

  void addToTrOsDeslocamentoListaFinalizados(String _value) {
    _trOsDeslocamentoListaFinalizados.add(_value);
    prefs.setStringList('ff_trOsDeslocamentoListaFinalizados',
        _trOsDeslocamentoListaFinalizados);
  }

  void removeFromTrOsDeslocamentoListaFinalizados(String _value) {
    _trOsDeslocamentoListaFinalizados.remove(_value);
    prefs.setStringList('ff_trOsDeslocamentoListaFinalizados',
        _trOsDeslocamentoListaFinalizados);
  }

  void removeAtIndexFromTrOsDeslocamentoListaFinalizados(int _index) {
    _trOsDeslocamentoListaFinalizados.removeAt(_index);
    prefs.setStringList('ff_trOsDeslocamentoListaFinalizados',
        _trOsDeslocamentoListaFinalizados);
  }

  void updateTrOsDeslocamentoListaFinalizadosAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _trOsDeslocamentoListaFinalizados[_index] =
        updateFn(_trOsDeslocamentoListaFinalizados[_index]);
    prefs.setStringList('ff_trOsDeslocamentoListaFinalizados',
        _trOsDeslocamentoListaFinalizados);
  }

  void insertAtIndexInTrOsDeslocamentoListaFinalizados(
      int _index, String _value) {
    _trOsDeslocamentoListaFinalizados.insert(_index, _value);
    prefs.setStringList('ff_trOsDeslocamentoListaFinalizados',
        _trOsDeslocamentoListaFinalizados);
  }

  dynamic _teste = jsonDecode(
      '{\"osdes_id\":\"0\",\"osdes_id_oserv\":\"22\",\"osdes_id_tec\":\"7\",\"osdes_ponto_informacao\":\"1\",\"osdes_latitude\":\"-29.914965290989\",\"osdes_longitude\":\"-51.1969985858828\",\"osdes_dthr_cad\":\"\",\"osdes_usu_cad\":\"null\",\"osdes_dthr_alt\":\"null\",\"osdes_usu_alt\":\"null\"}');
  dynamic get teste => _teste;
  set teste(dynamic _value) {
    _teste = _value;
    prefs.setString('ff_teste', jsonEncode(_value));
  }

  dynamic _trOsServicoEmAndamento;
  dynamic get trOsServicoEmAndamento => _trOsServicoEmAndamento;
  set trOsServicoEmAndamento(dynamic _value) {
    _trOsServicoEmAndamento = _value;
    prefs.setString('ff_trOsServicoEmAndamento', jsonEncode(_value));
  }

  List<String> _MotivoPausaDeslocamento = [];
  List<String> get MotivoPausaDeslocamento => _MotivoPausaDeslocamento;
  set MotivoPausaDeslocamento(List<String> _value) {
    _MotivoPausaDeslocamento = _value;
    prefs.setStringList('ff_MotivoPausaDeslocamento', _value);
  }

  void addToMotivoPausaDeslocamento(String _value) {
    _MotivoPausaDeslocamento.add(_value);
    prefs.setStringList('ff_MotivoPausaDeslocamento', _MotivoPausaDeslocamento);
  }

  void removeFromMotivoPausaDeslocamento(String _value) {
    _MotivoPausaDeslocamento.remove(_value);
    prefs.setStringList('ff_MotivoPausaDeslocamento', _MotivoPausaDeslocamento);
  }

  void removeAtIndexFromMotivoPausaDeslocamento(int _index) {
    _MotivoPausaDeslocamento.removeAt(_index);
    prefs.setStringList('ff_MotivoPausaDeslocamento', _MotivoPausaDeslocamento);
  }

  void updateMotivoPausaDeslocamentoAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _MotivoPausaDeslocamento[_index] =
        updateFn(_MotivoPausaDeslocamento[_index]);
    prefs.setStringList('ff_MotivoPausaDeslocamento', _MotivoPausaDeslocamento);
  }

  void insertAtIndexInMotivoPausaDeslocamento(int _index, String _value) {
    _MotivoPausaDeslocamento.insert(_index, _value);
    prefs.setStringList('ff_MotivoPausaDeslocamento', _MotivoPausaDeslocamento);
  }

  bool _trDesloacamentoIniciado = false;
  bool get trDesloacamentoIniciado => _trDesloacamentoIniciado;
  set trDesloacamentoIniciado(bool _value) {
    _trDesloacamentoIniciado = _value;
    prefs.setBool('ff_trDesloacamentoIniciado', _value);
  }

  bool _DeslocamentoPausado = false;
  bool get DeslocamentoPausado => _DeslocamentoPausado;
  set DeslocamentoPausado(bool _value) {
    _DeslocamentoPausado = _value;
    prefs.setBool('ff_DeslocamentoPausado', _value);
  }

  bool _trDeslocamentoFinalizado = false;
  bool get trDeslocamentoFinalizado => _trDeslocamentoFinalizado;
  set trDeslocamentoFinalizado(bool _value) {
    _trDeslocamentoFinalizado = _value;
    prefs.setBool('ff_trDeslocamentoFinalizado', _value);
  }

  String _strDeslocamentosJson = '';
  String get strDeslocamentosJson => _strDeslocamentosJson;
  set strDeslocamentosJson(String _value) {
    _strDeslocamentosJson = _value;
    prefs.setString('ff_strDeslocamentosJson', _value);
  }

  String _localizacaoZero = 'LatLng(lat: 0.0, lng: 0.0)';
  String get localizacaoZero => _localizacaoZero;
  set localizacaoZero(String _value) {
    _localizacaoZero = _value;
    prefs.setString('ff_localizacaoZero', _value);
  }

  String _AtualLocalizcao = '';
  String get AtualLocalizcao => _AtualLocalizcao;
  set AtualLocalizcao(String _value) {
    _AtualLocalizcao = _value;
    prefs.setString('ff_AtualLocalizcao', _value);
  }

  LatLng? _LocalAtual = LatLng(-29.91356438838432, -51.1952166424928);
  LatLng? get LocalAtual => _LocalAtual;
  set LocalAtual(LatLng? _value) {
    _LocalAtual = _value;
    _value != null
        ? prefs.setString('ff_LocalAtual', _value.serialize())
        : prefs.remove('ff_LocalAtual');
  }

  List<String> _servicosFinalizadosComSucesso = [];
  List<String> get servicosFinalizadosComSucesso =>
      _servicosFinalizadosComSucesso;
  set servicosFinalizadosComSucesso(List<String> _value) {
    _servicosFinalizadosComSucesso = _value;
    prefs.setStringList('ff_servicosFinalizadosComSucesso', _value);
  }

  void addToServicosFinalizadosComSucesso(String _value) {
    _servicosFinalizadosComSucesso.add(_value);
    prefs.setStringList(
        'ff_servicosFinalizadosComSucesso', _servicosFinalizadosComSucesso);
  }

  void removeFromServicosFinalizadosComSucesso(String _value) {
    _servicosFinalizadosComSucesso.remove(_value);
    prefs.setStringList(
        'ff_servicosFinalizadosComSucesso', _servicosFinalizadosComSucesso);
  }

  void removeAtIndexFromServicosFinalizadosComSucesso(int _index) {
    _servicosFinalizadosComSucesso.removeAt(_index);
    prefs.setStringList(
        'ff_servicosFinalizadosComSucesso', _servicosFinalizadosComSucesso);
  }

  void updateServicosFinalizadosComSucessoAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _servicosFinalizadosComSucesso[_index] =
        updateFn(_servicosFinalizadosComSucesso[_index]);
    prefs.setStringList(
        'ff_servicosFinalizadosComSucesso', _servicosFinalizadosComSucesso);
  }

  void insertAtIndexInServicosFinalizadosComSucesso(int _index, String _value) {
    _servicosFinalizadosComSucesso.insert(_index, _value);
    prefs.setStringList(
        'ff_servicosFinalizadosComSucesso', _servicosFinalizadosComSucesso);
  }

  String _userLogin = '';
  String get userLogin => _userLogin;
  set userLogin(String _value) {
    _userLogin = _value;
    prefs.setString('ff_userLogin', _value);
  }

  String _psdwLogin = '';
  String get psdwLogin => _psdwLogin;
  set psdwLogin(String _value) {
    _psdwLogin = _value;
    prefs.setString('ff_psdwLogin', _value);
  }

  dynamic _trOsDeslocamentoJsonAtual = jsonDecode(
      '{\"osdes_id\":\"2\",\"osdes_id_oserv\":\"0\",\"osdes_id_tec\":\"0\",\"osdes_latitude_final\":\"0\",\"osdes_latitude_inicial\":\"0\",\"osdes_longitude_inicial\":\"0\",\"osdes_status\":\"0\",\"osdes_dthr_inicio\":\"0\",\"osdes_dthr_fim\":\"0\",\"osdes_longitude_final\":\"0\"}');
  dynamic get trOsDeslocamentoJsonAtual => _trOsDeslocamentoJsonAtual;
  set trOsDeslocamentoJsonAtual(dynamic _value) {
    _trOsDeslocamentoJsonAtual = _value;
    prefs.setString('ff_trOsDeslocamentoJsonAtual', jsonEncode(_value));
  }

  bool _Desenvolvimento = true;
  bool get Desenvolvimento => _Desenvolvimento;
  set Desenvolvimento(bool _value) {
    _Desenvolvimento = _value;
    prefs.setBool('ff_Desenvolvimento', _value);
  }

  bool _sincronizcaoAutomatica = false;
  bool get sincronizcaoAutomatica => _sincronizcaoAutomatica;
  set sincronizcaoAutomatica(bool _value) {
    _sincronizcaoAutomatica = _value;
    prefs.setBool('ff_sincronizcaoAutomatica', _value);
  }

  String _JsonPathPesquisaAvancada = 'oserv_id_os';
  String get JsonPathPesquisaAvancada => _JsonPathPesquisaAvancada;
  set JsonPathPesquisaAvancada(String _value) {
    _JsonPathPesquisaAvancada = _value;
    prefs.setString('ff_JsonPathPesquisaAvancada', _value);
  }

  int _qualSwitchEstaAtivo = 4;
  int get qualSwitchEstaAtivo => _qualSwitchEstaAtivo;
  set qualSwitchEstaAtivo(int _value) {
    _qualSwitchEstaAtivo = _value;
    prefs.setInt('ff_qualSwitchEstaAtivo', _value);
  }

  LatLng? _excluirLocal = LatLng(-29.85337397017475, -51.26796129400564);
  LatLng? get excluirLocal => _excluirLocal;
  set excluirLocal(LatLng? _value) {
    _excluirLocal = _value;
    _value != null
        ? prefs.setString('ff_excluirLocal', _value.serialize())
        : prefs.remove('ff_excluirLocal');
  }

  int _tempoEmSegundosPadraoDeCapturaDeLocal = 0;
  int get tempoEmSegundosPadraoDeCapturaDeLocal =>
      _tempoEmSegundosPadraoDeCapturaDeLocal;
  set tempoEmSegundosPadraoDeCapturaDeLocal(int _value) {
    _tempoEmSegundosPadraoDeCapturaDeLocal = _value;
    prefs.setInt('ff_tempoEmSegundosPadraoDeCapturaDeLocal', _value);
  }

  List<dynamic> _rotainversa = [];
  List<dynamic> get rotainversa => _rotainversa;
  set rotainversa(List<dynamic> _value) {
    _rotainversa = _value;
    prefs.setStringList(
        'ff_rotainversa', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToRotainversa(dynamic _value) {
    _rotainversa.add(_value);
    prefs.setStringList(
        'ff_rotainversa', _rotainversa.map((x) => jsonEncode(x)).toList());
  }

  void removeFromRotainversa(dynamic _value) {
    _rotainversa.remove(_value);
    prefs.setStringList(
        'ff_rotainversa', _rotainversa.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromRotainversa(int _index) {
    _rotainversa.removeAt(_index);
    prefs.setStringList(
        'ff_rotainversa', _rotainversa.map((x) => jsonEncode(x)).toList());
  }

  void updateRotainversaAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _rotainversa[_index] = updateFn(_rotainversa[_index]);
    prefs.setStringList(
        'ff_rotainversa', _rotainversa.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInRotainversa(int _index, dynamic _value) {
    _rotainversa.insert(_index, _value);
    prefs.setStringList(
        'ff_rotainversa', _rotainversa.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _contornoFazenda = [];
  List<dynamic> get contornoFazenda => _contornoFazenda;
  set contornoFazenda(List<dynamic> _value) {
    _contornoFazenda = _value;
    prefs.setStringList(
        'ff_contornoFazenda', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToContornoFazenda(dynamic _value) {
    _contornoFazenda.add(_value);
    prefs.setStringList('ff_contornoFazenda',
        _contornoFazenda.map((x) => jsonEncode(x)).toList());
  }

  void removeFromContornoFazenda(dynamic _value) {
    _contornoFazenda.remove(_value);
    prefs.setStringList('ff_contornoFazenda',
        _contornoFazenda.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromContornoFazenda(int _index) {
    _contornoFazenda.removeAt(_index);
    prefs.setStringList('ff_contornoFazenda',
        _contornoFazenda.map((x) => jsonEncode(x)).toList());
  }

  void updateContornoFazendaAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _contornoFazenda[_index] = updateFn(_contornoFazenda[_index]);
    prefs.setStringList('ff_contornoFazenda',
        _contornoFazenda.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInContornoFazenda(int _index, dynamic _value) {
    _contornoFazenda.insert(_index, _value);
    prefs.setStringList('ff_contornoFazenda',
        _contornoFazenda.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _contornoFazendaPosSincronizado = [];
  List<dynamic> get contornoFazendaPosSincronizado =>
      _contornoFazendaPosSincronizado;
  set contornoFazendaPosSincronizado(List<dynamic> _value) {
    _contornoFazendaPosSincronizado = _value;
    prefs.setStringList('ff_contornoFazendaPosSincronizado',
        _value.map((x) => jsonEncode(x)).toList());
  }

  void addToContornoFazendaPosSincronizado(dynamic _value) {
    _contornoFazendaPosSincronizado.add(_value);
    prefs.setStringList('ff_contornoFazendaPosSincronizado',
        _contornoFazendaPosSincronizado.map((x) => jsonEncode(x)).toList());
  }

  void removeFromContornoFazendaPosSincronizado(dynamic _value) {
    _contornoFazendaPosSincronizado.remove(_value);
    prefs.setStringList('ff_contornoFazendaPosSincronizado',
        _contornoFazendaPosSincronizado.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromContornoFazendaPosSincronizado(int _index) {
    _contornoFazendaPosSincronizado.removeAt(_index);
    prefs.setStringList('ff_contornoFazendaPosSincronizado',
        _contornoFazendaPosSincronizado.map((x) => jsonEncode(x)).toList());
  }

  void updateContornoFazendaPosSincronizadoAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _contornoFazendaPosSincronizado[_index] =
        updateFn(_contornoFazendaPosSincronizado[_index]);
    prefs.setStringList('ff_contornoFazendaPosSincronizado',
        _contornoFazendaPosSincronizado.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInContornoFazendaPosSincronizado(
      int _index, dynamic _value) {
    _contornoFazendaPosSincronizado.insert(_index, _value);
    prefs.setStringList('ff_contornoFazendaPosSincronizado',
        _contornoFazendaPosSincronizado.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _grupoContornoFazendas = [];
  List<dynamic> get grupoContornoFazendas => _grupoContornoFazendas;
  set grupoContornoFazendas(List<dynamic> _value) {
    _grupoContornoFazendas = _value;
    prefs.setStringList(
        'ff_grupoContornoFazendas', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToGrupoContornoFazendas(dynamic _value) {
    _grupoContornoFazendas.add(_value);
    prefs.setStringList('ff_grupoContornoFazendas',
        _grupoContornoFazendas.map((x) => jsonEncode(x)).toList());
  }

  void removeFromGrupoContornoFazendas(dynamic _value) {
    _grupoContornoFazendas.remove(_value);
    prefs.setStringList('ff_grupoContornoFazendas',
        _grupoContornoFazendas.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromGrupoContornoFazendas(int _index) {
    _grupoContornoFazendas.removeAt(_index);
    prefs.setStringList('ff_grupoContornoFazendas',
        _grupoContornoFazendas.map((x) => jsonEncode(x)).toList());
  }

  void updateGrupoContornoFazendasAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _grupoContornoFazendas[_index] = updateFn(_grupoContornoFazendas[_index]);
    prefs.setStringList('ff_grupoContornoFazendas',
        _grupoContornoFazendas.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInGrupoContornoFazendas(int _index, dynamic _value) {
    _grupoContornoFazendas.insert(_index, _value);
    prefs.setStringList('ff_grupoContornoFazendas',
        _grupoContornoFazendas.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _grupoContornoFazendasPosSincronizado = [];
  List<dynamic> get grupoContornoFazendasPosSincronizado =>
      _grupoContornoFazendasPosSincronizado;
  set grupoContornoFazendasPosSincronizado(List<dynamic> _value) {
    _grupoContornoFazendasPosSincronizado = _value;
    prefs.setStringList('ff_grupoContornoFazendasPosSincronizado',
        _value.map((x) => jsonEncode(x)).toList());
  }

  void addToGrupoContornoFazendasPosSincronizado(dynamic _value) {
    _grupoContornoFazendasPosSincronizado.add(_value);
    prefs.setStringList(
        'ff_grupoContornoFazendasPosSincronizado',
        _grupoContornoFazendasPosSincronizado
            .map((x) => jsonEncode(x))
            .toList());
  }

  void removeFromGrupoContornoFazendasPosSincronizado(dynamic _value) {
    _grupoContornoFazendasPosSincronizado.remove(_value);
    prefs.setStringList(
        'ff_grupoContornoFazendasPosSincronizado',
        _grupoContornoFazendasPosSincronizado
            .map((x) => jsonEncode(x))
            .toList());
  }

  void removeAtIndexFromGrupoContornoFazendasPosSincronizado(int _index) {
    _grupoContornoFazendasPosSincronizado.removeAt(_index);
    prefs.setStringList(
        'ff_grupoContornoFazendasPosSincronizado',
        _grupoContornoFazendasPosSincronizado
            .map((x) => jsonEncode(x))
            .toList());
  }

  void updateGrupoContornoFazendasPosSincronizadoAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _grupoContornoFazendasPosSincronizado[_index] =
        updateFn(_grupoContornoFazendasPosSincronizado[_index]);
    prefs.setStringList(
        'ff_grupoContornoFazendasPosSincronizado',
        _grupoContornoFazendasPosSincronizado
            .map((x) => jsonEncode(x))
            .toList());
  }

  void insertAtIndexInGrupoContornoFazendasPosSincronizado(
      int _index, dynamic _value) {
    _grupoContornoFazendasPosSincronizado.insert(_index, _value);
    prefs.setStringList(
        'ff_grupoContornoFazendasPosSincronizado',
        _grupoContornoFazendasPosSincronizado
            .map((x) => jsonEncode(x))
            .toList());
  }

  String _contornoGrupoID = '';
  String get contornoGrupoID => _contornoGrupoID;
  set contornoGrupoID(String _value) {
    _contornoGrupoID = _value;
    prefs.setString('ff_contornoGrupoID', _value);
  }

  List<dynamic> _PontosMovidos = [];
  List<dynamic> get PontosMovidos => _PontosMovidos;
  set PontosMovidos(List<dynamic> _value) {
    _PontosMovidos = _value;
    prefs.setStringList(
        'ff_PontosMovidos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToPontosMovidos(dynamic _value) {
    _PontosMovidos.add(_value);
    prefs.setStringList(
        'ff_PontosMovidos', _PontosMovidos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPontosMovidos(dynamic _value) {
    _PontosMovidos.remove(_value);
    prefs.setStringList(
        'ff_PontosMovidos', _PontosMovidos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPontosMovidos(int _index) {
    _PontosMovidos.removeAt(_index);
    prefs.setStringList(
        'ff_PontosMovidos', _PontosMovidos.map((x) => jsonEncode(x)).toList());
  }

  void updatePontosMovidosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _PontosMovidos[_index] = updateFn(_PontosMovidos[_index]);
    prefs.setStringList(
        'ff_PontosMovidos', _PontosMovidos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPontosMovidos(int _index, dynamic _value) {
    _PontosMovidos.insert(_index, _value);
    prefs.setStringList(
        'ff_PontosMovidos', _PontosMovidos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _PontosColetados = [];
  List<dynamic> get PontosColetados => _PontosColetados;
  set PontosColetados(List<dynamic> _value) {
    _PontosColetados = _value;
    prefs.setStringList(
        'ff_PontosColetados', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToPontosColetados(dynamic _value) {
    _PontosColetados.add(_value);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPontosColetados(dynamic _value) {
    _PontosColetados.remove(_value);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPontosColetados(int _index) {
    _PontosColetados.removeAt(_index);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void updatePontosColetadosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _PontosColetados[_index] = updateFn(_PontosColetados[_index]);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPontosColetados(int _index, dynamic _value) {
    _PontosColetados.insert(_index, _value);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _PontosExcluidos = [];
  List<dynamic> get PontosExcluidos => _PontosExcluidos;
  set PontosExcluidos(List<dynamic> _value) {
    _PontosExcluidos = _value;
    prefs.setStringList(
        'ff_PontosExcluidos', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToPontosExcluidos(dynamic _value) {
    _PontosExcluidos.add(_value);
    prefs.setStringList('ff_PontosExcluidos',
        _PontosExcluidos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPontosExcluidos(dynamic _value) {
    _PontosExcluidos.remove(_value);
    prefs.setStringList('ff_PontosExcluidos',
        _PontosExcluidos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPontosExcluidos(int _index) {
    _PontosExcluidos.removeAt(_index);
    prefs.setStringList('ff_PontosExcluidos',
        _PontosExcluidos.map((x) => jsonEncode(x)).toList());
  }

  void updatePontosExcluidosAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _PontosExcluidos[_index] = updateFn(_PontosExcluidos[_index]);
    prefs.setStringList('ff_PontosExcluidos',
        _PontosExcluidos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPontosExcluidos(int _index, dynamic _value) {
    _PontosExcluidos.insert(_index, _value);
    prefs.setStringList('ff_PontosExcluidos',
        _PontosExcluidos.map((x) => jsonEncode(x)).toList());
  }

  int _distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra = 0;
  int get distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra =>
      _distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra;
  set distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra(int _value) {
    _distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra = _value;
    prefs.setInt(
        'ff_distanciaEmMetrosDeToleranciaEntreUmaCapturaEOutra', _value);
  }

  List<String> _possiveisProfuncidadesDeColeta = ['0-10', '10-20', '20-30'];
  List<String> get possiveisProfuncidadesDeColeta =>
      _possiveisProfuncidadesDeColeta;
  set possiveisProfuncidadesDeColeta(List<String> _value) {
    _possiveisProfuncidadesDeColeta = _value;
    prefs.setStringList('ff_possiveisProfuncidadesDeColeta', _value);
  }

  void addToPossiveisProfuncidadesDeColeta(String _value) {
    _possiveisProfuncidadesDeColeta.add(_value);
    prefs.setStringList(
        'ff_possiveisProfuncidadesDeColeta', _possiveisProfuncidadesDeColeta);
  }

  void removeFromPossiveisProfuncidadesDeColeta(String _value) {
    _possiveisProfuncidadesDeColeta.remove(_value);
    prefs.setStringList(
        'ff_possiveisProfuncidadesDeColeta', _possiveisProfuncidadesDeColeta);
  }

  void removeAtIndexFromPossiveisProfuncidadesDeColeta(int _index) {
    _possiveisProfuncidadesDeColeta.removeAt(_index);
    prefs.setStringList(
        'ff_possiveisProfuncidadesDeColeta', _possiveisProfuncidadesDeColeta);
  }

  void updatePossiveisProfuncidadesDeColetaAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _possiveisProfuncidadesDeColeta[_index] =
        updateFn(_possiveisProfuncidadesDeColeta[_index]);
    prefs.setStringList(
        'ff_possiveisProfuncidadesDeColeta', _possiveisProfuncidadesDeColeta);
  }

  void insertAtIndexInPossiveisProfuncidadesDeColeta(
      int _index, String _value) {
    _possiveisProfuncidadesDeColeta.insert(_index, _value);
    prefs.setStringList(
        'ff_possiveisProfuncidadesDeColeta', _possiveisProfuncidadesDeColeta);
  }

  List<String> _listaDeLocaisDeAreasParaColeta = [
    '{ \"marcador_nome\": \"A\", \"latlng_marcadores\": \"-29.914939224621914, -51.195420011983714\", \"profundidades\": [ {\"nome\": \"0-10\", \"icone\": \"location_dot\", \"cor\": \"#FFC0CB\"}, {\"nome\": \"0-20\", \"icone\": \"flag\", \"cor\": \"#FF4500\"}, {\"nome\": \"0-25\", \"icone\": \"map_pin\", \"cor\": \"#0000CD\"} ], \"foto_de_cada_profundidade\": [], }'
  ];
  List<String> get listaDeLocaisDeAreasParaColeta =>
      _listaDeLocaisDeAreasParaColeta;
  set listaDeLocaisDeAreasParaColeta(List<String> _value) {
    _listaDeLocaisDeAreasParaColeta = _value;
    prefs.setStringList('ff_listaDeLocaisDeAreasParaColeta', _value);
  }

  void addToListaDeLocaisDeAreasParaColeta(String _value) {
    _listaDeLocaisDeAreasParaColeta.add(_value);
    prefs.setStringList(
        'ff_listaDeLocaisDeAreasParaColeta', _listaDeLocaisDeAreasParaColeta);
  }

  void removeFromListaDeLocaisDeAreasParaColeta(String _value) {
    _listaDeLocaisDeAreasParaColeta.remove(_value);
    prefs.setStringList(
        'ff_listaDeLocaisDeAreasParaColeta', _listaDeLocaisDeAreasParaColeta);
  }

  void removeAtIndexFromListaDeLocaisDeAreasParaColeta(int _index) {
    _listaDeLocaisDeAreasParaColeta.removeAt(_index);
    prefs.setStringList(
        'ff_listaDeLocaisDeAreasParaColeta', _listaDeLocaisDeAreasParaColeta);
  }

  void updateListaDeLocaisDeAreasParaColetaAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _listaDeLocaisDeAreasParaColeta[_index] =
        updateFn(_listaDeLocaisDeAreasParaColeta[_index]);
    prefs.setStringList(
        'ff_listaDeLocaisDeAreasParaColeta', _listaDeLocaisDeAreasParaColeta);
  }

  void insertAtIndexInListaDeLocaisDeAreasParaColeta(
      int _index, String _value) {
    _listaDeLocaisDeAreasParaColeta.insert(_index, _value);
    prefs.setStringList(
        'ff_listaDeLocaisDeAreasParaColeta', _listaDeLocaisDeAreasParaColeta);
  }

  List<String> _latLngListaMarcadoresArea = [
    '{\"grupo\": \"2\", \"latlng\": \"-29.915044, -51.195798\"}',
    '{\"grupo\": \"2\", \"latlng\": \"-29.915091, -51.194011\"}',
    '{\"grupo\": \"2\", \"latlng\": \"-29.913644, -51.193930\"}',
    '{\"grupo\": \"2\", \"latlng\": \"-29.913558, -51.195563\"}'
  ];
  List<String> get latLngListaMarcadoresArea => _latLngListaMarcadoresArea;
  set latLngListaMarcadoresArea(List<String> _value) {
    _latLngListaMarcadoresArea = _value;
    prefs.setStringList('ff_latLngListaMarcadoresArea', _value);
  }

  void addToLatLngListaMarcadoresArea(String _value) {
    _latLngListaMarcadoresArea.add(_value);
    prefs.setStringList(
        'ff_latLngListaMarcadoresArea', _latLngListaMarcadoresArea);
  }

  void removeFromLatLngListaMarcadoresArea(String _value) {
    _latLngListaMarcadoresArea.remove(_value);
    prefs.setStringList(
        'ff_latLngListaMarcadoresArea', _latLngListaMarcadoresArea);
  }

  void removeAtIndexFromLatLngListaMarcadoresArea(int _index) {
    _latLngListaMarcadoresArea.removeAt(_index);
    prefs.setStringList(
        'ff_latLngListaMarcadoresArea', _latLngListaMarcadoresArea);
  }

  void updateLatLngListaMarcadoresAreaAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _latLngListaMarcadoresArea[_index] =
        updateFn(_latLngListaMarcadoresArea[_index]);
    prefs.setStringList(
        'ff_latLngListaMarcadoresArea', _latLngListaMarcadoresArea);
  }

  void insertAtIndexInLatLngListaMarcadoresArea(int _index, String _value) {
    _latLngListaMarcadoresArea.insert(_index, _value);
    prefs.setStringList(
        'ff_latLngListaMarcadoresArea', _latLngListaMarcadoresArea);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
