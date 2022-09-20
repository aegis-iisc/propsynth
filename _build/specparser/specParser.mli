
(* The type of tokens. *)

type token = 
  | UNION
  | UINST
  | TYPE
  | TRUE
  | SUBSETEQ
  | SUBSET
  | STRCONST of (string)
  | STEXC
  | STATE
  | STAR
  | SEMICOLON
  | RPAREN
  | RELATION
  | REF
  | RCURLY
  | RBRACE
  | QUAL
  | PURE
  | PRIMITIVE
  | PLUS
  | PIPE
  | OF
  | NUMEQ
  | NOT
  | MINUS
  | LPAREN
  | LESSTHAN
  | LCURLY
  | LBRACE
  | LAMBDA
  | INT of (int)
  | IMPL
  | IFF
  | ID of (string)
  | GREATERTHAN
  | FORMULA
  | FALSE
  | EXISTS
  | EXC
  | EQUALOP
  | EOL
  | EOF
  | DOT
  | DISJ
  | CROSSPRD
  | CONJ
  | COMMA
  | COLONARROW
  | COLON
  | ASSUME
  | ARROW
  | ARMINUS
  | ANGRIGHT
  | ANGLEFT
  | ALL

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val start: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (SpecLang.RelSpec.t)
