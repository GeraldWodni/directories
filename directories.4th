\ directories library
\ (c)copyright 2021 by Gerald Wodni <gerald.wodni@gmail.com>
\ this library aims to standardize managing directories under Forth in a common way

\ common constants
1024 constant /max-dirname  \ *G specify the maximum length of a pathname (be generous and leave some extra)

\ until the major systems support us, we are stuck with this ugly include mess:

\ gforth
: compat-gforth if s" compat-gforth.4th" required then ;
[DEFINED] gforth compat-gforth

\ vfx
: compat-vfx    if s" compat-vfx.4th"    required then ;
[DEFINED] vfxforth compat-vfx

\ check if base words are supported, if not please provide a compat file for your system via pull request
: [DEFINED-OR-DIE] ( <parse-name -- )
    \ *G quit if <parse-name> is not defined
    parse-name 2dup find-name 0= if cr ." SYSTEM NOT SUPPORTED, please implement " type quit else 2drop then ;
[DEFINED-OR-DIE] open-dir
[DEFINED-OR-DIE] read-dir
[DEFINED-OR-DIE] close-dir
[DEFINED-OR-DIE] create-dir


\ words for pathes (pure sting implementations)

\ TODO: stub
: normalize-path ( c-addr-1 u1 -- c-addr-1 u-2 )
    ;

\ TODO: stub
: basename-path ( c-addr-1 u1 -- c-addr-2 u-2 )
    ;

\ TODO: stub
: dirname-path ( c-addr-1 u1 -- c-addr-2 u-2 )
    ;

\ TODO: stub
: extname-path ( c-addr-1 u1 -- c--addr-2 u-2 )
    ;

\ TODO: stub
: absolute-path? ( c-addr-1 u1 -- f )
    2drop false ;

\ TODO: stub
: join-path ( c-addr-1 u1 c-addr2 u2 -- c-addr-3 u3 )
    2drop ;

\ TODO: stub
: filename-match ( c-addr1 u1 c-addr2 u2 – f )
    2drop 2drop false ;

\ TODO: stub
: parent-dir ( c-addr1 u1 -- c-addr1 u2 )
    ;

: parent-dir? ( c-addr1 u1 -- f )
    >r r@ parent-dir nip r> = ;
