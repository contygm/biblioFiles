import { Entity, PrimaryGeneratedColumn, Column, BaseEntity } from "typeorm";

@Entity()
export class Book extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({
        length: 13,
        default: ""
    }) isbn13: string;

    @Column({
        length: 10, 
        default: ""
    }) isbn10: string; 

    @Column({
        default: null
    }) dewey: string;

    @Column() 
    title: string;

    @Column() 
    author: string;

    @Column({
        default: 0
    }) pages: number; 

    @Column({
        default: ""
    }) lang: string;

    @Column({
        default: ""
    }) image: string; 
}