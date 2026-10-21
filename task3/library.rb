class LibraryItem
  attr_reader :title, :author, :publication_year

  def initialize(title, author, publication_year)
    @title = title
    @author = author
    @publication_year = publication_year
  end

  def display_info
    puts "Author: #{@author}"
    puts "Title: #{@title}"
    puts "Publication Year: #{@publication_year}"
  end
end

class Book < LibraryItem
  attr_reader :genre, :pages

  def initialize(title, author, publication_year, genre, pages = nil)
    super(title, author, publication_year)
    @genre = genre
    @pages = pages
  end

  def display_info
    puts "Type: Book"
    super
    puts "Genre: #{@genre}"
    puts "Pages: #{@pages}" if @pages
  end
end

class DVD < LibraryItem
  attr_reader :genre, :duration

  def initialize(title, director, publication_year, genre, duration = nil)
    super(title, director, publication_year)
    @genre = genre
    @duration = duration
  end

  def display_info
    puts "Type: DVD"
    super
    puts "Genre: #{@genre}"
    puts "Duration: #{@duration} minutes" if @duration
  end
end

class CD < LibraryItem
  attr_reader :genre, :tracks

  def initialize(title, artist, publication_year, genre, tracks = nil)
    super(title, artist, publication_year)
    @genre = genre
    @tracks = tracks
  end

  def display_info
    puts "Type: CD"
    super
    puts "Genre: #{@genre}"
    puts "Tracks: #{@tracks}" if @tracks
  end
end

class Library
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
    puts "Added: #{item.title}"
  end

  def remove_item(item)
    if @items.delete(item)
      puts "Removed: #{item.title}"
    else
      puts "Item not found in the library."
    end
  end

  def display_item(item)
    item.display_info
  end

  def display_all_items
    if @items.empty?
      puts "The library is empty."
      return
    end

    puts "Library catalog (#{@items.size} items)"
    @items.each do |item|
      puts "-" * 30
      display_item(item)
    end
  end
end

# ---- Test ----
book = Book.new("Concepts of Programming Languages", "Robert Sebesta", 2015, "Programming", 800)
dvd = DVD.new("Inception", "Christopher Nolan", 2010, "Science Fiction", 148)
cd = CD.new("A Day at the Races", "Queen", 1976, "Rock", 9)

book.display_info
puts
dvd.display_info
puts
cd.display_info
puts

library = Library.new
library.add_item(book)
library.add_item(dvd)
library.add_item(cd)
puts

library.display_all_items
puts

library.remove_item(dvd)
puts
library.display_all_items