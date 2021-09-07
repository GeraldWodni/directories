\ directories implementation for VFX
\ (c)copyright 2021 by Gerald Wodni <gerald.wodni@gmail.com>

\ proposal: open-dir ( c-addr u –- dir-id ior )
/max-dirname allocate throw constant read-dir-buffer
: open-dir ( c-addr u –- dir-id ior )
    read-dir-buffer zplace
    read-dir-buffer opendir
    dup 0<> if
        0 \ no error
    else
        errno @
    then ;

\ proposal: read-dir ( dir-id -- c-addr u ior )
\ hint: proposal definition differs, see Anton Ertl's comment: https://forth-standard.org/proposals/directory-experiemental-proposal#reply-73
: read-dir ( dir-id -- c-addr u ior )
    \ TODO: replace 11 by offsetof(d_name)
    0 errno ! \ man page of readdir instructs to set errno explicitly before calling readdir
    readdir dup if
        11 + zcount
        0 \ no error
    else
        0 \ length=0
        errno @
    then ;

\ close-dir ( dirid -- ior )
: close-dir ( dir-id -- ior )
    closedir dup 0<> if
        drop errno @
    then ;

\ create-dir ( c-addr u -- ior )
\ hint: proposal name differs, see Stephen Pelc's comment: https://forth-standard.org/proposals/directory-experiemental-proposal#reply-85

: find-name ( c-addr n -- xt | 0 )
  {: | temp[ #256 ] -- :}
  temp[ place
  temp[ find 0= if nip 0 then ;

