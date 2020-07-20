import { Entity, Column, ManyToOne, BaseEntity, PrimaryGeneratedColumn } from "typeorm";
import { Book } from "./Book";
import { Library } from "./Library";

@Entity()
export class BookLibrary extends BaseEntity {
    @PrimaryGeneratedColumn()
        id:number;
    
    @Column({
        nullable: true}) 
    user_note: string;
    
    @Column() 
    private_book: boolean;

    @Column() 
    loanable: boolean;

    @Column() 
    reading: boolean;

    @Column() 
    loaned: boolean;

    @Column() 
    unpacked: boolean;

    @Column({
        nullable: true}) 
    rating: number;

    @ManyToOne (type => Library, library => library.bookLibrary, {onDelete: "CASCADE"})
    library: Library;

    @ManyToOne (type => Book, book => book.bookLibrary, {onDelete: "CASCADE"})
    book: Book;

}