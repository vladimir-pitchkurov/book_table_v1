package my.books.controller;


import my.books.entity.Book;
import my.books.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BookController {

    private BookService bookService;

    @Autowired(required = true)
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = "books", method = RequestMethod.GET)
    public String listBooks(Model model){
        model.addAttribute("book", new Book());
        model.addAttribute("listBooks", this.bookService.getAllBook());
        return "books";
    }

    @RequestMapping(value = "/books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("book") Book book){
        if (book.getId() == 0){
            this.bookService.addBook(book);
        }else {
            this.bookService.updateBook(book);
        }
        return "redirect:/books";
    }

    @RequestMapping(value = "/remove/{id}")
    public String removeBook(@PathVariable("id") int id){
        this.bookService.deleteBookById(id);

        return "redirect:/books";
    }

    @RequestMapping(value = "edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model){
        model.addAttribute("book", this.bookService.getBookById(id));
        model.addAttribute("listBooks", this.bookService.getAllBook());
        return "books";
    }
    @RequestMapping(value = "read/{id}")
    public String editBook(@PathVariable("id") int id){
        this.bookService.readBook(id);
        return "redirect:/books";
    }

    @RequestMapping(value = "bookdata/{id}")
    public String userData(@PathVariable("id") int id, Model model){
        model.addAttribute("book", this.bookService.getBookById(id));
        return "bookdata";
    }
}
