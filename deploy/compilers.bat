
rem --- local/mygtest                                     [deploy/compilers.bat]
rem [2023-08-05][19:00:00] 001 Kartonagnick PRE
rem ============================================================================
rem ============================================================================

  set "VC08=msvc2008:64:release:static"
  set "VC10=msvc2010:32:debug:static"
  set "VC12=msvc2012:64:release:static"
  set "VC13=msvc2013:32:debug:static"
  set "VC15=msvc2015:64:release:static"
  set "VC17=msvc2017:32:debug:static"
  set "VC19=msvc2019:64:release:static"
  set "VC22=msvc2022:32:debug:static"
  set "VC8=%VC08%;%VC10%;%VC12%;%VC13%;%VC15%;%VC17%;%VC19%;%VC22%"
  set "VC_MODERN=%VC15%;%VC17%;%VC19%;%VC22%"

  set "MG810=mingw810:64:release:static"
  set "MG730=mingw730:32:release:static"
  set "MG720=mingw720:64:release:static"
  set "MG710=mingw710:32:release:static"
  set "MG640=mingw640:64:release:static"
  set "MG630=mingw630:32:release:static"
  set "MG620=mingw620:64:release:static"
  set "MG610=mingw610:64:release:static"
  set "MG540=mingw540:32:release:static"
  set "MG530=mingw530:64:release:static"
  set "MG520=mingw520:32:release:static"
  set "MG510=mingw510:64:release:static"
  set "MG494=mingw494:32:release:static"
  set "MG493=mingw493:64:release:static"
  set "MG492=mingw492:32:release:static"
  set "MG491=mingw491:64:release:static"
  set "MG490=mingw490:32:release:static"
  set "MG485=mingw485:64:release:static"
  set "MG484=mingw484:32:release:static"
  set "MG483=mingw483:64:release:static"
  set "MG482=mingw482:32:release:static"
  set "MG481=mingw481:64:release:static"

  set "MG_OLD=mingw481;mingw482;mingw483;mingw484;mingw485;mingw490;mingw491;mingw492;mingw494"
  set "MG_MID=mingw510;mingw520;mingw530;mingw540"
  set "MG_NED=mingw610;mingw620;mingw630;mingw640"
  set "MG_NEW=mingw710;mingw720;mingw730;mingw810"

  set "MG22=%MG810%;%MG730%;%MG720%;%MG710%;%MG640%;%MG630%;%MG620%;%MG610%;%MG540%;%MG530%;%MG520%;%MG510%;%MG494%;%MG493%;%MG492%;%MG491%;%MG490%;%MG485%;%MG484%;%MG483%;%MG482%;%MG481%"
  set "MG6=%MG810%;%MG630%;%MG530%;%MG493%;%MG485%;%MG481%"

  set "VERY_FAST_MODERN=%VC_MODERN%;%MG6%" 
  set "VERY_FAST=%VC8%;%MG6%" 
  set "FAST=%VC8%;%MG22%" 
