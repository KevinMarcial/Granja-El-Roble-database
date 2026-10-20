
--Creacion de las tablas de acuerdo a nuestros atributos 

CREATE TABLE animal (id_identificador NUMBER (15),
                     Nombre VARCHAR2(50),
                     Especie VARCHAR2(50),
                     Raza varchar2(50),
                     Fecha_de_nacimiento  DATE );

--Tabla Corral 
CREATE TABLE corral ( id_Corral number (15),
                      Capacidad number (6),
                      ubicacion VARCHAR2(50),
                      tipo_de_corral VARCHAR2(50));
--TABLA ENCARGADO
CREATE TABLE encargado (id_encargado number(15),
                        nombre VARCHAR2 (50),
                        Apellido_pat VARCHAR2(50),
                        Apellido_Mat VARCHAR2(50),
                        Turno VARCHAR2(20),
                        Telfono NUMBER (10));                      
                        

--TABLA alimneto    
CREATE TABLE alimento (id_alimento number(15),
                       Nombre VARCHAR2(50),
                       Tipo VARCHAR2(50),
                       Cantidad_Disponible NUMBER(6),
                       Unidad_de_medida VARCHAR2(15),
                       Costo_por_unidad NUMBER(5,2));     
                    

--TABLA VETERINARIO                   
CREATE TABLE  veterinario (cedula NUMBER(20),
                          Nombre VARCHAR2(50),
                          Apellido_p VARCHAR2(20),
                          Apellido_m VARCHAR2(20),
                          Especialidad VARCHAR2 (50),
                          Telefono NUMBER (10));


--Visualizacion de tablas en su forma atomica
Describe animal;
describe corral;
describe encargado;
describe alimento;
describe veterinario;
                       
--Creacion de tablas relacion 

--Relacion AlimentoxAnimles


CREATE TABLE relacionAlimentoAnimales (id_identificador NUMBER (15),
                                       id_alimento number(15));
                                       
--Relacion VterinarioxAnimales
CREATE TABLE relacionVeterinariosAnimales (id_identificador NUMBER (15),
                                            cedula NUMBER(20));


--Asignacion de pk a cada de una de las tablas creadas

-- PK a tabla animal
ALTER TABLE animal ADD CONSTRAINT id_identificador_pk PRIMARY KEY (id_identificador);
describe animal;
--PK A tabla corral 
ALTER TABLE corral ADD CONSTRAINT id_Corral_pk PRIMARY KEY (id_Corral);

--Pk a tabla Encargado 
ALTER TABLE encargado ADD CONSTRAINT id_encargado_pk PRIMARY KEY (id_encargado);

--PK a tabla Veterinario
ALTER TABLE veterinario ADD CONSTRAINT cedula_pk PRIMARY KEY (cedula);

--PK a tabla Alimento
ALTER TABLE alimento ADD CONSTRAINT id_alimento_pk PRIMARY KEY (id_alimento);
describe alimento;
--Asiganacion de FK 

//Tablas que se relacionan 
--Animal 1:N Corral
ALTER TABLE animal add id_Corral NUMBER (15);
ALTER TABLE animal Add CONSTRAINT animal_corral_fk
FOREIGN KEY (id_Corral) REFERENCES corral (id_Corral);


--Relacion CORRAL ENCARGADO 1 : 1
ALTER TABLE encargado add id_Corral number (15);
ALTER TABLE encargado add CONSTRAINT encargado_corral_fk
FOREIGN key (id_Corral) REFERENCES corral (id_Corral);


//Tablas que surgen de una relacion N:M

--Relacion N:M AnIMALXALIMENTO
ALTER TABLE relacionAlimentoAnimales ADD CONSTRAINT animal_alimento_animal_fk
FOREIGN KEY (id_identificador) REFERENCES animal (Id_Identificador);

--Relacion N:M ALIMENTOXANIMAL 
ALTER TABLE relacionAlimentoAnimales  ADD CONSTRAINT alimento_animal_alimento_fk
FOREIGN KEY (id_alimento) REFERENCES alimento (id_alimento);


--Relacion N:M VeterinariosAnimales 
ALTER TABLE relacionVeterinariosAnimales ADD CONSTRAINT veterinario_animal_veterinario_fk
FOREIGN KEY (Cedula) REFERENCES veterinario (Cedula);

--Relacion N;M AnimalesVeterinario
ALTER TABLE relacionVeterinariosAnimales ADD CONSTRAINT animal_veterinario_animal_fk
FOREIGN KEY (id_identificador) REFERENCES animal (id_identificador);

