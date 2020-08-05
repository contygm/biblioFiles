import { Entity, Column, BaseEntity, OneToMany, PrimaryColumn } from "typeorm";
import { Library } from "./Library";

@Entity()
export class User extends BaseEntity {
    @PrimaryColumn()
    id: string;

    @Column() 
    username: string;

    @Column() 
    email: string;
    
    @Column()
    photoURL: string;

    @OneToMany(type => Library, library => library.user)
    library: Library[]; 

}