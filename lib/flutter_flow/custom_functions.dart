import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';

int? maiorNumero(String? numeros) {
  if (numeros == null) {
    return null;
  }

  // Separe a variável numeros usando o caractere '//'
  List<String> partes = numeros.split(' // ');

  // Inicialize o maior número com o menor valor possível
  double maior = double.negativeInfinity;

  // Percorra cada parte, converta para double e atualize o maior número se necessário
  for (var parte in partes) {
    try {
      double numero = double.parse(parte.trim());
      if (numero > maior) {
        maior = numero;
      }
    } catch (e) {
      // Ignore partes que não podem ser convertidas para números
    }
  }

  // Retorna o maior número encontrado
  if (maior == double.negativeInfinity) {
    return null; // Retorna null se não houver números válidos
  } else {
    return maior.toInt(); // Converte o maior número para inteiro
  }
}

String? ligacaoEntreListas(
  List<dynamic>? lista1,
  List<dynamic>? lista2,
  String? jsonpathDaLista1,
  String? jsonpathDaLista2,
  String? jsonpathRetorno,
) {
//lista 1 contem a tabela que eu tenho
//lista 2 contem a tabela que eu quero tirar a informação
  if (lista1 == null ||
      lista2 == null ||
      jsonpathDaLista1 == null ||
      jsonpathDaLista2 == null ||
      jsonpathRetorno == null) {
    return null; // Retorna null se algum dos parâmetros for nulo
  }

  // Itera sobre a lista1 e encontra o campo correspondente na lista2
  for (var item1 in lista1) {
    var valorCampoLista1 = getJsonField(item1, jsonpathDaLista1);

    // Itera sobre a lista2 para encontrar a correspondência
    for (var item2 in lista2) {
      var valorCampoLista2 = getJsonField(item2, jsonpathDaLista2);

      // Se os valores são iguais, retorna o valor correspondente da lista2 usando o jsonpathRetorno
      if (valorCampoLista1 == valorCampoLista2) {
        return getJsonField(item2, jsonpathRetorno)?.toString();
      }
    }
  }

  // Se não encontrar correspondência, retorna null
  return null;
}