--implementacion de not nul
--Not null para la tabla animal 
 ALTER TABLE animal modify  Raza varchar2(50) constraint
      animal_Raza_nn not null;
     
      
--Not null dentro de la tabla corral 
ALTER TABLE corral modify  ubicacion VARCHAR2(50) constraint
      corral_ubicacion_nn not null;
      
--Not null dentro de la tabla encargado
ALTER TABLE encargado modify Telfono NUMBER (10) constraint
      encargado_Telefono_nn not null;
      
--Not Null en la tabla alimento 
ALTER TABLE alimento modify Tipo VARCHAR2(50) CONSTRAINT 
     alimento_Tipo_nn not null;

--Not null en tabla veterinario
ALTER TABLE veterinario modify Especialidad VARCHAR2 (50) CONSTRAINT
      veterinario_Especialidad_nn not null;

--Implemtacion de check
--check en la tabla corral para verificar la cantidad de animales al ingresar uno nuevo 
ALTER TABLE corral ADD CONSTRAINT corral_capacidad 
            CHECK (Capacidad > 0 AND Capacidad < 800);
            
            
--CHECK en la tabla alimento 
ALTER TABLE alimento ADD CONSTRAINT alimento_cantidad
          CHECK (Cantidad_Disponible >= 0);

--Implementacion de datos unicos "UNIQUE"
--dato unico en tabla veterinario
ALTER TABLE veterinario  add constraint veterinario_telefono_uq unique (telefono);

--dato unico en tabla alimento 
ALTER TABLE alimento  add constraint alimento_nombre_uq unique (nombre);


--Implementacion de rename 

--Rame en la tabla alimento por comida
rename alimento to comida;
describe comida;

--Implementacion de drop en la columna telefono en la tabla encargado 
ALTER TABLE encargado DROP COLUMN   Telfono;

describe encargado;

describe encargado;


--visualizacion de tablas finales 
--Tabla animal 
SELECT constraint_name, constraint_type, search_condition, status 
FROM user_constraints 
WHERE table_name = 'ANIMAL';

--Tabla corral 
SELECT constraint_name, constraint_type, search_condition, status 
FROM user_constraints 
WHERE table_name = 'CORRAL';

--tabla encargado
SELECT constraint_name, constraint_type, search_condition, status 
FROM user_constraints 
WHERE table_name = 'ENCARGADO';

--tabla comida "alimento"
SELECT constraint_name, constraint_type, search_condition, status 
FROM user_constraints 
WHERE table_name = 'COMIDA';

--tabla veterinario
SELECT constraint_name, constraint_type, search_condition, status 
FROM user_constraints 
WHERE table_name = 'VETERINARIO';

--tabla relacionAlimentoAnimales
SELECT constraint_name, constraint_type, search_condition, status 
FROM user_constraints 
WHERE table_name = 'RELACIONALIMENTOANIMALES';

--tabla relacionveterinarioanimal
SELECT constraint_name, constraint_type, search_condition, status 
FROM user_constraints 
WHERE table_name = 'RELACIONVETERINARIOSANIMALES';


Describe animal;
describe corral;
describe encargado;
describe comida;
describe veterinario;

//inserccion de datos a la tabla animal 

INSERT INTO animal VALUES (1, 'Luna', 'Vaca', 'Holstein', TO_DATE('15/03/2022', 'DD/MM/YYYY'), 1);
INSERT INTO animal VALUES (2, 'Azabache', 'Toro', 'Angus', TO_DATE('20/06/2021', 'DD/MM/YYYY'), 2);
INSERT INTO animal VALUES (3, 'Cochi', 'Cerdo', 'Yorkshire', TO_DATE('10/01/2023', 'DD/MM/YYYY'), 3);
INSERT INTO animal VALUES (4, 'Nube', 'Oveja', 'Merino', TO_DATE('05/09/2022', 'DD/MM/YYYY'), 4);
INSERT INTO animal VALUES (5, 'Canela', 'Cabra', 'Boer', TO_DATE('12/12/2023', 'DD/MM/YYYY'), 5);
INSERT INTO animal VALUES (6, 'Moro', 'Caballo', 'Cuarto de Milla', TO_DATE('18/04/2020', 'DD/MM/YYYY'), 6);
INSERT INTO animal VALUES (7, 'Manchada', 'Vaca', 'Jersey', TO_DATE('22/07/2021', 'DD/MM/YYYY'), 7);
INSERT INTO animal VALUES (8, 'Porky', 'Cerdo', 'Duroc', TO_DATE('08/11/2022', 'DD/MM/YYYY'), 8);
INSERT INTO animal VALUES (9, 'Blanquita', 'Oveja', 'Suffolk', TO_DATE('14/02/2023', 'DD/MM/YYYY'), 9);
INSERT INTO animal VALUES (10, 'Canelo', 'Toro', 'Hereford', TO_DATE('30/08/2020', 'DD/MM/YYYY'), 10);


