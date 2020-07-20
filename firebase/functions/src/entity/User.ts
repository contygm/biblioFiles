import { Entity, PrimaryGeneratedColumn, Column, BaseEntity, OneToMany } from "typeorm";
import { Library } from "./Library";

@Entity()
export class User extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column() 
    username: string;

    @Column() 
    email: string; 

    @OneToMany(type => Library, library => library.user)
    library: Library[]; 

}