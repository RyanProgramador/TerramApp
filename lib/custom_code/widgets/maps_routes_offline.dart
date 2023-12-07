// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_polyline_points/flutter_polyline_points.dart' as poly;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:custom_marker/marker_icon.dart' as cust;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

class MapsRoutesOffline extends StatefulWidget {
  const MapsRoutesOffline({
    Key? key,
    this.width,
    this.height,
    required this.coordenadasIniciais,
    required this.coordenadasFinais,
    this.json2,
    this.stringDoRotas,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng? coordenadasIniciais;
  final LatLng coordenadasFinais;
  final String? json2;
  final String? stringDoRotas;
  final String customIconUrl =
      'https://lh3.googleusercontent.com/u/9/drive-viewer/AK7aPaD4V4OUOT1q2oukdiVXFD-_sP6u4FeZRmV9RxR7CRR8Oi9Ga237m_3yoSHbXNRqx4JvQW1PmOUtuHYdk-71UYL-DjQZEw=w1278-h913';

  @override
  _MapsRoutesOfflineState createState() => _MapsRoutesOfflineState();
}

class _MapsRoutesOfflineState extends State<MapsRoutesOffline> {
  Uint8List? customIconBytes;

  //para polylines
  List<google_maps.LatLng> routePoints = [];

  Set<google_maps.Marker> _createRouteFromSteps(List<dynamic> steps) {
    Set<google_maps.Marker> routeMarkers = Set();
    List<google_maps.LatLng> routeCoordinates = [];

    for (var step in steps) {
      var startLocation = (step['start_location'] as Map<String, dynamic>);
      var endLocation = (step['end_location'] as Map<String, dynamic>);

      var startLatLng = google_maps.LatLng(
        startLocation['lat'] as double,
        startLocation['lng'] as double,
      );
      var endLatLng = google_maps.LatLng(
        endLocation['lat'] as double,
        endLocation['lng'] as double,
      );

      routeCoordinates.add(startLatLng);

      // Adicione apenas as coordenadas intermediárias
      if (routeCoordinates.length > 1) {
        routeCoordinates.removeLast();
      }

      //Adicione marcadores para as localizações iniciais e finais de cada etapa
      routeMarkers.add(
        google_maps.Marker(
          markerId: google_maps.MarkerId(
              'MarkerID-Start-${startLatLng.latitude}-${startLatLng.longitude}'),
          position: startLatLng,
          visible: false,
          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueGreen,
          ),
        ),
      );
      routeMarkers.add(
        google_maps.Marker(
          markerId: google_maps.MarkerId(
              'MarkerID-End-${endLatLng.latitude}-${endLatLng.longitude}'),
          position: endLatLng,
          visible: false,
          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
            google_maps.BitmapDescriptor.hueRed,
          ),
        ),
      );
    }

    return routeMarkers;
  }

  Future<void> _loadCustomIcon() async {
    if (widget.customIconUrl != null && widget.customIconUrl!.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(widget.customIconUrl!));
        if (response.statusCode == 200) {
          setState(() {
            customIconBytes = response.bodyBytes;
          });
        } else {
          print(
              "Failed to load custom icon. Status code: ${response.statusCode}");
        }
      } catch (e) {
        print("Error loading custom icon: $e");
      }
    }
  }

