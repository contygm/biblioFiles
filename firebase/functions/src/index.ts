import * as functions from 'firebase-functions';
import { connect } from './config'; 

import { Book } from './entity/Book';
 

// create a book
export const createBook = functions.https.onCall(async (data, context) => {
    // get passed data
    const { title, author } = data;

    try {
        // get database connection
        const connection = await connect(); 

        // get repo
        const bookRepo = connection.getRepository(Book); 

        // create new book object
        const newBook = new Book();
        newBook.title = title; 
        newBook.author = author; 

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
export const getBooks = functions.https.onCall(async (data, context) => {
    // database connection
    const connection = await connect(); 

    // get repo
    const bookRepo = connection.getRepository(Book);

    // get all
    const allBooks = await bookRepo.find(); 

    // return books
    return allBooks; 
});