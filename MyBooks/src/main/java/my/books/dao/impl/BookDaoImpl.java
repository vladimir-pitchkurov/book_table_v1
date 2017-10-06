package my.books.dao.impl;

import my.books.dao.BookDao;
import my.books.entity.Book;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BookDaoImpl implements BookDao {


    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addBook(Book book) {

        Session session = this.sessionFactory.getCurrentSession();
        session.persist(book);
    }

    @Override
    public void updateBook(Book book) {
        Session session = this.sessionFactory.getCurrentSession();
        book.setReadAlready(false);

        session.update(book);
    }

    @Override
    public void deleteBookByName(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        Book book = (Book) session.createQuery(String.format("FROM Book where 'title' like %s", name));
        session.delete(book);

    }

    @Override
    public void deleteBookById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete Book where id = :thisId");
        query.setParameter("thisId", id);
        int result = query.executeUpdate();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> getAllBook() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Book>bookList = session.createQuery("FROM Book").list();
        return bookList;
    }

    @Override
    public Book getBookById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        return  (Book) session.createQuery("FROM Book where id = :thisId").setParameter("thisId", id).uniqueResult();
    }

    @Override
    public Book getBookByAuthor(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        return  (Book) session.createQuery(String.format("FROM Book where 'title' like %s", name));
    }

    @Override
    public void readBook(int id) {

        this.sessionFactory.getCurrentSession().createQuery("update Book set readAlready = true where id = :thisId")
                .setParameter("thisId", id).executeUpdate();
    }
}