select * from animal;

--- Ingresamos los datos del corral
INSERT INTO corral VALUES (1, 20, 'Pasillo 1 ', 'Bovino');
INSERT INTO corral VALUES (2, 15, 'Pasillo 2', 'Bovino');
INSERT INTO corral VALUES (3, 25, 'Pasillo 3', 'Porcino');
INSERT INTO corral VALUES (4, 18, 'Pasillo 4', 'Ovino');
INSERT INTO corral VALUES (5, 12, 'Pasillo 5', 'Caprino');
INSERT INTO corral VALUES (6, 10, 'Pasillo 6', 'Equino');
INSERT INTO corral VALUES (7, 20, 'Pasillo 7', 'Bovino');
INSERT INTO corral VALUES (8, 25, 'Pasillo 8', 'Porcino');
INSERT INTO corral VALUES (9, 15, 'Pasillo 9', 'Ovino');
INSERT INTO corral VALUES (10, 20,'Pasillo 10', 'Bovino');


SELECT * FROM corral;


-- Insercion de datos en la tabla ENCARGADO

INSERT INTO encargado VALUES (1, 'Carlos', 'Ramirez', 'Lopez', 'Matutino', 1);
INSERT INTO encargado VALUES (2, 'Jose', 'Hernandez', 'Garcia', 'Vespertino', 2);
INSERT INTO encargado VALUES (3, 'Miguel', 'Sanchez', 'Torres', 'Matutino', 3);
INSERT INTO encargado VALUES (4, 'Luis', 'Martinez', 'Flores', 'Nocturno', 4);
INSERT INTO encargado VALUES (5, 'Pedro', 'Gonzalez', 'Perez', 'Matutino', 5);
INSERT INTO encargado VALUES (6, 'Jorge', 'Diaz', 'Morales', 'Vespertino', 6);
INSERT INTO encargado VALUES (7, 'Francisco', 'Cruz', 'Reyes', 'Nocturno', 7);
INSERT INTO encargado VALUES (8, 'Roberto', 'Jimenez', 'Castillo', 'Matutino', 8);
INSERT INTO encargado VALUES (9, 'Fernando', 'Ortiz', 'Ramirez', 'Vespertino', 9);
INSERT INTO encargado VALUES (10, 'Alejandro', 'Mendoza', 'Vargas', 'Nocturno', 10);

select * from encargado;


-- Insercion de datos en la tabla COMIDA (alimneto)

INSERT INTO comida VALUES (1, 'Alfalfa', 'Forraje', 500, 'Kilogramos', 8.50);
INSERT INTO comida VALUES (2, 'Maiz', 'Grano', 350, 'Kilogramos', 6.80);
INSERT INTO comida VALUES (3, 'Avena', 'Grano', 200, 'Kilogramos', 7.20);
INSERT INTO comida VALUES (4, 'Pasto', 'Forraje', 600, 'Kilogramos', 3.50);
INSERT INTO comida VALUES (5, 'Sorgo', 'Grano', 300, 'Kilogramos', 5.90);
INSERT INTO comida VALUES (6, 'Sal mineral', 'Suplemento', 80, 'Kilogramos', 12.50);
INSERT INTO comida VALUES (7, 'Heno', 'Forraje', 250, 'Pacas', 45.00);
INSERT INTO comida VALUES (8, 'Concentrado bovino', 'Concentrado', 150, 'Kilogramos', 9.80);
INSERT INTO comida VALUES (9, 'Salvado de trigo', 'Suplemento', 120, 'Kilogramos', 6.40);
INSERT INTO comida VALUES (10, 'Alimento porcino', 'Concentrado', 180, 'Kilogramos', 10.50);

select * from comida;
describe comida;


-- Insercion de datos en la tabla VETERINARIO

