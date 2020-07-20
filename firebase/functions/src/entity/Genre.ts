import { Entity, PrimaryGeneratedColumn, Column, BaseEntity} from "typeorm";

@Entity() 
export class Genre extends BaseEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column() 
    name: string; 

}
