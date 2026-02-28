#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

$LOAD_PATH << File.expand_path("lib", __dir__)
require "compiler"
require "formatter"

compiler = Compiler.new

$stderr.print "Carregando dados de teste"
compiler.add_test_file(
  "emoji-test-pt_br.txt"
)
warn " Feito!"

$stderr.print "Loading annotations"
Dir[
  "cldr/common/annotations/pt*.xml",
  "cldr/common/annotationsDerived/pt*.xml",
].each do |filename|
  compiler.add_annotation_file(
    filename
  )
  $stderr.print "."
end
warn " Feito!"

$stderr.print "Tentando determinar categorias faltantes… "
compiler.guess_missing_categories
warn " Feito!"

puts JSON.pretty_generate(Formatter.new(compiler.emojis.values))
