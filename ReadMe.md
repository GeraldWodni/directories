# Directory [proposal](https://forth-standard.org/proposals/directory-experiemental-proposal?hideDiff#reply-59) (library)

In order to write cross platform and cross system libraries it is essential to have means to traverse a systems file structure. This proposal is based upon the only known (by the authors) widly adopted implementation in Gforth.

Authors: Ulrich Hoffmann & Gerald Wodni

## Usage / Words
### `open-dir ( c-addr u -- dirid ior )`
Open the directory specified by c-addr, u and return dir-id for futher access to it.

### `read-dir ( c-addr u1 dirid -- u2 flag ior )`
Attempt to read the next entry from the directory specified by dir-id to the buffer of length u1 at address c-addr. If the attempt fails because there is no more entries, ior=0, flag=0, u2=0, and the buffer is unmodified. If the attempt to read the next entry fails because of any other reason, return ior<>0. If the attempt succeeds, store file name to the buffer at c-addr and return ior=0, flag=true and u2 equal to the size of the file name. If the length of the file name is greater than u1, store first u1 characters from file name into the buffer and indicate "name too long" with ior, flag=true, and u2=u1.

### `close-dir ( dirid -- ior )`
Close the directory specified by dir-id.

### `traverse-dir ( ix c-addr u xt -- kx ) with xt taking ( ix c-addr-filename u-filename -- jx )`
Possible alternative/addition to the upper three words. Suggested by Bernd Paysan and Matthias Trute

## Words for pathes:
Description take from the Node.js manual

### `normalize-path ( c-addr-1 u1 -- c-addr-1 u-2 )`
Normalize a string path, taking care of '..' and '.' parts. When multiple slashes are found, they're replaced by a single one; when the path contains a trailing slash, it is preserved.

### `basename-path ( c-addr-1 u1 -- c-addr-2 u-2 )`
Return the last portion of a path. Similar to the Unix basename command.

### `dirname-path ( c-addr-1 u1 -- c-addr-2 u-2 )`
Return the directory name of a path. Similar to the Unix dirname command.

### `extname-path ( c-addr-1 u1 -- c--addr-2 u-2 )`
Return the extension of the path, from the last '.' to end of string in the last portion of the path. If there is no '.' in the last portion of the path or the first character of it is '.', then it returns an empty string.

### `absolute-path? ( c-addr-1 u1 -- f )`
Determines whether path is an absolute path. An absolute path will always resolve to the same location, regardless of the working directory.

### `join-path ( c-addr-1 u1 c-addr2 u2 -- c-addr-3 u3 )`
Join all arguments together and normalize the resulting path. Arguments must be strings. Use implicit allocation?

### `filename-match ( c-addr1 u1 c-addr2 u2 – f )`
check if both pathes match (after expanding) any '.' and '..'

### `parent-dir ( c-addr1 u1 -- c-addr1 u2 )`
move up one directory

###` parent-dir? ( c-addr1 u1 -- f )`
check if there is a parent directory

## Contribute
If you want to contribute, please make sure to also follow the disussion on the [Forth Standard](https://forth-standard.org/proposals/directory-experiemental-proposal?hideDiff#reply-59).

Please check for `TODO:` comments.

## Slashes and Windows
Please note, that Windows is perfectly fine with forward slashes `/`, there is no need to abstract them. 


