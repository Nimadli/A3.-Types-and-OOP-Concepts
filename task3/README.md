# Library Catalog System in Ruby

## Objective

Build a library catalog system in Ruby that manages different types of library items (books, DVDs and CDs) and demonstrates the main Object-Oriented Programming principles: class design, inheritance, encapsulation and polymorphism.

## Design

| Class | Inherits from | Own properties | Purpose |
|---|---|---|---|
| `LibraryItem` | - | `title`, `author`, `publication_year` | Base class with the common data and a shared `display_info` method |
| `Book` | `LibraryItem` | `genre`, `pages` | A book |
| `DVD` | `LibraryItem` | `genre`, `duration` (minutes) | A DVD (the `author` field holds the director) |
| `CD` | `LibraryItem` | `genre`, `tracks` | A CD (the `author` field holds the artist) |
| `Library` | - | `@items` (array) | Stores and manages a collection of items |

`pages`, `duration` and `tracks` are optional constructor arguments. If they are left out, the corresponding line is simply not printed.

`Library` methods:

- `add_item(item)` adds an item to the collection
- `remove_item(item)` removes an item, or reports that it was not found
- `display_item(item)` displays any single item
- `display_all_items` displays every item in the library

## How to run

```
ruby library_simple.rb
```

## OOP concepts in the code

**Class design.** Each class has one responsibility. The item classes hold data about an item, and `Library` manages a collection of them.

**Inheritance.** `Book`, `DVD` and `CD` use `< LibraryItem` to inherit the common properties and methods. Their constructors call `super(title, author, publication_year)` to reuse the base class initialization, and then set their own properties.

```ruby
class Book < LibraryItem
  def initialize(title, author, publication_year, genre, pages = nil)
    super(title, author, publication_year)
    @genre = genre
    @pages = pages
  end
end
```

**Encapsulation.** Data is stored in instance variables (`@title`, `@author`, `@publication_year`, `@genre`, `@pages`, `@duration`, `@tracks`, `@items`). Outside code cannot access them directly. They are exposed read-only through `attr_reader`, so the values of an item cannot be changed from outside the class.

**Polymorphism.** Every item class defines its own `display_info`. The subclass versions print the type, call `super` for the common fields, and then print their own properties. `Library#display_item` calls `item.display_info` without checking the item's class, so it works for books, DVDs, CDs and any item type added later.

```ruby
def display_item(item)
  item.display_info
end
```

## Output

```
Type: Book
Author: Robert Sebesta
Title: Concepts of Programming Languages
Publication Year: 2015
Genre: Programming
Pages: 800

Type: DVD
Author: Christopher Nolan
Title: Inception
Publication Year: 2010
Genre: Science Fiction
Duration: 148 minutes

Type: CD
Author: Queen
Title: A Day at the Races
Publication Year: 1976
Genre: Rock
Tracks: 9

Added: Concepts of Programming Languages
Added: Inception
Added: A Day at the Races

Library catalog (3 items)
------------------------------
Type: Book
Author: Robert Sebesta
Title: Concepts of Programming Languages
Publication Year: 2015
Genre: Programming
Pages: 800
------------------------------
Type: DVD
Author: Christopher Nolan
Title: Inception
Publication Year: 2010
Genre: Science Fiction
Duration: 148 minutes
------------------------------
Type: CD
Author: Queen
Title: A Day at the Races
Publication Year: 1976
Genre: Rock
Tracks: 9

Removed: Inception

Library catalog (2 items)
------------------------------
Type: Book
Author: Robert Sebesta
Title: Concepts of Programming Languages
Publication Year: 2015
Genre: Programming
Pages: 800
------------------------------
Type: CD
Author: Queen
Title: A Day at the Races
Publication Year: 1976
Genre: Rock
Tracks: 9
```

The output shows each item displayed individually, the whole library displayed, and the library again after the DVD was removed.

## Notes

- A DVD's director and a CD's artist are stored in the shared `author` field, so all items print the label "Author". A more detailed version could override the label per class.
- The page count, duration and track count in the test are sample values.
