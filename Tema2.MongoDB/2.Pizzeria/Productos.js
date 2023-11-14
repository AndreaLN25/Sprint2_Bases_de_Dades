
db.createCollection( 'Productos', {validator: {$jsonSchema: {bsonType: 'object',title:'Productos',required: [         'Nombre',          'Descripcion',          'Precio',          'Categoria'],properties: {Nombre: {bsonType: 'string'},Descripcion: {bsonType: 'string'},Imagen: {bsonType: 'string'},Precio: {bsonType: 'double'}},
patternProperties: {"Categoria": {bsonType: 'array',items: {
title:'object',properties: {id_Categoria: {bsonType: 'int'},Nombre: {bsonType: 'string'}}}}}         }      }});  