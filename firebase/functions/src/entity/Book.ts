import { Entity, PrimaryGeneratedColumn, Column, BaseEntity, OneToMany,} from "typeorm";
import { BookLibrary } from "./BookLibrary";

@Entity()
export class Book extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({
        length: 13, 
        nullable: true
    }) isbn13: string;

    @Column({
        length: 10, 
        nullable: true
    }) isbn10: string; 

    @Column({
        nullable: true}) 
    dewey: string;

    @Column() 
    title: string;

    @Column() 
    author: string;

    @Column({
        default: 0, 
        nullable: true
    }) pages: number; 

    @Column({
        nullable: true
    }) 
    lang: string;

    @Column({
        nullable: true
    }) 
    image: string; 
   
    @OneToMany(type => BookLibrary, bookLibrary => bookLibrary.book)
    bookLibrary: BookLibrary[]; 


}