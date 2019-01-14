# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class BBCBASIC < RegexLexer
      title "BBCBASIC"
      desc "BBC BASIC syntax"
      tag 'bbcbasic'
      filenames '*,fd1'

      state :root do
        rule /[ ]+/, Text
        rule /[\[]/, Keyword, :assembly1
        rule /[*].*\n/, Generic::Prompt # CLI command
        rule /REM *>.*\n/, Comment::Special
        rule /REM.*\n/, Comment
        rule /([:,;'~]|SPC|TAB)/, Punctuation
        rule /(ABS|ACS|ADVAL|ASC|ASN|ATN|BEATS|BEAT|BGET#|CHR\$|COS|COUNT|DEG|EOF#|ERL|ERR(?!OR)|EVAL|EXP|EXT#|GET(\$#?)?|HIMEM|INKEY\$?|INSTR|INT|LEFT\$|LEN|LN|LOG|LOMEM|MID\$|OPENIN|OPENOUT|OPENUP|PAGE|POS|PTR#|RAD|REPORT\$|RIGHT\$|RND|SGN|SIN|SQR|STR\$|STRING\$|SUM|SUMLEN|TAN|TEMPO|TIME\$?|TOP|USR|VAL|VPOS)/, Name::Builtin # function or pseudo-variable
        rule /(DIM|POINT)(?=[(])/, Name::Builtin # function sharing keyword with statement, distinguished by ()
        rule /(CASE|CHAIN|DEF *(FN|PROC)|ELSE|ENDCASE|ENDIF|ENDPROC|ENDWHILE|END|ERROR( *EXT)?|FN|FOR|GOSUB|GOTO|IF|INSTALL|LIBRARY|NEXT|OF|ON( *ERROR *OFF| *ERROR *LOCAL| *ERROR)|OTHERWISE|OVERLAY|PROC|REPEAT|RETURN|STEP|STOP|THEN|TO|UNTIL|WHEN|WHILE)/, Keyword # control flow statement
        rule /(BEATS|BPUT#|CALL|CIRCLE( *FILL)?|CLEAR|CLG|CLOSE#|CLS|COLOR|COLOUR|DATA|DIM|DRAW( *BY)?|ELLIPSE( *FILL)?|ENVELOPE|FILL( *BY)?|GCOL|INPUT(#| *LINE)?|LET|LINE( *INPUT)?|LOCAL( *DATA| *ERROR)?|MODE|MOUSE( *COLOUR| *OFF| *ON| *RECTANGLE| *STEP| *TO)?|MOVE( *BY)?|OFF|ON|ORIGIN|OSCI|PLOT|POINT( *BY)?|PRINT#?|QUIT|READ|RECTANGE( *FILL)?|REPORT|RESTORE( *DATA| *ERROR)?|SOUND|STEREO|SWAP|SYS|TINT|TRACE( *CLOSE| *ENDPROC| *OFF| *STEP( *FN| *ON| *PROC)?| *TO)?|VDU|VOICES?|WAIT|WIDTH)/, Keyword # other statement
        rule /(<<|<=|<>|<|>=|>>>|>>|>|[-!\$()*+\/=?^|]|AND|DIV|EOR|MOD|NOT|OR)/, Operator
        rule /(FALSE|TRUE)/, Name::Constant
        rule /"[^"]*"/, Literal::String
        rule /[A-Za-z_`][0-9A-Za-z_`]*[\$%]?/, Name::Variable
        rule /@%/, Name::Variable
        rule /[0-9.]+/, Literal::Number
        rule /%[01]+/, Literal::Number # binary
        rule /&[0-9A-Fa-f]+/, Literal::Number::Hex
      end

      state :assembly1 do
        # Technically, you don't need whitespace between opcodes and arguments,
        # but this is rare in uncrunched source and trying to enumerate all
        # possible opcodes here is impractical so we colour it as though
        # the whitespace is required
        rule /[ ]+/, Text
        rule /]/, Keyword, :root
        rule /[:\n]/, Punctuation
        rule /[.][A-Za-z_`][0-9A-Za-z_`]*%?[ ]*/, Name::Label
        rule /(REM|;)[^:\n]*/, Comment
        rule /[^ :\n]+/, Keyword, :assembly2
      end

      state :assembly2 do
        rule /[ ]+/, Text
        rule /[:\n]/, Punctuation, :assembly1
        rule /(REM|;)[^:\n]*/, Comment, :assembly1
        rule /(ABS|ACS|ADVAL|ASC|ASN|ATN|BEATS|BEAT|BGET#|CHR\$|COS|COUNT|DEG|EOF#|ERL|ERR|EVAL|EXP|EXT#|GET(\$#?)?|HIMEM|INKEY\$?|INSTR|INT|LEFT\$|LEN|LN|LOG|LOMEM|MID\$|OPENIN|OPENOUT|OPENUP|PAGE|POS|PTR#|RAD|REPORT\$|RIGHT\$|RND|SGN|SIN|SQR|STR\$|STRING\$|SUM|SUMLEN|TAN|TEMPO|TIME\$?|TOP|USR|VAL|VPOS)/, Name::Builtin # function or pseudo-variable
        rule /(DIM|POINT)(?=[(])/, Name::Builtin # function sharing keyword with statement, distinguished by ()
        rule /(<<|<=|<>|<|>=|>>>|>>|>|[-!\$()*+\/=?^|]|AND|DIV|EOR|MOD|NOT|OR)/, Operator
        rule /(FALSE|TRUE)/, Name::Constant
        rule /"[^"]*"/, Literal::String
        rule /[A-Za-z_`][0-9A-Za-z_`]*[\$%]?/, Name::Variable
        rule /@%/, Name::Variable
        rule /[0-9.]+/, Literal::Number
        rule /%[01]+/, Literal::Number # binary
        rule /&[0-9A-Fa-f]+/, Literal::Number::Hex
        rule /[!#,@\[\]^{}]/, Punctuation
      end
    end
  end
end
