#!/usr/bin/env ruby
# frozen_string_literal: true

# Valida os posts em _posts/: nome do arquivo, data, slug e front matter.
#
# Uso: ruby script/validate-posts.rb [diretório]

require "date"
require "yaml"

POSTS_DIR = ARGV[0] || File.expand_path("../_posts", __dir__)

FILENAME = /\A(?<date>\d{4}-\d{2}-\d{2})-(?<slug>[a-z0-9]+(?:-[a-z0-9]+)*)\.md\z/
TAG = /\A[a-z0-9][a-z0-9.+-]*\z/
URL = %r{\Ahttps?://\S+\z}

errors = []
slugs = Hash.new { |h, k| h[k] = [] }

def error(errors, file, message)
  errors << "#{file}: #{message}"
end

files = Dir.children(POSTS_DIR).reject { |f| f.start_with?(".") }.sort

if files.empty?
  warn "Nenhum post encontrado em #{POSTS_DIR}"
  exit 1
end

today = Date.today

files.each do |file|
  path = File.join(POSTS_DIR, file)

  if File.directory?(path)
    error(errors, file, "diretórios não são permitidos em _posts/")
    next
  end

  match = FILENAME.match(file)
  unless match
    error(errors, file, "nome inválido. Use AAAA-MM-DD-slug-do-post.md " \
                        "(slug com letras minúsculas, números e hífens)")
    next
  end

  begin
    date = Date.strptime(match[:date], "%Y-%m-%d")
  rescue ArgumentError # Date::Error (Ruby 2.7+) herda de ArgumentError
    error(errors, file, "data inválida: #{match[:date]}")
    next
  end

  if date > today
    error(errors, file, "data no futuro (#{date}); o Jekyll não publica posts futuros")
  end

  slugs[match[:slug]] << file

  content = File.read(path, encoding: "UTF-8")

  unless content.valid_encoding?
    error(errors, file, "o arquivo precisa estar em UTF-8")
    next
  end

  front_matter = content.match(/\A---\s*\n(.*?)\n---\s*(?:\n|\z)(.*)\z/m)
  unless front_matter
    error(errors, file, "front matter ausente ou mal formatado (precisa começar e terminar com ---)")
    next
  end

  begin
    data = YAML.safe_load(front_matter[1], permitted_classes: [Date, Time]) || {}
  rescue Psych::Exception => e
    error(errors, file, "YAML inválido no front matter: #{e.message}")
    next
  end

  unless data.is_a?(Hash)
    error(errors, file, "front matter precisa ser um mapa YAML")
    next
  end

  title = data["title"]
  if !title.is_a?(String) || title.strip.empty?
    error(errors, file, "'title' é obrigatório")
  end

  author = data["author"]
  if !author.is_a?(Hash)
    error(errors, file, "'author' é obrigatório, com 'name' e 'link'")
  else
    name = author["name"]
    link = author["link"]
    error(errors, file, "'author.name' é obrigatório") if !name.is_a?(String) || name.strip.empty?
    error(errors, file, "'author.link' precisa ser uma URL http(s)") if !link.is_a?(String) || !URL.match?(link)
  end

  tags = data["tags"]
  if !tags.is_a?(Array) || tags.empty?
    error(errors, file, "'tags' precisa ser uma lista com pelo menos uma tag")
  else
    tags.each do |tag|
      unless tag.is_a?(String) && TAG.match?(tag)
        error(errors, file, "tag inválida: #{tag.inspect} (use minúsculas, números, '.', '+' ou '-')")
      end
    end
    duplicated = tags.group_by(&:itself).select { |_, v| v.size > 1 }.keys
    error(errors, file, "tags repetidas: #{duplicated.join(', ')}") unless duplicated.empty?
  end

  if data.key?("layout") && data["layout"] != "post"
    error(errors, file, "'layout' deve ser omitido (o padrão é 'post')")
  end

  if front_matter[2].strip.empty?
    error(errors, file, "o post não tem conteúdo")
  end
end

slugs.each do |slug, list|
  next if list.size < 2

  errors << "slug '#{slug}' repetido em: #{list.join(', ')}"
end

if errors.empty?
  puts "#{files.size} posts válidos."
else
  warn "Encontrados #{errors.size} problemas:\n\n"
  errors.each { |e| warn "  - #{e}" }
  exit 1
end
