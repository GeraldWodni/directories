\ directories implementation for GForth
\ (c)copyright 2021 by Gerald Wodni <gerald.wodni@gmail.com>

\ proposal: open-dir ( c-addr u – wdirid wior )
\ original implementation compatible

\ proposal: read-dir ( dir-id -- c-addr u ior )
\ original: read-dir ( c-addr u1 dirid -- u2 flag ior )
\ hint: proposal definition differs, see Anton Ertl's comment: https://forth-standard.org/proposals/directory-experiemental-proposal#reply-73
/max-dirname allocate throw constant read-dir-buffer
: read-dir ( dir-id -- c-addr u ior )
    >r read-dir-buffer /max-dirname r>
    read-dir ( c-addr u1 dirid -- u2 flag ior )
    >r if
        read-dir-buffer swap
    else
        drop 0 0
    then r> ;

\ close-dir ( dirid -- ior )
\ original implementation compatible

\ create-dir ( c-addr u -- ior )
\ hint: proposal name differs, see Stephen Pelc's comment: https://forth-standard.org/proposals/directory-experiemental-proposal#reply-85
: create-dir ( c-addr u -- ior )
    $1FF mkdir-parents ;

\ dir? ( c-addr u -- flag ior )
\ TODO: stub
: dir? ( c-addr u -- flag ior )
    2drop false 0 ;
