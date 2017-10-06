package my.books.service;

import my.books.entity.Book;

import java.util.List;

public interface BookService {

    public void addBook(Book book);
    public void updateBook(Book book);
    public void deleteBookByName(String name);
    public void deleteBookById(int id);
    public List<Book> getAllBook();
    public Book getBookById(int id);
    public Book getBookByAuthor(String name);
    public void readBook(int id);
}