//desenha a rota no mapa
  void addRoutePoints() {
    var polylinesRed = widget.stringDoRotas;
    var polylinesRed =
        r'zwquDrcnwHAThNf@KlCAbBhCi@ZFf@ErDy@zEsAbDu@TE~@]hKqC\\pB_AtZC|Ag@|L?`BMT?VDLMxBSfH_@zGoDhc@SzBCrAB~@BZNv@hB`Fr@t@Tn@NfAHvAw@xGw@fIUpDk@vQMxFc@jII`@Gp@c@zC{BdM_@jBMh@Sh@q@hA[^o@h@oBrAW^mDrBsh@z[eBjAwAtAsA~Aw@lAsKdS_ApAo@t@qAhAw@j@mB`A_A^_Bb@qAXuBRoB@yFQcJe@kVuAcGg@{EcAyAa@{L{FcUeL{NoH_JmE}ImEsFqCaAk@k@k@U[Uw@Cm@Fm@Rk@Xc@`@Wp@Mj@BTF\\PXVR^Lh@@TEjABRMf@cAzFUpAq@rCy@hCcAfCgAtB_AzAcArAeAnA}D|DaJ|HcEhDyAvAkAvAwCvE_AtAy@dAu@z@}BtBiBnA}ExBuE`B}ObFuBp@_A`@_ErAuC~AkAt@mBxAqBdBgAjA{ArBc@n@iBdDqArCgFfMoAzC}CpGo@`AgA|AuDvD_BtAeCvA}H~DyAl@}DtBmEfCyAdAyCfCyB`Ci@n@cAvAmAlBkE|Hq@bBg@vAuBvLyEtVwAnFKn@@HQdAg@rD?T}DjS_BtGgBlGmBzFgE`LQPs@nB}@pCaAxDy@`Eg@dDi@hFu@rLgAdQ[`Do@|E}@rFgB`H{BjHc@fA?PsCtG}E|JwY~m@aFhK}DxJ}B~GoAhEkApEMRcAbFsAvHw@~Fe@`Ea@~E@ZwH~hAs@zKIR}@tK[hCYbB}@pD_@hAoKfYgAlDaAtDaArEm@dEi@fFkArNo@`PaBdZ{Bf^M|CWfKBhCPhJ\\pGBbBA~A_@hI[rDkAvK_@xHCjF?jISlGKrAm@bEoA`IaA~DyBbHm@~B]fBe@jDSfBQbCKfEJzFb@rFr@~FJfAJrBL|EAjDOtEi@pGUhDOlGGjH@l@TtDv@tFh@`D^|AbAhD`CdHx@tCXlAz@tEjBvMNdBL`DFpGI|Dc@nKcAxOI`DAlDBlCNlDRjCFR`@~Dj@rEZjBlAxFhB|Ht@lEh@lETzCPxDJbIGhGq@vJKZm@zCQz@O\\Qz@Cf@i@pDMr@C\\e@xBu@xCeA~Eq@fFS|BYbEQtFCrDDzCJvB~A~UPfFJ|ECzCObDCfAYjEwG|k@_@jEKzBKb@]jEAjAGf@Ev@FxAJ~@TxEFVHnFE~DOlES|Cq@vFm@fDe@jBORk@`BaEnJw@rBi@fAuA~B_ArAc@f@uBjBkD~BuAdAe@TaBhAiAh@uAbAsBnAsAbAwAtAcC`Du@lA{@rB{@fCy@dDQ|@s@rFcAnJ_@jCq@tCi@nB[`AuA`DqCdF{BtECNmBlCo@v@_AbB{@nB_ArCs@vDMlAI`AE|AOxTQlDa@hEa@jCm@fCu@lCw@rBsAtCoBxCy@jAeCrC}LdLaCpBkDnDqAlBq@rAcAbC{@~C[tAk@nEc@hEm@lDaA`D[z@{@tBq@rAaA`BwHrI}@tAy@|Aw@nBcAlDa@nAi@jA{@zAaB~BcB~AwIfJkEzEoClDqB~CkBnD_BxDmAnDaApDg@dCMVwAfFe@rCo@tE?Pe@vBgArDiC~GgB`EiDrI}AbFo@`Cu@bDmA`H}BbNy@zDsCzJcBrEyB`FqAdCwBtDaCjD_CvCg[j_@}HlJkA|A_A~@s@~@_@`@eFnGqBhC{A`C}@|Aq@zAm@zAgA~Cc@vAkAdFe@bCMx@CbAYlCg@pCAVa@lA}@~B_AfBiAxAk@n@{AvAiAr@}@d@mAh@kA^cCd@oHfA{A`@mAd@k@Xk@b@mBjBo@z@aAtBW|@Ot@]jCMxAs@xROjCUlHOjDSzBk@xCg@rBKNuBfEu@jAgB`Cm@p@eE~DoEdF_JdKaBpBSf@gO|P{BfDwBrDa@h@iAzCaAtCyCdMc@jBe@tAqBlEI`@s@fAiCfDqCfC_C`BkAl@cDxAWHU?eCl@kJbBmDbAURoGhBmFhCaDjBgDfCuBnBwF~FuOtR[NeMfOgQrTgCvC_C|BaChBgAn@}CzAwExAoNfCeBh@{DnBcDlD_@b@qC`F}@|C[|AET_@dByCjKc@xBa@rCIp@UfFUrIIZUrIGpDa@dIQ|CS`JItAEjC?|AErFAbBSjM@~AF`DRfD~ApQN~C@`BCvAYrCe@~Bw@fC}@rB_BvCgBbCqExFoCfDqD~EiAtA]h@_J|LaBfBeAjA{@tAkAdCa@nAe@lBO|@K\\oCjQmCtQ_CxNwBtNaCbOcAtHwAnIkFz]]hBcArDmA|Cw@~A_BrCcAtAs@x@sAjAs@j@uD~B{ElCoDvBoChBo@j@aCdCaAnAmYva@kBxBuBvBmAfAgCpBgBjAoCxAaDzAeBn@eEpAqDlA_Br@oDfBuCjBuEdD_CvBeErEqDtDiCxCiBfCwOlWgBfCwBzBuFpFaEbEyL~OiIzKaCnDiB~CgBtDy@vBcA|CeA|DkDjPs@lCg@xA_CfFsAzBeApAmAjA}@v@uClB{FdDu@d@eAv@wArAmApAqB`CeD`DiAz@oBlAgAn@wB|@uAf@yDfA_FpAwDhAyCjA_D|AoDzBeCnBqBlBmBrAyAz@cAd@yBt@eCn@wCb@gCNsCDiDOaQeBgBK{A?eAFuB^{@Rw@Vw@^wAz@oAdAqAzAa@n@u@|Ao@hBm@hC[vBm@zF[fBWhAo@lBcAxBo@hAqA`B{AxAqAbBq@lAo@|A_AhC{@nDSdA_BpLWzBM~AK`CAnIDjKCrFClBU~CYxBe@dC_AhDiArCc@bAaBhCu@hAyB~B}BfBkFrDqAz@}AjAsCnByAfAcEnDqEbF[^iAhA_@V}@bA_AzAaAdBqAtCYn@m@pBc@hAgAdD_AzBe@t@gAnAu@p@q@^mAf@sAX{AH_AEw@Km@KkGoBgAUw@GuBBaB\\gA`@}@h@aAv@w@|@kCjDwCtCwAhBuBrDuAjCgAfCwDbK]fAq@bDo@pD}@fG[hBaBzGaAvC{@|B}BfFoEbJuAzCkE~H_MtRu@nAuLrQ_CbDSZe@d@q@dAgBpBiFdFiDrCiEjDaAz@oArAcC~CaCbEy@nBg@pAg@~Ay@jDe@tBk@bD_@hDe@tEi@|CW~@]|A}@tCeCnFqAjCgAtCo@zBYtASfAQrASxCKxCSpJQpEKpA]~C{@nG_@~Ac@tAe@nA_ApBuAfC{DtGsC~GkAvDuCrKoAxDaA|BaAhBoBtC{AdBaGjGuBnCaDtEcBvCm@lAy@vB_DvJ{@tEYpBmBpKgAhHqArJa@~AaAjCsApC}@~AyE|G{AnBeBhCiAdCq@lBs@jCsDlPeAtDkAbDmAlCsAjCaBbCiBvB}ChDsH`IeCzBiEzCgDlBqIlE_DvAaAj@iErBiCzAcCvBeZhVcCxBgEbEuI~IgCtCwAzBeBpDy@`Cy@xCc@tBg@nD}@hHg@dD]zAc@vA{@vBsAbC]f@wLjOoBbBgChB_CbAsC~@_Ch@yD`AgAf@oAp@}@j@iBxA{GdHgAdAqB|AwCfBeCdAuC~@qLfCkMvBqAZaDf@yDz@eB\\cA^s@ZuFrDaMvHmAx@}@z@qA|Ag@t@c@v@sAdDmAjCyApB{AbB]\\cAv@yAx@_A`@cA\\gB`@yARkGb@aBBuFj@}GfAcTvDuCpAwCbBwBpA_FnCgBn@cB`@{B\\aBLaA@eAE_BOgJ{AwAWwBc@_IcAuMiA_E[gA?iEOeCE{CBcDLmBJyD^yEt@mDn@aEdAuItCmA\\eB^mDd@kHf@gAFeIn@aBRaEx@qK`CuAb@qB~@_@VeBrA_A`AeAtA_A`By@nBmChHkDbKsEhMcAvCcBtEiAbC_GpLmBbDwFhKmBjEcD`Is@rBu@pCiBdGeAzDUd@{BdHo@`CcBzGyBlI_AnDu@nCQb@Mj@?h@DL{@dCyDnJo@fBi@pB_ApE{@pE[jAgA|C}@`Bq@~@oCtCwDrDgBlBw@nAuAnCMt@eAxD_@vB{BpWo@lH]nDSxAm@`Dq@dCgAbDyCtHqHnQ}AbD{CnFm@jAm@|@y@vAsB|Ca@`@m@x@SNa@d@w@r@w@l@_CvBeDlCo@d@eEbCsCtAqHnCeBl@oHpCsGtCq@TcARsCTeAPi@Ru@h@iAdAiAp@q@TcALwDx@oA^yAh@qC~AmAfAu@`Au@rAkN|P}@~@kGxHwE|FeCvCuC~D}HdLwF|H}BrCe@b@yAnA{A~@qAf@sExA_HhBuBl@cIrCmAVmBTi@BaBAcBMkAQ{Bc@cDi@{B[gAIw@?q@BiALcAZk@T}@h@}@r@o@x@q@fA[v@c@dBYbCCb@?nDEbEE~AO`BIj@a@pAqAxCo@zAYx@[fAgAhFk@lCa@rAa@~@U`@}@jAm@h@aAl@c@VqA^w@JoBFgE@gAHcARu@V]P_@VaAjA{@vA_BjC_B`Cs@t@o@`@iA`@o@Ns@FmAAcCWcBUeAEo@Bw@JeA`@o@`@g@f@u@bA[v@_DnKk@bBc@~@c@p@o@h@m@V}@PgA@u@Mo@UiDiBw@[c@Mo@Kk@EqA@u@JeAZu@`@}AnAgJfJeBtAoA|@_GrDkAl@_Bp@wK|C_PnEeDjAyBbA{KpFiCdAuDhAqAZoCh@mXzDuCp@iCz@qBz@sBhAcBhA{@p@qCrCgApA_BzBk@`AoAbCiAfBaAnAcAbAgA|@}@j@iExB_Aj@yArAiAzA]j@e@dAk@pB[~A]lDi@xF]bCa@jBmEnQqBxHSxAMhB@rABh@ZpCRnAJvB@fAIfAIn@Op@i@nB_JvWOf@q@`By@|A_ApA_AfAs@r@q@f@}BtAk@V{Ah@w@R}ATqAL}Nl@aOp@kDZkCf@oA\\gBj@qQfFcFrAeBZsANsAHiCAmAG}B_@eA[{By@w@]{SiIkA_@eAUeAOgAE_B?_BHkANw@LuBv@oBdAkGtEyC`CeCbBaC`CaAdBa@|@{@vCK`@w@nIY~Ae@`Bk@dA}@hAiAbAwB|Aq@p@oCxDqCnEiBhDcBjCsAvAyB`BcBx@{C|@yNhCkATiA^s@`@sA|@}AdB_A~A[p@}B|FyAhD[p@gBlCwA~A_OjOcAjAs@~@w@nAeApBa@~@oApDgDtHkAbCsA~BaAlA{EfF}@hAgAfB[p@g@nAeCpIOTkCzH{@|A_ArAGP}@`As@l@qBfAkIdDyAr@sA~@s@\\wBr@{NnCcB`@sBr@wB|@uAt@uE|CgUrPkAbA}@~@wAnBcAhBmA`DU`AYvA]bCYzCWpB_ArDe@vBM~@EP[zEc@zCi@`C]lAyAvD]r@I`@k@pAe@t@yGlHs@r@iBrAcB~@oBv@oBb@sAR_CNwA@sDSiFaAkNcDKK}DwAuPsDO?qBi@iC{@{CqAoCyAuCyBcBwAuBsBaCqBi@a@yC}A}Bu@kLuCmCi@sDSoE@sNZsCHcBRkCn@{@Xs@\\kC`BcCbBaBpAcA`As@hA[|@Ml@OjBA|@VnCz@lFn@|CnB|FlBhEvD`H~@`BRb@n@pBPjABlAQjCKt@]lAkApC{DvI_A~A}@z@kAv@uAn@w@TkARmBDeAAcAO_Be@qKiEaD_Ak@My@KeBMqAAwADqBR}B\\sIrCmIxCsBp@sAz@mAhAo@~@q@zAyEtO_BjG]`Ao@pAm@x@{@z@aAjAYb@O`@Kb@MfBCzBSpASf@Y^g@ZsAZ{BAcAE{@?uAJaEhA}@VcAf@_@VsAtAe@`@]P[H{@Dc@?c@Ey@a@sC_Cg@Qs@ImCEs@Io@UaB{@}Ao@YEaA@Q@q@T]Tc@d@wA|BoBrEaAfBsArA_@Z_Bj@}FdBmDv@eALyD?_AF_ARUHe@Za@b@c@h@cFhJgA`Ae@Ta@HcAFuAEyBK_ABc@Fg@Nq@`@s@r@mBbCy@|@]XaFtBoAp@gI|Fo@`@y@b@q@XeAZmEjA_Ab@y@n@m@p@q@fAk@xA{AdF}BbFg@zAK\\YpBw@nKS`BIb@Qf@i@hA[f@e@h@}AhAiBbAoAn@yA`A{BlBMDkBdB{DjCi@ZcAZKDcDh@_AX_@NmAv@a@`@a@h@Yf@g@xAQdAIt@C|@@pAJzDR~AR~@Rj@nAxBjArB`@bAR`AFn@DxACbD@v@Bv@PdA`@pAXh@pBdDr@lBPnADdAApAQtB[rBOh@Qf@m@fA_@f@m@f@cAj@s@XoBl@iAN{@Bm@Co@Kk@Qk@W}AeA{AcA{@a@s@Ue@Gq@CgADgAPcCb@uA^c@Tg@\\u@x@i@~@iAtC_AhCm@hAy@~@wCfCsCbDyFxIg@h@[Vm@`@e@ToA\\oDn@m@T{@f@_Ax@cB`B_Aj@eA^uAVqGb@_B^_A^u@n@w@z@Wf@[fAMh@StCE~@m@lDa@fAm@tAaAvA}CxDo@t@yArAeBlAkAn@iAh@gCp@sAVyALaHPyHJmBBkAHs@Py@b@m@d@c@l@yA`CYXq@Xu@F_@?e@IeC{@cAKm@@e@Hq@Ze@^c@l@Sb@On@Ej@?bAFx@~@pKJvCArAIl@Sr@GPk@~@o@p@y@l@eD`BgAz@cBbCiBrCeAhAm@b@aA`@_ARaAFaFAsAJqAZq@TS@gAj@q@j@w@bAgAfBuBrDo@z@{@|@aAp@cAd@eB`@}AP}CFwGLcCCyB_@aBs@_Ao@YYq@}@i@{@m@sAcFoNcDsJy@_Bo@cAw@cAo@s@mEyDm@_@eA[o@Is@@eALg[fGo@NmA`@{@b@oAz@uA|A{B`DsA~BaB~By@t@_Ah@i@T{AZoFd@q@NcAd@u@h@o@p@_@h@_CdEi@n@g@b@m@Z}@VgALeA@s@I{@UyAw@wAkAyDcCsAm@oA]gBYyAIeC?_CNyB\\_B`@mDnA{@^uJhFmBt@yIjCqAf@{@f@cA|@y@`AoBvCu@z@e@b@u@b@u@T_ANgBDqB@gAJwAd@u@h@k@t@a@t@Ut@SnAMnBK~BSbBWnAg@~Aa@bA{CvF]p@eAlBa@|@Md@]dBOpACpACtALdJ@~AK|BGj@k@xBsBdFgAxBaA~A}FdI{CvEyHrKk@dASj@eBfHm@|Ae@p@y@x@k@\\_@N_Bd@wCh@eBj@cAj@mAhAuDfEoCpC_G`F{FvEwHpGuK`JaDpCkCfBcB|@cDrAgA^mANo@@q@Ay@KoAWwBs@gAWsASwACo@DkANmA\\mDtBmNhJ_CnAmDtA}HhCyHpCgB|@gC|BgCzCkJrLcB~AsAr@u@RgBDgDOyBSsE[_FCiC?wBAmCRcCZ_Cn@eA\\{An@qBhAiErC{B`BqChBy@p@oAlA}AdBaBzB_AjByBbFy@nB_AhBoAlBq@|@uApAqCrBk@f@_@f@[j@Yv@cAnE_AtCc@`AmAxBWb@iBnBuAhAwDnCeA|@e@j@m@`Ac@jAWxAKhB@|ALnCE|BQzAq@`EO~BC|@MzBOpASx@e@fA{@fAk@`@w@^i@NiF|@mCn@aA`@a@T}AnAaE`EaBhAiBt@w@TiCj@yBn@g@Ty@f@a@`@o@x@c@t@y@~B[fAs@xCW`BOhBm@nFg@dCs@nCaG`Tm@pAa@j@iS`TeAdBo@lAYr@m@rBi@jCMv@OvB_@rMa@lQQbEIj@UdASr@Wf@y@hAYVg@^i@Z{Af@kBh@gBl@gAl@cAt@sAlAu@`AaCnDkA|AkBvBmB`BeE~CwExCoBvAy@t@_AlAq@hAm@rA}AlEgA`C}A~B}@bAu@v@kItGuBrBuAdB_BfCi@dAmC`HkApBk@n@kA|@UPsAn@s@T_ARkBJiA?yCMmKk@sCG{DDeCHg@Dy@LyBNy]bF{JrAqFv@_IbBiZtIkRpF{D`AgEz@oIhAuCTwA?iAE}ASkAUwEqAmAY_C[gCKcB@}BNkC`@{Bl@ia@`MwBf@_BVaCP_CBqPWqFG}B?oBFaDXmIbAaB`@mBp@eCnAyE|C}BnA_Bp@uC~@gFhAoIdBqVxEeD|@mCbAmB~@wChBugAvv@kDtCoCnCeCxCcHbJwB~BsBhBaG~D_Ax@eAdAiA|AQNs@nAGTo@zAk@lBk@nCYtAeAbEw@hB{@~Aa@l@_BjBsAjAsMlJy@f@oB|@sA`@eBZsFp@wB`@w@VkAp@y@n@eA`Aq@|@aAdBi@zA}@rD]tA[fAcA|B_CbEu@~A}@fCi@`C]tCWlFKpCQjB[fBYnAk@dBq@|Au@rA{@lAyA`BqMzK}IrHoCjCoB~BgBhCiHnKkD`FqClDiR|TeCxCcDnD}JrLgJnKoDdDcGvEwEdDm@^eAh@kAh@_AZaBb@sB^kHv@_C\\{Bh@}Bt@aMhEgEfA{Cl@{B\\cDZeCJ_Ub@kAHaCb@mDfAyLbEqHjCmBn@uBd@wARqCJeLLgDJ}APmATyA`@{BbA{@f@uObLgAh@oDfCgCzB}A~Ak@t@{BbDETqArB{@xAqAnC}BnFaNd]sCbHiClHs@~BgDbMcEvN{@lC_B`E{CnGi@r@g@r@uAdBWd@y@pC{@rBEP}HlOmMbW{L~UcDrGmBbE{@vBu@rBuB|GwGzUsAdEsAhDcAxBsBtDeCtDwCpDe[j_@eE~EoF~GyDlFyFvIyEdI}EjJ{MxW]l@aBzBiBlBaCjB{@h@uBdA_Bh@uLtDmAb@uBhAqBtA_Ax@_AbAkAzAa@l@iE|HwCrFuBrDwApBo@v@oCrC{BfBeAn@kAl@cBn@m@ZiBn@cBd@wCp@yBVsBL{@BkF?kJHiDRqANsARkH|AoAPeAJ{AJcBDcEMaBSiDq@aCy@qMsGkI}DuBu@gB[{@KsCKoBBaBPwB^kBn@_Ab@wBtAw@n@aA~@gB~BqCjFeCpEsJhPuOnWiE~GmNtUeAtAcAhA_Az@o@f@kC~AmGlDwP~IqTnLqDjBsBlAmCpAaBj@iAVgARy@HmAFyA@mAEmBSmG_A}AMuAA{ABwAHyATeCp@}@^w@`@}AbAiA~@}@|@_IxIgV`Xw@r@iD`C{Az@kB|@uGlCsAn@iC`BkA|@eBbB}AhBs@`A_BjCgFjJsB|C}ApBkDrDgKlJy@~@kBlC}@bB}@xBq@vBmApEkDnN{@xCg@vAk@lAc@z@gBlCiBvBuIhIcBjAaCrAqBx@qBn@oB^_BTyCP}GX{DH{CEkBOy@KcN_CqCQeBAwADwALmCf@m@PwB|@mBdAgA|@u@t@sAfByA`C{HhNsDlG_BvCeBzC{AhD_AbCiAzDsEbR{B~IWf@u@fCa@~@}@jBo@`A}BpCIVmP~NmIpHcBpAoBpAw@b@wB~@yC`AcIfBwIdByHdBkCh@oDh@mFn@_FXwT|@sN^_Mf@}BRuEr@{D`@{C@eBImFk@mBGoAB_ALmA\\{Ax@aE`CmAl@}Bv@cCl@oB\\kBNyBHaCCoD[{Em@{CScWk@gDMyGMeAG}BWyH{AoKuBoBUeCOsCC_TPyG?uCIuDUiDa@gFgAkBg@qAc@wEqBsK}F_MiHgIsEwAo@wCgAgBe@aCg@uBYgCOaGKeIEuKOcKMyGEqFOy@IqB]}Bi@mBs@cCqAqA}@wOgNcGmFu@i@sAu@sBy@eCo@uC]ePy@qESuDWcDm@iCu@{Ao@uRqL_@{@_@m@eBgB}AoAmBqAeBaAaDuAmDw@]Ia@?gA]iN_H{B_AoI}D{\\qO_]qO}C_BmBoAgHaGeNiLgH{Fg@a@oAy@kCsAkKwD{I{C}KaEeBg@wBe@eGo@aFg@wEYgK}@mMkAkReByDo@kQ}CkBQqAGqAA_CFyAJkBXqM~CwCr@kDv@qJ`C}Bb@wBR{A@{BEgBSmBe@_A[yAo@gE{BwYgPgD_B_C{@uC}@oSoFgEqA{QgF[GoBoAG?KKaCMG@qL_DcCw@w@]cBcAw@i@eDuCkBmByWuVkCaCwEoEkBcBmCeBoAg@oC{@qEiAeHqAmAMkEO{ODkRBoH_@uCe@_j@{F_JgAmFa@mI[yK[yEW}CKcHO}MY}_@gAiCGyA?yP^}INcJRcPXeRd@_HLaKT}AA}AGe@E{AYqAYqC}@oEkByNwFcA]kBc@gX}EgUcEsB[wA]gCaAoAq@uA_Aw@s@q@o@{AsB{S{ZyUk]kHgKuIsMsMuRiAgBwAqBqB}Bo@k@w@k@gBcA}CkAyBc@cZaF{g@mJ_Cg@oBm@wHkCsEmAkOsE_FkAkBs@sBiAqAaAyAyAiA{AcPcUaA{A{RkXwMgR}CgEeEcGgC}CcB}AiBuAmK}G{PyKaVuOoK}G{VyOoRuLqKsGeC_B}Ay@}Ak@cDu@mC[_BGqAB{VvAiEHaAG_Em@cCq@}BeA_EqBuSeJyAw@}h@cVw@_@gAq@}KeIsG{EsKmIm@a@Yn@[]i@a@QbBOfAIX{@dBa@n@{CdEqArAuAhAkDlC{BvBQd@KfAAh@@dAGhAKn@{BjJa@jA{HpNgCpF{@zAqAjBYD_@OYOYWeAkBkAj@}A`A{@z@OPO^SjA}@`HMxAMr@IRKL]NaEb@}Cd@q@FyDCiEPo@Lg@PSLgA|@YRWJoB\\_AFaFJyA?yEWkED_DA{D^{AP_BKgAAmAJiGr@oCFqAIwGq@{Bo@oAg@aAm@{@[_Cm@wAIyEGgK@eCMkBKcAFs@PcAd@aFbDsAfA_CrBsAfBaC`Ec@`A[vA[lBg@lAc@p@_Ax@m@`@{Ap@sA\\sDf@oCHcBIsDu@oD_AsFy@oAImBAc@IeCgAi@_@WU[E}BGqBJyBReAPyA`@k@XwAjA[RwAeIQa@i@w@aAiAu@s@a@m@Oe@SoBC}AD_Bd@sCTs@DIfA`@L@j@f@H^';
    if (polylinesRed != null) {
      List<poly.PointLatLng> decodedPolylinePoints =
          poly.PolylinePoints().decodePolyline(polylinesRed);

      for (poly.PointLatLng point in decodedPolylinePoints) {
        routePoints.add(google_maps.LatLng(point.latitude, point.longitude));
      }
      print(
          "Route Points: $routePoints"); // Adicione este log para verificar a lista
      setState(() {});
    } else {
      var polylinesRed =
          'zwquDrcnwH`@qPFkBhNj@HiEL}DtB{FTk@bHgCjCeAnBi@hDi@|HkAn@}SrCc@jAUXKx@e@f@_@d@i@f@aA|AcGHs@Bm@I_Ai@wD?]m@}EAUBg@@aBiADkANoCLoJJgCHaHJsCD}BEgNi@v@aZ\\sKDgBN_HN_HZsG@]PKFUCUSUWEOFwCQGY?KDE~BLNADCDIAKGEs@@sGUg@PyG_@';
      List<poly.PointLatLng> decodedPolylinePoints =
          poly.PolylinePoints().decodePolyline(polylinesRed);

      for (poly.PointLatLng point in decodedPolylinePoints) {
        routePoints.add(google_maps.LatLng(point.latitude, point.longitude));
      }
      print(
          "Route Points: $routePoints"); // Adicione este log para verificar a lista
      setState(() {});
    }
  }

  Set<google_maps.Marker> _createCustomMarker() {
    Set<google_maps.Marker> customMarkers = Set();

    var customMarkerLatLng = google_maps.LatLng(
      widget.coordenadasIniciais?.latitude ?? 0.0,
      widget.coordenadasIniciais?.longitude ?? 0.0,
    );
    //nao sei mas acho que é o polylines
    customMarkers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId('CustomMarkerID'),
        position: customMarkerLatLng,
        icon: customIconBytes != null
            ? google_maps.BitmapDescriptor.fromBytes(customIconBytes!)
            : google_maps.BitmapDescriptor.defaultMarkerWithHue(
                google_maps.BitmapDescriptor.hueBlue,
              ), // Call a separate function to get the custom icon.
      ),
    );

    return customMarkers;
  }

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    addRoutePoints();
  }

  @override
  Widget build(BuildContext context) {
    var response = json.decode(widget.json2 ?? '');

    List<dynamic> steps = (response['routes'] as List?)?[0]['legs']?[0]['steps']
            as List<dynamic>? ??
        [];

    var finalLatLng = google_maps.LatLng(
      (response['routes'] as List?)?[0]['legs']?[0]['end_location']?['lat']
              as double? ??
          0.0,
      (response['routes'] as List?)?[0]['legs']?[0]['end_location']?['lng']
              as double? ??
          0.0,
    );

    var inidtialLatLng = google_maps.LatLng(
      (response['routes'] as List?)?[0]['legs']?[0]['start_location']?['lat']
              as double? ??
          0.0,
      (response['routes'] as List?)?[0]['legs']?[0]['start_location']?['lng']
              as double? ??
          0.0,
    );
    Set<google_maps.Marker> routeMarkers = _createRouteFromSteps(steps);
    // Adicione um marcador no final da rota usando as coordenadas finais
    routeMarkers.add(
      google_maps.Marker(
        markerId: google_maps.MarkerId(
            'MarkerID-Fim-${coordenadasFinais.latitude}-${coordenadasFinais.longitude}'),
        position: google_maps.LatLng(
          coordenadasFinais.latitude,
          coordenadasFinais.longitude,
        ),
        icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(
          google_maps.BitmapDescriptor.hueRed,
        ),
      ),
    );
    Set<google_maps.Marker> allMarkers =
        routeMarkers.union(_createCustomMarker());

    return Container(
      width: widget.width ?? 250.0,
      height: widget.height ?? 250.0,
      child: google_maps.GoogleMap(
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
            widget.coordenadasIniciais?.latitude ?? inidtialLatLng.latitude,
            widget.coordenadasIniciais?.longitude ?? inidtialLatLng.longitude,
          ),
          zoom: 13,
        ),
        markers: allMarkers,
        polylines: {
          google_maps.Polyline(
            //polylineId: google_maps.PolylineId("PolylineID"),
            //color: Colors.blue,
            //points: routeMarkers
            //    .map((marker) => marker.position)
            //    .toList(), // Utilizando as posições dos marcadores para criar a polilinha
            polylineId: google_maps.PolylineId("RedPolyline"),
            color: Colors.blue,
            points: routePoints ??
                routeMarkers.map((marker) => marker.position).toList(),
          ),
        },
      ),
    );
  }
}
