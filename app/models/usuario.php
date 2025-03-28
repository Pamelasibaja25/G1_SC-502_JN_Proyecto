<?php
require_once '../../config/database.php';

class usuario
{
    public static function inicio($usuario, $password)
    {
        global $conn;
        session_destroy();

        // Buscar el usuario en la base de datos
        $sql = "SELECT password, id_usuario FROM usuario WHERE username = '$usuario'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $password_hash = $row['password'];

            // Verifica si la contraseña ingresada coincide con la almacenada (hash)
            if (password_verify($password, $password_hash)) {
                session_start();
                $_SESSION['usuario'] = $row['id_usuario'];
                return true; // Inicio de sesión exitoso
            }
        }

        return false; // Usuario no encontrado o contraseña incorrecta
    }

    public static function registro($new_username, $new_password, $new_nombre, $new_cedula, $new_fecha, $new_telefono, $new_encargado, $escuela, $grado)
    {
        global $conn;
        session_destroy();

        // Buscar el usuario en la base de datos
        $sql = "SELECT username FROM usuario WHERE username = '$new_username'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            return false;
        } else {
            $new_password = password_hash($new_password, PASSWORD_BCRYPT);
            $sql = "INSERT INTO usuario (username,password,nombre, telefono,ruta_imagen,activo) VALUES
            ('$new_username','$new_password','$new_nombre','$new_telefono',NULL,true)";
            $result = $conn->query($sql);

            $sql = "SELECT id_usuario FROM usuario WHERE username = '$new_username'";
            $result = $conn->query($sql);
            $row = $result->fetch_assoc();
            $new_username = $row['id_usuario'];

            $sql = "INSERT INTO rol (nombre, id_usuario) values
            ('ROLE_USER','$new_username')";
            $result = $conn->query($sql);

            $sql = "INSERT INTO proyecto.estudiante (id_usuario, cedula,fecha_nacimiento, encargado_legal,grado, id_escuela) VALUES
            ('$new_username','$new_cedula','$new_fecha','$new_encargado','$grado','$escuela')";
            $result = $conn->query($sql);

            return true;
        }
    }

}
?>