import { ConnectionOptions, Connection, createConnection, getConnection } from "typeorm";

import 'reflect-metadata';

export const prod = process.env.NODE_ENV === 'production';

export const config: ConnectionOptions = {
    name: 'fun', 
    type: 'mysql',
    host: '127.0.0.1', 
    port: 3306, 
    username: 'root', 
    password: 'LlCBllijbi1NyhPn', 
    database: 'development', 
    synchronize: true, 
    logging: false, 
    entities: [
        'lib/entity/**/*.js'
    ],

    // production mode
    ...(prod && {
        database: 'production', 
        logging: false,
        extra: {
            socketPath: '/cloudsql/cs467-bibliofiles:us-west1:cs467-bibliofiles-mysql'
        },
    })
};

export const connect = async () => {
    let connection: Connection;

    try {
        connection = getConnection(config.name);
    } 
    catch(err) {
        connection = await createConnection(config); 
    }

    return connection; 
}
