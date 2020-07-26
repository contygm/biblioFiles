import * as functions from 'firebase-functions';
import { connect } from './config'; 
import { Book } from './entity/Book';
import { User } from './entity/User';
import { Library } from './entity/Library'; 
import { BookLibrary } from './entity/BookLibrary';
import { Genre } from './entity/Genre';

export const echo = functions.https.onCall(async (data, context) => {
    return data.text; 
});
export const echo_protected = functions.https.onCall(async (data, context) => {
    return data.text; 
});


// create a book
export const createBook = functions.https.onCall(async (data: Book, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const bookRepo = connection.getRepository(Book); 

        // create new book object
        const newBook = new Book();
        newBook.title = data.title; 
        newBook.author = data.author; 
        newBook.isbn10 = data.isbn10 || null;
        newBook.isbn13 = data.isbn13 || null;
        newBook.dewey = data.dewey || null;
        newBook.pages = data.pages || 0;
        newBook.lang = data.lang || null;
        newBook.image = data.image || null;
        newBook.genres = data.genres || null; 
        
    

        // write object to the database
        const savedBook = await bookRepo.save(newBook); 

        // return created book
        return savedBook; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }   
}); 

// get all books
export const getAllBooks = functions.https.onCall(async (data, context) => {
    // database connection
    const connection = await connect(); 

    // get repo
    const bookRepo = connection.getRepository(Book);

    // get all
    const allBooks = await bookRepo.find(); 

    // return books
    return allBooks; 
});

//create user 
export const createUser = functions.https.onCall(async (data: User, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const userRepo = connection.getRepository(User); 

        // create new user object
        const newUser = new User();
        newUser.username = data.username; 
        newUser.email = data.email;  
    

        // write object to the database
        const savedUser = await userRepo.save(newUser); 

        // return created user
        return savedUser; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }   
}); 

//create library 
export const createLibrary = functions.https.onCall(async (data: Library, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const libraryRepo = connection.getRepository(Library); 

        // create new library object
        const newLibrary = new Library();
        newLibrary.name = data.name;
        const userRepo = connection.getRepository(User); 
        newLibrary.user = await userRepo.findOne(data.user); 

        // write object to the database
        const savedLibrary = await libraryRepo.save(newLibrary); 

        // return created library
        return savedLibrary; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }   
}); 

//create book assigned to library 
export const createBookLibrary = functions.https.onCall(async (data: BookLibrary, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const bookLibraryRepo = connection.getRepository(BookLibrary); 

        // create new book in library object
        const newBookLibrary = new BookLibrary();
        newBookLibrary.user_note = data.user_note || null; 
        newBookLibrary.private_book = data.private_book; 
        newBookLibrary.loanable = data.loanable;
        newBookLibrary.reading = data.reading;
        newBookLibrary.unpacked = data.unpacked;
        newBookLibrary.loaned = data.loaned; 
        newBookLibrary.rating = data.rating || null; 
        const libraryRepo = connection.getRepository(Library); 
        newBookLibrary.library = await libraryRepo.findOne(data.library); 
        const bookRepo =  connection.getRepository(Book); 
        newBookLibrary.book = await bookRepo.findOne(data.book); 

        // write object to the database
        const savedBookLibrary = await bookLibraryRepo.save(newBookLibrary); 

        // return created library
        return savedBookLibrary; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }   
});

//create genre 

export const createGenre = functions.https.onCall(async (data: Genre, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const genreRepo = connection.getRepository(Genre); 

        // create new genre object
        const newGenre = new Genre();
        newGenre.name = data.name; 

        // write object to the database
        const savedGenre = await genreRepo.save(newGenre); 

        // return created genre
        return savedGenre; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }  
})

//delete genre
export const deleteGenre = functions.https.onCall(async (data: Genre, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const genreRepo = connection.getRepository(Genre); 

        // find genre to delete
        const delGenre = await genreRepo.findOne(data.id);

        // delete from database
        const deletedGenre = await genreRepo.delete(delGenre); 

        // return confirmation of deleted genre
        return deletedGenre; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }  
})

//delete user
export const deleteUser = functions.https.onCall(async (data: User, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const userRepo = connection.getRepository(User); 

        // get user to delete
        const delUser = await userRepo.findOne(data.id);

        // delete object from the database
        const deletedUser = await userRepo.delete(delUser); 

        // return confirmation of delete
        return deletedUser; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }  
})

//delete library
export const deleteLibrary = functions.https.onCall(async (data: Library, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const libRepo = connection.getRepository(Library); 

        // get library to delete
        const delLib = await libRepo.findOne(data.id);

        // delete object from the database
        const deletedLib = await libRepo.delete(delLib); 

        // return confirmation of delete
        return deletedLib; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }  
})

//delete book from library
export const deleteBookLibrary = functions.https.onCall(async (data: BookLibrary, context) => {

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const bookLibRepo = connection.getRepository(BookLibrary); 

        // get book in library to delete
        const delBookLib = await bookLibRepo.findOne(data.id);

        // delete object from the database
        const deletedBookLib = await bookLibRepo.delete(delBookLib); 

        // return confirmation of delete
        return deletedBookLib; 
    } 
    catch (err) { // catch and return errors
        return err; 
    }  
})

export const getLibraries = functions.https.onCall(async (data, context) => {
    // database connection
    const connection = await connect(); 

    // get repo
    const LibraryRepo = connection.getRepository(Library);

    // get all
    const libraries = await LibraryRepo.find(data.user); 

    // return books
    return libraries; 
});