INSERT INTO veterinario VALUES (123456789012, 'Adrian', 'Ramirez', 'Lopez', 'Bovinos', 7121234567);
INSERT INTO veterinario VALUES (987654321098, 'Roberto', 'Hernandez', 'Garcia', 'Bovinos', 7121234568);
INSERT INTO veterinario VALUES (202410583729, 'Miguel', 'Sanchez', 'Torres', 'Porcinos', 7121234569);
INSERT INTO veterinario VALUES (456789123456, 'Luis', 'Martinez', 'Flores', 'Ovinos', 7121234570);
INSERT INTO veterinario VALUES (315802746195, 'Pedro', 'Gonzalez', 'Perez', 'Caprinos', 7121234571);
INSERT INTO veterinario VALUES (789123456201, 'Jorge', 'Diaz', 'Morales', 'Equinos', 7121234572);
INSERT INTO veterinario VALUES (202309817456, 'Francisco', 'Cruz', 'Reyes', 'Bovinos', 7121234573);
INSERT INTO veterinario VALUES (654209183765, 'Carlos', 'Jimenez', 'Castillo', 'Porcinos', 7121234574);
INSERT INTO veterinario VALUES (202512764839, 'Fernando', 'Ortiz', 'Ramirez', 'Ovinos', 7121234575);
INSERT INTO veterinario VALUES (891273640512, 'Alejandro', 'Mendoza', 'Vargas', 'Medicina veterinaria general', 7121234576);

select * from veterinario;


-- Relacion N:M entre ANIMAL y COMIDA
--insercion de datos a relacionAlimentoAnimal N:M 
INSERT INTO relacionAlimentoAnimales VALUES (1, 1);
INSERT INTO relacionAlimentoAnimales VALUES (1, 2);
INSERT INTO relacionAlimentoAnimales VALUES (2, 1);
INSERT INTO relacionAlimentoAnimales VALUES (2, 2);
INSERT INTO relacionAlimentoAnimales VALUES (3, 10);
INSERT INTO relacionAlimentoAnimales VALUES (4, 7);
INSERT INTO relacionAlimentoAnimales VALUES (5, 4);
INSERT INTO relacionAlimentoAnimales VALUES (6, 3);
INSERT INTO relacionAlimentoAnimales VALUES (7, 1);
INSERT INTO relacionAlimentoAnimales VALUES (8, 10);
INSERT INTO relacionAlimentoAnimales VALUES (9, 7);
INSERT INTO relacionAlimentoAnimales VALUES (10, 2);

select * from relacionAlimentoAnimales;

-- Relacion N:M entre ANIMAL y veterinario
--insercion de datos a relacion animal veterinario N:M 


 describe relacionVeterinariosAnimales;
 
-- Relacion N:M entre ANIMAL y VETERINARIO
--Insercion de datos ala tabla relacion animalveterinario
INSERT INTO relacionVeterinariosAnimales VALUES (1, 123456789012);
INSERT INTO relacionVeterinariosAnimales VALUES (1, 202309817456);
INSERT INTO relacionVeterinariosAnimales VALUES (2, 123456789012);
INSERT INTO relacionVeterinariosAnimales VALUES (2, 987654321098);
INSERT INTO relacionVeterinariosAnimales VALUES (3, 202410583729);
INSERT INTO relacionVeterinariosAnimales VALUES (3, 654209183765);
INSERT INTO relacionVeterinariosAnimales VALUES (4, 456789123456);
INSERT INTO relacionVeterinariosAnimales VALUES (4, 202512764839);
INSERT INTO relacionVeterinariosAnimales VALUES (5, 315802746195);
INSERT INTO relacionVeterinariosAnimales VALUES (5, 891273640512);
INSERT INTO relacionVeterinariosAnimales VALUES (6, 789123456201);
INSERT INTO relacionVeterinariosAnimales VALUES (6, 891273640512);
INSERT INTO relacionVeterinariosAnimales VALUES (7, 123456789012);
INSERT INTO relacionVeterinariosAnimales VALUES (7, 202309817456);
INSERT INTO relacionVeterinariosAnimales VALUES (8, 202410583729);
INSERT INTO relacionVeterinariosAnimales VALUES (8, 654209183765);
INSERT INTO relacionVeterinariosAnimales VALUES (9, 456789123456);
INSERT INTO relacionVeterinariosAnimales VALUES (9, 202512764839);
INSERT INTO relacionVeterinariosAnimales VALUES (10, 987654321098);
INSERT INTO relacionVeterinariosAnimales VALUES (10, 123456789012);

