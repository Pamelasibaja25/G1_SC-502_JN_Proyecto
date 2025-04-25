drop schema if exists proyecto; 
drop user if exists grupo10; 
CREATE SCHEMA proyecto ; 

create user 'grupo10'@'%' identified by 'grupo10'; 

grant all privileges on proyecto.* to 'grupo10'@'%'; 
flush privileges;
CREATE TABLE proyecto.usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  password varchar(512) NOT NULL,
  nombre VARCHAR(2000) NOT NULL,
  telefono VARCHAR(15) NULL,
  ruta_imagen varchar(1024),
  activo boolean,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table proyecto.curso (
  id_curso INT NOT NULL AUTO_INCREMENT,
  descripcion  VARCHAR(1600),
  grado  VARCHAR(15),
  detalle VARCHAR(1600),
  ruta_imagen varchar(1024),
  estado  VARCHAR(15),
id_usuario INT,
  PRIMARY KEY (id_curso),
  foreign key fk_usuario_id (id_usuario) references usuario(id_usuario)  )
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;

create table proyecto.tema (
  id_tema INT NOT NULL AUTO_INCREMENT,
  id_curso INT NOT NULL,
  nombre  VARCHAR(1600),
  informacion VARCHAR(1600),
  PRIMARY KEY (id_tema),
  foreign key fk_tema_curso (id_curso) references curso(id_curso)  
  )
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;

create table proyecto.rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol),
  foreign key fk_rol_usuario (id_usuario) references usuario(id_usuario)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table proyecto.escuela (
  id_escuela INT NOT NULL AUTO_INCREMENT,
  descripcion  VARCHAR(1600),
  PRIMARY KEY (id_escuela)
  )
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;

create table proyecto.estudiante (
  id_estudiante INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_escuela INT NOT NULL,
  cedula VARCHAR(50),
  fecha_nacimiento date,
  encargado_legal  VARCHAR(1600),
  grado VARCHAR(50),
  PRIMARY KEY (id_estudiante),
  foreign key fk_id_usuario (id_usuario) references usuario(id_usuario),  
  foreign key fk_id_escuela (id_escuela) references escuela(id_escuela)
  )
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;

create table proyecto.nota (
  id_nota INT NOT NULL AUTO_INCREMENT,
  id_estudiante INT NOT NULL,
  id_curso INT NOT NULL,
  nota int,
  fecha_inicio_trimestre date,
  fecha_final_trimestre date,
  PRIMARY KEY (id_nota),
  foreign key fk_id_estudiante (id_estudiante) references estudiante(id_estudiante),  
  foreign key fk_id_curso (id_curso) references curso(id_curso)  
  )
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO proyecto.usuario (id_usuario, username,password,nombre, telefono,ruta_imagen,activo) VALUES 
(1,'Pamela','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Pamela Sibaja Torres',    '4556-8978', 'https://upload.wikimedia.org/wikipedia/commons/0/06/Photo_of_Rebeca_Arthur.jpg',true),
(2,'Jexon','$2y$10$j473As2lZKsHNNpT6QrMA.iiUjOvZrrlLY.ytPj2W04Hz2.OWMJQS',' Jexon Salazar Cruz', '5456-8789','https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Juan_Diego_Madrigal.jpg/250px-Juan_Diego_Madrigal.jpg',true),
(3,'Fabiola','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Fabiola Yorleni Linarte Rubio',      '7898-8936','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Eduardo_de_Pedro_2019.jpg/480px-Eduardo_de_Pedro_2019.jpg?20200109230854',true),
(4,'','','', '', '',false);

INSERT INTO proyecto.escuela (id_escuela,
  descripcion) VALUES 
(1,'Miguel Hidalgo Bastos'),
(2,'Juan Santamaría');

INSERT INTO proyecto.estudiante (id_estudiante,id_usuario, cedula,fecha_nacimiento, encargado_legal,grado, id_escuela) VALUES 
(1,1,'1-7823-4596','2002-02-25', 'Silvia Quesada','Primero', 1),
(2,2,'1-9820-7852','2002-03-21', 'Marta Rodiguez','Primero', 1);

INSERT INTO proyecto.curso (id_curso,
  descripcion,
  grado,
  detalle,
  ruta_imagen,estado,id_usuario)

VALUES
(1,'Inglés', 'Primero', 'Explicación de los colores y numeros en inglés', 'https://cdni.iconscout.com/illustration/premium/thumb/aprender-ingles-en-linea-5526241-4609639.png', 'En Progreso',2),
(2,'Español', 'Primero', 'Explicación de los colores y numeros en español', 'https://i.pinimg.com/564x/38/ff/ab/38ffab95a3d4f8aa6a1d9f3ec937e7e7.jpg','En Progreso',2),
(3,'Matemáticas', 'Primero', 'Explicación de suma y Restas', 'https://static.vecteezy.com/system/resources/previews/003/763/900/non_2x/math-formula-on-blackboard-isolated-free-vector.jpg','En Progreso',2),
(4,'Ciencias', 'Primero', 'Nombres del cuerpo humano', 'https://www.educaciontrespuntocero.com/wp-content/uploads/2022/10/semana-de-la-ciencia.jpg','Finalizado',2),
(5,'Estudios Sociales', 'Primero', 'Explicación de geografía de Costa Rica', 'https://www.pngkey.com/png/detail/117-1175286_estudios-sociales-png.png','Disponible',4),
(6,'Mandarín', 'Primero', 'Explicación de los colores y numeros en Mandarín', 'https://img.freepik.com/vector-premium/concepto-aprendizaje-idioma-chino-escuela-idiomas-chino_277904-16098.jpg','Disponible',4);

insert into proyecto.nota (id_nota,
  id_estudiante,
  id_curso,
  nota,
  fecha_inicio_trimestre,
  fecha_final_trimestre) values
 (1,2,4,90,'2023-03-01','2023-05-01'),
 (2,2,4,95,'2023-06-01','2023-08-01'),
 (3,2,4,98,'2023-09-01','2023-11-01'),
 (4,2,3,90,'2025-03-01','2025-05-01'),
 (5,2,3,95,'2025-06-01','2025-08-01'),
 (6,2,3,NULL,'2025-09-05',NULL);
 
INSERT INTO proyecto.tema (id_tema,id_curso,
  nombre,
  informacion)
VALUES
(1,1,'Colors', 'Primero'),
(2,2,'Palabras con A', 'Primero'),
(3,3,'Suma', 'Primero'),
(4,5,'Simbolos Nacionales', 'Primero'),
(5,1,'Numbers', 'Primero');

insert into proyecto.rol (id_rol, nombre, id_usuario) values
 (1,'ROLE_ADMIN',3),(2,'ROLE_USER',1),(3,'ROLE_USER',2);

