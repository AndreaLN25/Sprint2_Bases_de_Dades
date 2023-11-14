db.clientes.insertMany([
    {
        _id_cliente: "Cliente1",
        Nombre:"NombreCliente1",
        Apellidos:"ApellidosCliente1",
        Direccion:{
            CodigoPostal:12345,
            Localidad:"Loc1",
            Provincia:"Provincia1",            
        },
        Telefono: 123456789,
    },
    {
        _id_cliente: "Cliente2",
        Nombre:"NombreCliente2",
        Apellidos:"ApellidosCliente2",
        Direccion:{
            CodigoPostal:11111,
            Localidad:"Loc2",
            Provincia:"Provincia2",            
        },
        Telefono: 11111111,
    },
    {
        _id_cliente: "Cliente3",
        Nombre:"NombreCliente3",
        Apellidos:"ApellidosCliente3",
        Direccion:{
            CodigoPostal:22222,
            Localidad:"Loc3",
            Provincia:"Provincia3",            
        },
        Telefono: 222222,
    },


])