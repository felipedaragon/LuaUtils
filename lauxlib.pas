(*
** $Id: lauxlib.pas,v 1.3 2006/11/17 00:02:16 jfgoulet Exp $
** Auxiliary functions for building Lua libraries
** See Copyright Notice in lua.h
**
**   Translation form C and Delphi adaptation of Code : Massimo Magnano 2006
**
** Felipe Daragon, 2013:
**  Updated for XE3; Changed external to LuaDLL constant.
*)
unit lauxlib;

{$IFNDEF lauxlib_h}
{$DEFINE lauxlib_h}
{$ENDIF}

interface

uses lua, luaconf;


{$ifdef LUA_COMPAT_GETN}
function luaL_getn(L: Plua_State; t: Integer): Integer; cdecl external LuaDLL;
procedure luaL_setn(L: Plua_State; t: Integer; n: Integer); cdecl external LuaDLL;
{$else}
function luaL_getn(L: Plua_State; t: Integer): Integer;
procedure luaL_setn(L: Plua_State; t: Integer; n: Integer);
{$endif}

{$ifdef LUA_COMPAT_OPENLIB}
procedure luaL_openlib(L: Plua_State; libname: pAnsiChar;
                               R: PluaL_reg; Nup: Integer); cdecl external LuaDLL name 'luaI_openlib';
{$endif}

const
     LUA_ERRFILE = (LUA_ERRERR+1);

type
  luaL_Reg = record
    name: pAnsiChar;
    func: lua_CFunction;
  end;
  PluaL_Reg = ^luaL_Reg;

procedure luaI_openlib(L: Plua_State; libname: pAnsiChar;
                       R: PluaL_reg; nup: Integer); cdecl external LuaDLL;
procedure luaL_register(L: Plua_State; libname: pAnsiChar;
                        const R: PluaL_reg); cdecl external LuaDLL;
function luaL_getmetafield(L: Plua_State; obj: Integer; const e: pAnsiChar): Integer; cdecl external LuaDLL;
function luaL_callmeta(L: Plua_State; obj: Integer; const e: pAnsiChar): Integer; cdecl external LuaDLL;
function luaL_typerror(L: Plua_State; narg: Integer; const tname: pAnsiChar): Integer; cdecl external LuaDLL;
function luaL_argerror(L: Plua_State; numarg: Integer; const extramsg: pAnsiChar): Integer; cdecl external LuaDLL;
function luaL_checklstring(L: Plua_State; numArg: Integer; s: Psize_t): pAnsiChar; cdecl external LuaDLL;
function luaL_optlstring(L: Plua_State; numArg: Integer;
                         const def: pAnsiChar; s: Psize_t): pAnsiChar; cdecl external LuaDLL;
function luaL_checknumber(L: Plua_State; numArg: Integer): LUA_NUMBER; cdecl external LuaDLL;
function luaL_optnumber(L: Plua_State; nArg: Integer; def: LUA_NUMBER): LUA_NUMBER; cdecl external LuaDLL;

function luaL_checkinteger(L: Plua_State; numArg: Integer): LUA_INTEGER; cdecl external LuaDLL;
function luaL_optinteger(L: Plua_State; nArg: Integer; def: LUA_INTEGER): LUA_INTEGER; cdecl external LuaDLL;

procedure luaL_checkstack(L: Plua_State; sz: Integer; const msg: pAnsiChar); cdecl external LuaDLL;
procedure luaL_checktype(L: Plua_State; narg, t: Integer); cdecl external LuaDLL;
procedure luaL_checkany(L: Plua_State; narg: Integer); cdecl external LuaDLL;

function luaL_newmetatable(L: Plua_State; const tname: pAnsiChar): Integer; cdecl external LuaDLL;
function luaL_checkudata(L: Plua_State; ud: Integer; const tname: pAnsiChar): Pointer; cdecl external LuaDLL;

procedure luaL_where(L: Plua_State; lvl: Integer); cdecl external LuaDLL;
function luaL_error(L: Plua_State; const fmt: pAnsiChar): Integer; varargs; cdecl external LuaDLL;

function luaL_checkoption(L: Plua_State; narg: Integer; def: pAnsiChar; lst: array of pAnsiChar): Integer; cdecl external LuaDLL;

function luaL_ref(L: Plua_State; t: Integer): Integer; cdecl external LuaDLL;
procedure luaL_unref(L: Plua_State; t: Integer; ref: Integer); cdecl external LuaDLL;