dynamic getJsonField(dynamic json, String? jsonPath) {
  if (jsonPath == null) {
    return null;
  }

  var keys = jsonPath.split('.');
  dynamic result = json;

  for (var key in keys) {
    if (result is Map) {
      if (result.containsKey(key)) {
        result = result[key];
      } else {
        return null;
      }
    } else if (result is List) {
      int index;
      try {
        index = int.parse(key);
      } catch (e) {
        return null;
      }
      if (index >= 0 && index < result.length) {
        result = result[index];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  return result;
}

String? ligaoDeNome(
  List<dynamic>? lista1,
  String? jsonpathLista1,
  String? jssonpathRetorno,
  String? valorJsonpathLista1,
) {
  if (lista1 == null ||
      jsonpathLista1 == null ||
      jssonpathRetorno == null ||
      valorJsonpathLista1 == null) {
    return null; // Retorna null se algum dos parâmetros for nulo
  }

  // Itera sobre a lista1 e encontra o item correspondente ao valorJsonpathLista1
  for (var item1 in lista1) {
    var valorCampoLista1 = _getJsonField(item1, jsonpathLista1);

    // Compara o valor do campo com o valorJsonpathLista1
    if (valorCampoLista1 != null &&
        valorCampoLista1.toString() == valorJsonpathLista1) {
      // Retorna o valor correspondente ao jssonpathRetorno
      return _getJsonField(item1, jssonpathRetorno)?.toString();
    }
  }

  // Se não encontrar correspondência, retorna null
  return null;
}

dynamic _getJsonField(dynamic json, String? jsonPath) {
  if (jsonPath == null) {
    return null;
  }

  var keys = jsonPath.split('.');
  dynamic result = json;

  for (var key in keys) {
    if (result is Map) {
      if (result.containsKey(key)) {
        result = result[key];
      } else {
        return null;
      }
    } else if (result is List) {
      int index;
      try {
        index = int.parse(key);
      } catch (e) {
        return null;
      }
      if (index >= 0 && index < result.length) {
        result = result[index];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  return result;
}

LatLng? strToLatLng(
  String? lat,
  String? lng,
) {
  // Certifique-se de que lat e lng não sejam nulos
  if (lat == null || lng == null) {
    return null;
  }

  // Tente converter as strings para valores double
  double? latitude = double.tryParse(lat);
  double? longitude = double.tryParse(lng);

  // Se a conversão for bem-sucedida, retorne um objeto LatLng
  if (latitude != null && longitude != null) {
    return LatLng(latitude, longitude);
  } else {
    return null; // Retorna null se a conversão falhar
  }
}

dynamic strToJsonDeslocamento(
  LatLng? latlng,
  String? servicoID,
  String? tecnicoID,
  String? entradaOuSaida,
) {
  double lat = latlng?.latitude ?? 0.0;
  double lng = latlng?.longitude ?? 0.0;

  int? parsedServicoID = int.tryParse(servicoID ?? '');
  int? parsedTecnicoID = int.tryParse(tecnicoID ?? '');

  Map<String, dynamic> jsonData = {
    "osdes_id_oserv": parsedServicoID,
    "osdes_id_tec": parsedTecnicoID,
    "osdes_ponto_informacao": entradaOuSaida,
    "osdes_latitude": "$lat",
    "osdes_longitude": "$lng",
    "osdes_dthr_cad": "",
    "osdes_usu_cad": null,
    "osdes_dthr_alt": null,
    "osdes_usu_alt": null,
    "osdes_tide_id": 1
  };

  String jsonString = jsonEncode(jsonData);
  return jsonString;
}

String? strToHORA(String? str) {
  if (str == null) {
    return ""; // or handle the null case as needed
  }

  DateTime dateTime = DateTime.parse(str);
  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  return formattedTime;
}

List<LatLng>? listaStrToListaLatLng(
  List<dynamic>? listaStr,
  String? latDaListaEmJsonPath,
  String? longDaListaEmJsonPath,
) {
  List<LatLng>? result;

  if (listaStr != null &&
      latDaListaEmJsonPath != null &&
      longDaListaEmJsonPath != null) {
    result = [];

    for (var item in listaStr) {
      var lat = item != null ? item[latDaListaEmJsonPath] : null;
      var lng = item != null ? item[longDaListaEmJsonPath] : null;

      if (lat != null && lng != null) {
        try {
          var latDouble = double.parse(lat.toString());
          var lngDouble = double.parse(lng.toString());
          result.add(LatLng(latDouble, lngDouble));
        } catch (e) {
          // Handle parsing errors if necessary
        }
      } else {
        // If lat or lng is null, add LatLng(0, 0)
        result.add(LatLng(0, 0));
      }
    }
  }

  return result;
}

String? strToData(String? str) {
  if (str == null) {
    return ""; // or handle the null case as needed
  }

  DateTime dateTime = DateTime.parse(str);
  String formattedDate =
      "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(2)}";

  return formattedDate;
}

String? jsonListToStr(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return null;
  }

  // Converte a lista de objetos JSON para uma string JSON
  String jsonString = json.encode(jsonList);

  // Adiciona '\' antes de todos os caracteres '"'
  jsonString = jsonString.replaceAll('"', r'1ryan1');

  // jsonString = jsonString.replaceAll('[', r'2ryan2');
  // jsonString = jsonString.replaceAll(']', r'3ryan3');

  //jsonString = jsonString.replaceAll('{', r'4ryan4');
  //jsonString = jsonString.replaceAll('}', r'5ryan5');

  // Retorna a string JSON modificada
  return jsonString;
}

String? jsonToStr(dynamic jsonData) {
  if (jsonData == null) {
    return null;
  }

  // Verifica se o JSON é uma lista
  if (jsonData is List) {
    // Converte a lista de objetos JSON para uma string JSON
    String jsonString = json.encode(jsonData);

    // Adiciona '\' antes de todos os caracteres '"'
    jsonString = jsonString.replaceAll('"', r'"');

    // Retorna a string JSON modificada
    return jsonString;
  }

  // Verifica se o JSON é um mapa (objeto)
  if (jsonData is Map) {
    // Converte o objeto JSON para uma string JSON
    String jsonString = json.encode(jsonData);

    // Adiciona '\' antes de todos os caracteres '"'
    jsonString = jsonString.replaceAll('"', r'"');

    // Retorna a string JSON modificada
    return jsonString;
  }

  // Retorna null se o JSON não for uma lista nem um objeto
  return null;
}

String? latLngToStr(LatLng? latlng) {
  if (latlng != null) {
    return '${latlng.latitude},${latlng.longitude}';
  } else {
    return null; // or any default value if you want
  }
}

String? separadorLatDeLng(
  bool? isLatitude,
  String? stringComLatLng,
) {
  if (stringComLatLng != null) {
    List<String> latLngList = stringComLatLng.split(',');

    if (isLatitude != null && isLatitude) {
      return latLngList.isNotEmpty ? latLngList[0].trim() : null;
    } else {
      return latLngList.length > 1 ? latLngList[1].trim() : null;
    }
  }

  return null;
}

String? umMaisUm(String? bdNum) {
  if (bdNum == null) {
    // Trate o caso em que bdNum é nulo, se necessário.
    return null;
  }
  bdNum = bdNum.replaceAll('"', r'');
// Converte a String para int e soma 1 ao valor
  bdNum = (int.parse(bdNum) + 1).toString();

// Retorna o valor final
  return bdNum;
}

dynamic montaJsonDeslocamento(
  String? osdesid,
  String? osdesidoserv,
  String? osdesidtec,
  String? osdeslatitudefinal,
  String? osdeslatitudeinicial,
  String? osdeslongitudeinicial,
  String? osdesstatus,
  String? osdesdthrinicio,
  String? osdesdthrfim,
  String? osdeslongitudefinal,
) {
  Map<String, dynamic> json = {
    "osdes_id": osdesid ?? "0",
    "osdes_id_oserv": osdesidoserv ?? "",
    "osdes_id_tec": osdesidtec ?? "",
    "osdes_latitude_final": osdeslatitudefinal ?? "",
    "osdes_latitude_inicial": osdeslatitudeinicial ?? "",
    "osdes_longitude_inicial": osdeslongitudeinicial ?? "",
    "osdes_status": osdesstatus ?? "",
    "osdes_dthr_inicio": osdesdthrinicio ?? "",
    "osdes_dthr_fim": osdesdthrfim ?? "",
    "osdes_longitude_final": osdeslongitudefinal ?? "",
  };

  return json;
}

dynamic editaJsonDeslocamento(
  String? osdeslatitudefinal,
  String? osdeslongitudefinal,
  String? osdesdthrfim,
  dynamic jsonASerEditado,
  String osdesid,
) {
  if (jsonASerEditado is Map<String, dynamic>) {
    // Edita os campos desejados
    osdesid = (int.parse(osdesid) + 1).toString();

    jsonASerEditado["osdes_id"] = osdesid;
    jsonASerEditado["osdes_latitude_final"] = osdeslatitudefinal ?? "";
    jsonASerEditado["osdes_dthr_fim"] = osdesdthrfim ?? "";
    jsonASerEditado["osdes_longitude_final"] = osdeslongitudefinal ?? "";

    // Retorna o JSON modificado
    return jsonASerEditado;
  } else {
    // Retorna null se o JSON não for válido
    return null;
  }
}

String? jsonToStrReplacement(dynamic json1) {
  if (json1 == null) {
    return null;
  }

  // Verifica se o JSON é uma lista
  if (json1 is List) {
    // Converte a lista de objetos JSON para uma string JSON
    String jsonString = json.encode(json1);

    // Adiciona '\' antes de todos os caracteres '"'
    jsonString = jsonString.replaceAll('"', r'1ryan1');

    // Retorna a string JSON modificada
    return jsonString;
  }

  // Verifica se o JSON é um mapa (objeto)
  if (json1 is Map) {
    // Converte o objeto JSON para uma string JSON
    String jsonString = json.encode(json1);

    // Adiciona '\' antes de todos os caracteres '"'
    jsonString = jsonString.replaceAll('"', r'1ryan1');

    // Retorna a string JSON modificada
    return jsonString;
  }

  // Retorna null se o JSON não for uma lista nem um objeto
  return null;
}

List<dynamic>? sortListJson(
  String? sortPath,
  bool? crescente,
  List<dynamic>? listaJson,
  String? termoPesquisa,
) {
  if (sortPath == null || crescente == null || listaJson == null) {
    return null;
  }

  if (termoPesquisa != null) {
    List<String> keys = sortPath.split('.');

    dynamic getValue(Map<String, dynamic> map, List<String> keys) {
      dynamic value = map;
      for (String key in keys) {
        if (value is Map<String, dynamic> && value.containsKey(key)) {
          value = value[key];
        } else {
          return null;
        }
      }
      return value;
    }

    String searchTerm = termoPesquisa.toString();

    List<dynamic>? filteredList = listaJson.where((item) {
      dynamic value = getValue(item, keys);

      String stringValue = value?.toString() ?? "";

      return stringValue.contains(searchTerm);
    }).toList();

    if (crescente) {
      filteredList?.sort((a, b) {
        dynamic aValue = getValue(a, keys);
        dynamic bValue = getValue(b, keys);

        if (aValue is Comparable && bValue is Comparable) {
          return Comparable.compare(aValue, bValue);
        } else {
          return 0;
        }
      });
    }

    return filteredList;
  } else {
    listaJson.sort((a, b) {
      dynamic aValue = a[sortPath];
      dynamic bValue = b[sortPath];

      if (aValue is Comparable && bValue is Comparable) {
        if (aValue is String && bValue is String) {
          return crescente
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        } else {
          return crescente
              ? Comparable.compare(aValue, bValue)
              : Comparable.compare(bValue, aValue);
        }
      } else {
        return 0;
      }
    });

    return listaJson;
  }
}

String? retornaLigacaoEmp(
  List<dynamic>? listaQueContemOTermoNaListaPesquisado,
  List<dynamic>? listaQueEstaLigadaAListaDoTermo,
  String? termoPesquisado,
) {
  if (listaQueContemOTermoNaListaPesquisado == null ||
      listaQueEstaLigadaAListaDoTermo == null ||
      termoPesquisado == null) {
    return null;
  }

  for (var itemNaLista in listaQueContemOTermoNaListaPesquisado) {
    if (itemNaLista.containsKey("emp_nome") &&
        itemNaLista["emp_nome"]
            .toString()
            .toLowerCase()
            .contains(termoPesquisado.toLowerCase())) {
      for (var itemLigadoNaLista in listaQueEstaLigadaAListaDoTermo) {
        if (itemLigadoNaLista.containsKey("os_id_emp") &&
            itemLigadoNaLista["os_id_emp"] == itemNaLista["emp_id"]) {
          return itemLigadoNaLista["os_id"].toString();
        }
      }
    }
  }

  return null;
}

String? retornaLigacaoFaz(
  List<dynamic>? listaQueContemOTermoNaListaPesquisado,
  List<dynamic>? listaQueEstaLigadaAListaDoTermo,
  String? termoPesquisado,
) {
  if (listaQueContemOTermoNaListaPesquisado == null ||
      listaQueEstaLigadaAListaDoTermo == null ||
      termoPesquisado == null) {
    return null;
  }

  for (var itemNaLista in listaQueContemOTermoNaListaPesquisado) {
    if (itemNaLista.containsKey("faz_nome") &&
        itemNaLista["faz_nome"]
            .toString()
            .toLowerCase()
            .contains(termoPesquisado.toLowerCase())) {
      for (var itemLigadoNaLista in listaQueEstaLigadaAListaDoTermo) {
        if (itemLigadoNaLista.containsKey("os_id_faz") &&
            itemLigadoNaLista["os_id_faz"] == itemNaLista["faz_id"]) {
          return itemLigadoNaLista["os_id"].toString();
        }
      }
    }
  }
}
