# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class CMHG < RegexLexer
      title "CMHG"
      desc "RISC OS C module header generator source file"
      tag 'cmhg'
      filenames '*.cmhg'

      state :root do
        rule /;[^\n]*/, Comment
        rule /^[ \t]*#[ \t]*((define|elif|else|endif|error|if|ifdef|ifndef|include|line|pragma|undef|warning)[ \t].*)?\n/, Comment::Preproc
        rule /[-a-z]+:/, Keyword::Declaration
        rule /[A-Za-z_][0-9A-Za-z_]+/, Name::Entity
        rule /"[^"]*"/, Literal::String
        rule /(&|0x)[0-9A-Fa-f]+/, Literal::Number::Hex
        rule /[0-9]+/, Literal::Number
        rule /[,\/()]/, Punctuation
        rule /[ \t\n]+/, Text
      end
    end
  end
end
