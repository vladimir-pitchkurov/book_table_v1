package my.books.service.impl;

import my.books.dao.BookDao;
import my.books.entity.Book;
import my.books.service.BookService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class BookServiseImpl implements BookService {

    private BookDao bookDao;

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Override
    @Transactional
    public void addBook(Book book) {

        bookDao.addBook(book);
    }

    @Override
    @Transactional
    public void updateBook(Book book) {

        bookDao.updateBook(book);
    }

    @Override
    @Transactional
    public void deleteBookByName(String name) {

        bookDao.deleteBookByName(name);
    }

    @Override
    @Transactional
    public void deleteBookById(int id) {

        bookDao.deleteBookById(id);
    }

    @Override
    @Transactional
    public List<Book> getAllBook() {
        return bookDao.getAllBook();
    }

    @Override
    @Transactional
    public Book getBookById(int id) {
        return bookDao.getBookById(id);
    }

    @Override
    @Transactional
    public Book getBookByAuthor(String name) {
        return bookDao.getBookByAuthor(name);
    }

    @Override
    @Transactional
    public void readBook(int id) {

        bookDao.readBook(id);
    }
}
