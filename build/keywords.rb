require 'nokogiri'
require 'sqlite3'

module DartTour
  sql = 'INSERT INTO searchIndex(name, type, path) VALUES (?, ?, ?)'

  class DartPage

    def initialize(page)
      @name = page.split('/').pop
      @path = File.join(File.dirname(__FILE__), "_docs/#{@name}")
      @sql_path = File.join(File.dirname(__FILE__), "#{@name}.db")
      @html = Nokogiri::HTML(page)
      @db = self.init_db
    end

    def init_db
      @db = SQLite3::Database.new(@sql_path)
      @db.execute <<-SQL
       CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT,
                                path TEXT);
       CREATE UNIQUE INDEX anchor ON searchIndex(name, type, path);
       SQL
    end

  end
end

def toc doc
  refs = doc.css('li').collect { |x|
    x
  }
end

# doc_file = ARGV.first
# file_name = ARGV.first
