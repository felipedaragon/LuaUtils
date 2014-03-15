# LuaUtils #

LuaUtils contains useful functions to work with Lua 5.1 in Delphi.

It was developed by Toshiki Kumagai in 2004, later revised by Jean-Fran輟is Goulet & Massimo Magnano. This latest 2013 revision makes the code compatible with Delphi XE3.

プログラミング言語 Lua(http://www.lua.org/) を Delphi から使える
ようにします。

## Files #

`LuaLib.pas` - Translated Delphi unit from C header lualib.h
`lauxlib.pas` - Translated Delphi unit from C header lauxlib.h
`LuaUtils.pas` - Library for build samples

## History #

### 0.x #

* v0.01	2004/04/20 kuma@webj.net
 * initial release
* v0.02	2004/04/20 kuma@webj.net
 * LuaUtils: added LuaLocalToStrings lua_getstack
* v0.03	2004/04/28 kuma@webj.net
 * can the sample4 able to be compiled also with Delphi6 Personal
* v0.04	2004/09/02 kuma@webj.net
 * multi file debugger
 * added regex
 * LuaUtils: added LuaToBoolean, LuaPushBoolean, LuaToInteger, LuaPushInteger
   LuaSetTableValue, LuaRawSetTableValue, LuaRegisterCustom,
   LuaRegisterMetatable, LuaRegisterProperty
* v0.05	2004/09/04 kuma@webj.net
 * debugger bug fix
* v0.06	2004/09/19 kuma@webj.net
 * debugger bug fix
 * added Execute, SaveAll, CloseAll, CanCloseAll
 * LuaUtils: LuaToString, LuaPushString, LuaError, LuaErrorFmt
* v0.07	2004/10/03 kuma@webj.net
 * added appli, debugger
 * bug fix regex
* v0.08	2005/04/20 max.maxm@tiscali.it
 * LuaUtils: add LuaPushVariant, LuaToVariant, LuaLoadBufferFromFile
 * solved bugs LuaToInteger Round -> Trunc
* v0.09	2005/06/23 kuma@webj.net
 * regex use TRegExpr.pas
 * SJIS patch 06/20/05(Copyright SowwaRay) applied.
 * Bugs: Stack problem in LuaProcessTableName.
   MaxM reported, but I can't reproduce it yet.

### 1.x #

* v1.0 2005 MaxM
 * LuaUtils: added LuaPushVariant, LuaToVariant, LuaGetTableInteger,
   LuaGet\SetTableTMethod, LuaLoadBufferFromFile
  * Solved Bugs: Stack problem in LuaProcessTableName, LuaToInteger why
   Round?, Trunc is better
* v1.1 2005 MaxM
 * LuaUtils: added LuaPCallFunction
* v1.2 2005 MaxM
 * LuaUtils: added GetCurrentFuncName, LuaSetTablePropertyFuncs
* v1.2-mod 2013 FDaragon
 * Updated for Delphi XE3.

## Licence #

Same as Lua 5.0.2

### ライセンス・配布条件
Lua-5.0.2 と同一。

著作権は Tecgraf および PUC-Rio が保有しています。
詳細については COPYRIGHT そして http://www.lua.org/license.html
を参照してください。

2005/07/04 t_kumagai
http://kuma.webj.net/
kuma@webj.net

