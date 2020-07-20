import { Entity, PrimaryGeneratedColumn, Column, BaseEntity, OneToMany, ManyToOne} from "typeorm"; 
import { BookLibrary } from "./BookLibrary";
import { User } from "./User";

@Entity()
export class Library extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column() 
    name: string;
    
    @OneToMany(type => BookLibrary, bookLibrary => bookLibrary.library)
    bookLibrary: BookLibrary[]; 

    @ManyToOne (type => User, user => user.library, {onDelete: "CASCADE"})
    user: User;
}