select * from relacionveterinariosanimales;

COMMIT;

--PASO 2
-- SENTENCIAS UPDATE IMPLEMENTANDO WHERE 
-- 1. Actualizar la raza del animal Luna
UPDATE animal SET raza = 'Holstein Friesian' WHERE id_identificador = 1;
-- Verificar
SELECT * FROM animal WHERE id_identificador = 1;


-- 2. Actualizar la capacidad del corral 1
UPDATE corral SET capacidad = 30 WHERE id_corral = 1;
-- Verificar
SELECT * FROM corral WHERE id_corral = 1;


-- 3. Actualizar el turno del encargado 1
UPDATE encargado SET turno = 'Vespertino' WHERE id_encargado = 1;
-- Verificar
SELECT * FROM encargado WHERE id_encargado = 1;


-- 4. Actualizar la cantidad disponible de Alfalfa
UPDATE comida SET cantidad_disponible = 450 WHERE id_alimento = 1;
-- Verificar
SELECT * FROM comida WHERE id_alimento = 1;


-- 5. Actualizar la especialidad del veterinario
UPDATE veterinario SET especialidad = 'Medicina de bovinos' WHERE cedula = 123456789012;
-- Verificar
SELECT * FROM veterinario WHERE cedula = 123456789012;

--Parte III 
--Implementando la sentencia DELETE para elimar registros 

-- 1. Eliminar el animal con ID 10
DELETE FROM animal WHERE id_identificador = 10;

--Verificamos si hay dependenciaas del registro a eliminar
SELECT * FROM relacionveterinariosanimales WHERE id_identificador = 10;

--Eliminamos la relacion existente con el registro 
DELETE FROM relacionveterinariosanimales WHERE id_identificador = 10;
DELETE FROM relacionalimentoanimales WHERE id_identificador = 10;

-- Verificar que el registro se haya eliminado
SELECT * FROM animal WHERE id_identificador = 10;


-- 2. Eliminar el veterinario con cédula 891273640512
DELETE FROM veterinario WHERE cedula = 891273640512;

--Eliminamos relaciones correpondientes nuestro registros
DELETE FROM relacionveterinariosanimales WHERE cedula = 891273640512;

-- Verificar que el registro se haya eliminado
SELECT * FROM veterinario WHERE cedula = 891273640512;



//Verificacion de nformacion insertada 
select * from animal;
select * from corral;
select * from encargado;
select * from comida;
select * from veterinario;


//Implementacion del sentencia where 
// Mostramos datos (animlaes) que coincidan con las siguinetes razas
SELECT * FROM Animal where (raza) in ('Duroc' , 'Merino', 'Angus', 'Cuarto de Milla'); 

// sentencia where con compuerta or en la tabla encragado 
SELECT * FROM encargado where apellido_pat = 'Sanchez' or apellido_pat = 'Perez';

--SENTENCIA WHERE CON AND en la tabla alimento  
SELECT * FROM comida where cantidad_disponible > 300 AND costo_por_unidad > 2.5;


//SENTENCIA DE ORDER BY 
SELECT * FROM veterinario ORDER BY NOMBRE ASC;

//SENETNCIA ORDER BY 
SELECT * FROM COMIDA ORDER BY CANTIDAD_DISPONIBLE DESC;

//SENTENCIA COUNT 
 SELECT COUNT (*) as total_de_registros from veterinario;
 
 //SENTENCIA SUM 
 SELECT SUM (capacidad) as Capcidad_total_de_la_granja_para_alvergar_animales from corral;
 
 //sentencia AVG
SELECT AVG (capacidad) as Promedio_de_la_capacidad_de_los_corrales from corral;

//Sentencia MAX
Select max (capacidad) as corral_con_mayor_capacidad from corral;

//SENTENCIA MIN 
SELECT MIN (Capacidad) as corral_con_menos_capacidad from corral;

//Sentencia GROUP BY - HEAVING
--SENETENCIA IMPLEMENTAR
--SELECT columna, FUNCION_AGREGADA(columna) FROM nombre_tabla GROUP BY columna HAVING condicion;
SELECT especie, COUNT (*) AS total_de_especies_registradas FROM animal GROUP BY especie HAVING COUNT(*) >  1;

//Sentencia GROUP BY - HEAVING 
SELECT  Especialidad, COUNT(*) as medicos FROM veterinario GROUP BY especialidad HAVING especialidad in  ('Bovinos', 'Equinos');

select * from veterinario;