function luaL_loadfile(L: Plua_State; const fileName: pAnsiChar): Integer; cdecl external LuaDLL;
function luaL_loadbuffer(L: Plua_State; const buff: pAnsiChar; sz: size_t;
                                const name: pAnsiChar): Integer; cdecl external LuaDLL;
function luaL_loadstring(L: Plua_State; const s: pAnsiChar): Integer; cdecl external LuaDLL;

function luaL_newstate: Plua_State; cdecl external LuaDLL;

function luaL_gsub(L: Plua_State; const s, p, r: pAnsiChar): pAnsiChar; cdecl external LuaDLL;

function luaL_findtable(L: Plua_State; idx: Integer; const fname: pAnsiChar; szhint: Integer): pAnsiChar; cdecl external LuaDLL;

(*
** ===============================================================
** some useful macros
** ===============================================================
*)

function luaL_argcheck(L: Plua_State; Cond: Boolean; NumArg: Integer; const ExtraMsg: pAnsiChar): Integer;
function luaL_checkstring(L: Plua_State; N: Integer): pAnsiChar;
function luaL_optstring(L: Plua_State; N: Integer; const D: pAnsiChar): pAnsiChar;
function luaL_checkint(L: Plua_State; narg: Integer): Integer;
function luaL_optint(L: Plua_State; narg: Integer; D: Integer): Integer;
function luaL_checklong(L: Plua_State; narg: Integer): LongInt;
function luaL_optlong(L: Plua_State; narg: Integer; d: Longint): Longint;

function luaL_typename(L: Plua_State; i: Integer): pAnsiChar;

function luaL_dofile(L: Plua_State; fn :pAnsiChar): Integer;

function luaL_dostring(L: Plua_State; s :pAnsiChar): Integer;

procedure luaL_getmetatable(L: Plua_State; const TName: pAnsiChar);

type
    luaL_optFunction = function (L: Plua_State; n :Integer): Integer; cdecl;

function luaL_opt(L: Plua_State; f: luaL_optFunction; n, d :Integer): Integer;

(*
** {======================================================
** Generic Buffer manipulation
** =======================================================
*)

type
  luaL_Buffer = record
    p: pAnsiChar;    (* current position in buffer *)
    lvl: Integer; (* number of strings in the stack(level) *)
    L: Plua_State;
    buffer: array [0..LUAL_BUFFERSIZE - 1] of AnsiChar;
  end;
  PluaL_Buffer = ^luaL_Buffer;

procedure luaL_addchar(B: PluaL_Buffer; c: AnsiChar);

(* compatibility only *)
procedure luaL_putchar(B: PluaL_Buffer; c: AnsiChar);

function luaL_addsize(B: PLuaL_Buffer; N: Integer): pAnsiChar;

procedure luaL_buffinit(L: Plua_State; B: PluaL_Buffer); cdecl external LuaDLL;
function luaL_prepbuffer(B: PluaL_Buffer): pAnsiChar; cdecl external LuaDLL;
procedure luaL_addlstring(B: PluaL_Buffer; const s: pAnsiChar; l: size_t); cdecl external LuaDLL;
procedure luaL_addstring(B: PluaL_Buffer; const s: pAnsiChar); cdecl external LuaDLL;
procedure luaL_addvalue(B: PluaL_Buffer); cdecl external LuaDLL;
procedure luaL_pushresult(B: PluaL_Buffer); cdecl external LuaDLL;

function lua_dofile(L: Plua_State; const FileName: pAnsiChar): Integer;
function lua_dostring(L: Plua_State; const Str: pAnsiChar): Integer;
function lua_dobuffer(L: Plua_State; const Buff: pAnsiChar; SZ: size_t;
                      const N: pAnsiChar): Integer;


(* }====================================================== *)



(* Compatibility with ref system *)
const
     LUA_NOREF = -2;
     LUA_REFNIL = -1;

function lua_ref(L: Plua_State; lock: Boolean): Integer;

procedure lua_unref(L: Plua_State; ref: Integer);

procedure lua_getref(L: Plua_State; ref: Integer);

implementation


{$ifndef LUA_COMPAT_GETN}
function luaL_getn(L: Plua_State; t: Integer): Integer;
begin
     Result :=lua_objlen(L, t)
end;

procedure luaL_setn(L: Plua_State; t: Integer; n: Integer);
begin
end;
{$endif}

