pragma solidity ^0.4.24;

contract UsersContract {

    //Creamos una estructura dentro de nuestro contrato
    struct User {
        string name;
        string surName;
    }


    //Tipo de dato mapping (clave, valor)
    mapping (address => User) private users;
    mapping (address => bool) private joinedUsers;

    //Declaramos un arreglo para determinar cuantos usuarios se han registrado
    address[] total;

    //Declaramos una variable de tipo eventos, para mostrar una notificación
    event onUserJoined(address, string);


    //Función para registrar un usuario
    function join(string name, string surName) public {
        require(!userJoined(msg.sender)); //Si el usuario no se ha registrado lo registramos

        //PROCESO DE REGISTRO DE USUARIO

        //Las variables de tipo storage funcionan como si fuese un hard drive o almacenamiento secundario
        User storage user = users[msg.sender];
        user.name = name;
        user.surName = surName;
        joinedUsers[msg.sender] = true;
        total.push(msg.sender); //Agregamos el usuario en el arreglo

        //Al finalizar el registro del usuario invocamos el evento
        //Mostrando su dirección y sus datos
        onUserJoined(msg.sender, string(abi.encodePacked(name, " ", surName)));

    }

    //Función para devolver los datos de un usuario, pasando como argumento su dirección
    function getUser(address addr) public view returns (string,string) {
        require(userJoined(msg.sender)); //Si el usuario ya está registrado, devolvemos los datos

        //DATOS A DEVOLVER

        //La variable memory es volátil, funciona como la RAM
        User memory user = users[addr];
        return (user.name, user.surName);
    }

    //Determina true si un usuario ya se ha unido,
    function userJoined(address addr) private view returns (bool){
        return joinedUsers[addr];
    }

    //Retorna la cantidad de usuarios registrados
    function totalUsers() public view returns(uint){
        return total.length;
    }


}