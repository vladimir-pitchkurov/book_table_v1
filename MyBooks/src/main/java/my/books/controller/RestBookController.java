package my.books.controller;


import my.books.entity.Book;
import my.books.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;

@RestController
@RequestMapping("/rest")
public class RestBookController {

    private final BookService bookService;

    @Autowired
    public RestBookController(BookService bookService) {
        this.bookService = bookService;
    }


    @GetMapping("/books")
    public Collection<Book> usersList(){
        return bookService.getAllBook();
    }
}
