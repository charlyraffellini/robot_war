#========================================================
#          This code is just an example
#========================================================

Parsimmon = require "Parsimmon"

regex = Parsimmon.regex
string = Parsimmon.string
optWhitespace = Parsimmon.optWhitespace
lazy = Parsimmon.lazy

lexeme = (p) ->
  p.skip optWhitespace

describe "json parser", ->
  it "can parse a json object", ->
    json.parse("{\"sda\": 123}").value.should.be.deepEqual(sda: 123)

interpretEscapes = (str) ->
  escapes =
    b: '\u0008'
    f: '\u000c'
    n: '\n'
    r: '\u000d'
    t: '\u0009'
  str.replace /\\(u[0-9a-fA-F]{4}|[^u])/, (_, escape) ->
    type = escape.charAt(0)
    hex = escape.slice(1)
    if type == 'u'
      return String.fromCharCode(parseInt(hex, 16))
    if escapes.hasOwnProperty(type)
      return escapes[type]
    type


json = do ->
  `var json`
  # local imports
  string = Parsimmon.string
  regex = Parsimmon.regex
  succeed = Parsimmon.succeed
  seq = Parsimmon.seq
  seqMap = Parsimmon.seqMap
  alt = Parsimmon.alt
  lazy = Parsimmon.lazy
  # whitespace, etc
  ignore = regex(/\s*/m)
  # lexemes
  lbrace = lexeme(string('{'))
  rbrace = lexeme(string('}'))
  lbrack = lexeme(string('['))
  rbrack = lexeme(string(']'))
  quoted = lexeme(regex(/"((?:\\.|.)*?)"/, 1)).desc('a quoted string')
  comma = lexeme(string(','))
  colon = lexeme(string(':'))
  number = lexeme(regex(/-?(0|[1-9]\d*)([.]\d+)?(e[+-]?\d+)?/i)).desc('a numeral')
  nullLiteral = lexeme(string('null')).result(null)
  trueLiteral = lexeme(string('true')).result(true)
  falseLiteral = lexeme(string('false')).result(false)
  # forward-declared base parser
  json = lazy('a json element', ->
    alt object, array, stringLiteral, numberLiteral, nullLiteral, trueLiteral, falseLiteral
  )
  # domain parsers
  commaSep = (parser) ->
    commaParser = comma.then(parser).many()
    seqMap(parser, commaParser, (first, rest) ->
      [ first ].concat rest
    ).or succeed([])
  stringLiteral = quoted.map(interpretEscapes)
  numberLiteral = number.map(parseFloat)
  array = seqMap(lbrack, commaSep(json), rbrack, (_, results, __) ->
    results
  )
  pair = seq(stringLiteral.skip(colon), json)
  object = seqMap(lbrace, commaSep(pair), rbrace, (_, pairs, __) ->
    out = {}
    i = pairs.length - 1
    while i >= 0
      out[pairs[i][0]] = pairs[i][1]
      i -= 1
    out
  )
  # top-level parser, with whitespace at the beginning

  lexeme = (p) ->
    p.skip ignore

  ignore.then json
