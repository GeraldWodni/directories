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

\ traverse words (build upon basic upper words)
\ TODO: sort entries?
: traverse-dir ( ix c-addr u xt -- kx )
    >r \ save xt
    open-dir throw
    begin
        dup read-dir throw dup 0<>
    while
        rot r@ swap >r \ get xt, save dir-id
        execute ( ix c-addr-filename u-filename -- jx )
        r> \ restore dir-id
    repeat 2drop
    close-dir throw
    r> drop ; \ drop xt

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

\ common interactive extensions

: pwd ( -- )
    \ Print working directory
    get-wd type ;

: cd ( <parse-name> -- )
    \ *G change to working directory
    parse-name set-wd throw ;

: (ls-item) ( c-addr n -- )
    cr type ;
: ls ( [<parse-name>] -- )
    \ *G show content of parsed directory, if none is given show current directory
    parse-name
    dup 0= if \ no argument
        2drop
        get-wd
    then
    ['] (ls-item) traverse-dir ;
