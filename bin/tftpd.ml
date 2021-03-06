(*
 * Copyright (c) 2015 Richard Mortier <mort@cantab.net>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

module Main (C: V1_LWT.CONSOLE) (FS: V1_LWT.KV_RO) (S: V1_LWT.STACKV4) = struct

  module T = Tftp_mirage.S.Make(C)(FS)(S)

  let start c fs s =
    let files = "./files" in
    let config = Tftp.Config.make files in
    let port = Tftp.Config.port config in
    let server = Tftp.S.make config in
    S.listen_udpv4 s ~port T.(callback ~port { server; c; fs; s });
    S.listen s

end