(*
** ===============================================================
** some useful macros
** ===============================================================
*)

function luaL_argcheck(L: Plua_State; Cond: Boolean; NumArg: Integer; const ExtraMsg: pAnsiChar): Integer;
begin
     Result := 0;
     if not(Cond)
     then Result := luaL_argerror(L, NumArg, ExtraMsg)
end;

function luaL_checkstring(L: Plua_State; N: Integer): pAnsiChar;
begin
     Result := luaL_checklstring(L, N, nil);
end;

function luaL_optstring(L: Plua_State; N: Integer; const D: pAnsiChar): pAnsiChar;
begin
     Result := luaL_optlstring(L, N, D, nil);
end;

function luaL_checkint(L: Plua_State; narg: Integer): Integer;
begin
     Result := luaL_checkinteger(L, narg);
end;

function luaL_optint(L: Plua_State; narg: Integer; D: Integer): Integer;
begin
  Result := luaL_optinteger(L, narg, D);
end;

function luaL_checklong(L: Plua_State; narg: Integer): Longint;
begin
  Result := LongInt(luaL_checkinteger(L, narg));
  //old code : Result := Trunc(luaL_checknumber(L, narg));
end;

function luaL_optlong(L: Plua_State; narg: Integer; d: Longint): Longint;
begin
     Result := LongInt(luaL_optinteger(L, narg, D));
  //old code : Result := Trunc(luaL_optnumber(L, narg, D));
end;

function luaL_typename(L: Plua_State; i: Integer): pAnsiChar;
begin
     Result :=lua_typename(L, lua_type(L, i));
end;

function luaL_dofile(L: Plua_State; fn :pAnsiChar): Integer;
begin
     Result := luaL_loadfile(L, fn);
     if (Result=0)
     then Result := lua_pcall(L, 0, LUA_MULTRET, 0);
end;

function luaL_dostring(L: Plua_State; s :pAnsiChar): Integer;
begin
     Result := luaL_loadstring(L, s);
     if (Result=0)
     then Result := lua_pcall(L, 0, LUA_MULTRET, 0);
end;

procedure luaL_getmetatable(L: Plua_State; const TName: pAnsiChar);
begin
     lua_getfield(L, LUA_REGISTRYINDEX, TName);
end;

function luaL_opt(L: Plua_State; f: luaL_optFunction; n, d :Integer): Integer;
begin
     if lua_isnoneornil(L, n)
     then Result := d
     else Result := f(L, n);
end;

(*
** {======================================================
** Generic Buffer manipulation
** =======================================================
*)

procedure luaL_addchar(B: PluaL_Buffer; C: AnsiChar);
begin
     if ((B.P <= @B.Buffer[High(B.Buffer)]) or (luaL_prepbuffer(B) <> #0)) then
     begin
          B.P^ := C;
          Inc(B.P);
     end;
end;

procedure luaL_putchar(B: PluaL_Buffer; c: AnsiChar);
begin
     luaL_addchar(B, C);
end;

function luaL_addsize(B: PLuaL_Buffer; N: Integer): pAnsiChar;
begin
     Inc(B.P, N);
     Result := B.P;
end;

function lua_dofile(L: Plua_State; const FileName: pAnsiChar): Integer;
begin
     Result :=luaL_dofile(L, FileName);
end;

function lua_dostring(L: Plua_State; const Str: pAnsiChar): Integer;
begin
     Result :=luaL_dostring(L, Str);
end;

function lua_dobuffer(L: Plua_State; const Buff: pAnsiChar; SZ: size_t;
                      const N: pAnsiChar): Integer;
begin
     Result := luaL_loadbuffer(L, Buff, SZ, N);
     if (Result=0)
     then Result := lua_pcall(L, 0, LUA_MULTRET, 0);
end;

(* compatibility with ref system *)
function lua_ref(L: Plua_State; lock: Boolean): Integer;
begin
     if lock
     then Result :=luaL_ref(L, LUA_REGISTRYINDEX)
     else begin
               lua_pushstring(L, 'unlocked references are obsolete');
               lua_error(L);
               Result :=0;
          end;
end;

procedure lua_unref(L: Plua_State; ref: Integer);
begin
     luaL_unref(L, LUA_REGISTRYINDEX, ref);
end;

procedure lua_getref(L: Plua_State; ref: Integer);
begin
     lua_rawgeti(L, LUA_REGISTRYINDEX, ref);
end;

end.
