require('spec_helper')

describe(Author) do

  describe('#name') do
  it('returns the name') do
    author = Author.new({:name => "George Clooney", :id => nil})
    expect(author.name()).to(eq("George Clooney"))
  end
end

  describe('#id') do
    it('returns the id') do
      author = Author.new({:name => "George Clooney", :id => 1})
      expect(author.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no authors") do
      expect(Author.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns an author by its id number") do
      test_author = Author.new({:name => "Brad Pitt", :id => nil})
      test_author.save()
      test_author2 = Author.new({:name => "george Clooney", :id => nil})
      test_author2.save()
      expect(Author.find(test_author2.id())).to(eq(test_author2))
    end
  end

  describe("#==") do
    it("is the same author if it has the same name and id") do
      author = Author.new({:name => "George Clooney", :id => nil})
      author2 = Author.new(:name => "George Clooney", :id => nil)
      expect(author).to(eq(author2))
    end
  end

  describe("#update") do
    it("lets you update the authors in the database") do
      author = Author.new({:name => "George Clooney", :id => nil})
      author.save()
      author.update({:name => "Brad Pitt"})
      expect(author.name()).to(eq("Brad Pitt"))
    end

    it("lets you add a book to an author") do
      book = Book.new({:name => "Oceans Eleven", :id => nil})
      book.save()
      author = Author.new({:name => "George Clooney", :id => nil })
      author.save()
      author.update({:book_ids => [book.id()]})
      expect(author.books()).to(eq([book]))
    end
  end

  describe("#books") do
    it("returns all of the books a particular author has written") do
      book = Book.new({:name => "Oceans Eleven", :id => nil})
      book.save()
      book2 = Book.new({:name => "Oceans Twelve", :id => nil})
      book2.save()
      author = Author.new({:name => "George Clooney", :id => nil})
      author.save()
      author.update({:book_ids => [book.id()]})
      author.update({:book_ids => [book2.id()]})
      expect(author.books()).to(eq([book, book2]))
    end
  end


  describe('#delete') do
    it("lets you delete an author from the database") do
      author = Author.new({:name => "George Clooney", :id => nil})
      author.save()
      author2 = Author.new({:name => "Brad Pitt", :id => nil})
      author2.save()
      author.delete()
      expect(Author.all()).to(eq([author2]))
    end
  end

end
