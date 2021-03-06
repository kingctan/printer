require "printer"
require "printer/id_generator"
require "fileutils"

module Printer::ContentStore
  class << self
    attr_accessor :content_directory

    def write_html_content(content, unique_id=Printer::IdGenerator.random_id)
      FileUtils.mkdir_p(File.join(Printer::ContentStore.content_directory, "temp_content"))
      public_path = File.join("/temp_content", "#{unique_id}.html")
      unless content.match(/<html>/)
        content = %{<!doctype html><html class="no-js" lang="en">#{content}</html>}
      end
      File.open(File.join(content_directory, public_path), "w") do |f|
        f.write(content)
      end
      public_path
    end
  end

  self.content_directory ||= File.expand_path("../../../public", __FILE__)
end
