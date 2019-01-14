# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class MsgTrans < RegexLexer
      title "MessageTrans"
      desc "RISC OS message translator messages file"
      tag 'msgtrans'
      filenames 'Messages*'

      state :root do
        rule /^#[^\n]*\n/, Comment
        rule /[^\n ,):?\/]+/, Name::Variable
        rule /[\n\/?]/, Operator
        rule /:/, Operator, :value
      end

      state :value do
        rule /\n/, Text, :root
        rule /%[0-3%]/, Operator
        rule /./, Literal::String
      end
    end
  end
end
