**Secrets** is a command line utility for 256-bit AES encryption and decryption. Easily protect snippets of information or individual files from unauthorized access.

## Usage

Functionality is split across the `encrypt` and `decrypt` subcommands. Pass the encryption key as the `-k, --key` option.

If directed to `stdout`, the encrypted output data is represented as a base64 encoded string. Analogously, encrypted input data from `stdin` is expected to be base64 encoded as well.

```
$ echo -n 🤐 | secrets encrypt --key 🔑
aF5EocGedncgf2XQHE9bNHJ+YXSvN6iPhLh4KElr0aw=

$ echo -n oNOk7ydxSTP8mQBDxdV337/+97Mlryc0H2iO834tjtQ= | secrets decrypt --key 🔑
😀
```

Alternatively, data flow can be directed to files via the `-i, --input` and `-o, --output` options. Encrypted files are represented in binary format.

```
$ echo ❤️ > file.txt

$ secrets encrypt --key 🔑 --input file.txt --output encrypted.secret

$ xxd encrypted.secret
00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000010: a1a9 5855 ce09 92c9 f698 85f2 244b 069b  ..XU........$K..
00000020: 51ac 3ecb 4862 b5df f272 d4b5 35d5 3f80  Q.>.Hb...r..5.?.
00000030: 5b80 8e                                  [..

$ secrets decrypt --key 🔑 --input encrypted.secret --output decrypted.txt

$ cat decrypted.txt
❤️
```

Note that if `encrypt` is repeatedly invoked with the same key and input, a different output will be produced on each run. This is due to the use of a random [nonce](https://en.wikipedia.org/wiki/Cryptographic_nonce), making all encrypted outputs unique.
