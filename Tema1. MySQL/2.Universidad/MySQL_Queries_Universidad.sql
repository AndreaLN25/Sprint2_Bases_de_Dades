SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno'AND telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND RIGHT(persona.nif,1)='K';
SELECT nombre, curso, cuatrimestre, id_grado FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona, profesor, departamento WHERE persona.id = profesor.id_profesor AND profesor.id_departamento = departamento.id AND persona.tipo = 'profesor'ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
SELECT persona.apellido1, persona.apellido2, persona.nombre, asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona, asignatura, curso_escolar, alumno_se_matricula_asignatura WHERE persona.id = alumno_se_matricula_asignatura.id_alumno AND alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id AND persona.tipo = 'alumno' AND persona.nif = '26902806M';
SELECT DISTINCT departamento.nombre AS nombre_departamento, grado.nombre AS nombre_asignatura FROM grado, departamento, asignatura, profesor WHERE departamento.id = profesor.id_departamento AND profesor.id_profesor = asignatura.id_profesor AND asignatura.id_grado = grado.id AND grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)'; 
SELECT DISTINCT persona.apellido1, persona.apellido2, persona.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona, alumno_se_matricula_asignatura, curso_escolar WHERE persona.id = alumno_se_matricula_asignatura.id_alumno  AND curso_escolar.anyo_inicio = '2018' AND curso_escolar.anyo_fin = '2019';

SELECT departamento.nombre AS nombre_departamento, persona.apellido1, persona.apellido2, persona.nombre AS nombre_profesor FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON profesor.id_profesor = persona.id ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
SELECT persona.apellido1, persona.apellido2, persona.nombre AS nombre_profesor, profesor.id_profesor FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor WHERE profesor.id_departamento IS NULL;
SELECT departamento.nombre AS nombre_departamento FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_departamento IS NULL;
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id IS NULL;
SELECT asignatura.nombre, asignatura.id_profesor FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE profesor.id_profesor IS NULL;
SELECT  DISTINCT departamento.nombre AS nombre_departamento FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

-- CONSULTES RESUM -- 


SELECT COUNT(id) AS total_alumnos from persona WHERE tipo = 'alumno';
SELECT COUNT(id) AS total_alumnos from persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;
SELECT departamento.nombre, COUNT(persona.id) AS total_profesores FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON persona.id = profesor.id_profesor GROUP BY departamento.nombre ORDER BY total_profesores DESC; 
SELECT departamento.nombre, COUNT(profesor.id_profesor) AS total_profesores FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY total_profesores DESC;
SELECT grado.nombre, COUNT(asignatura.id) AS total_asignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado  GROUP BY grado.nombre ORDER BY total_asignaturas DESC;
SELECT grado.nombre, COUNT(asignatura.id) AS total_asignaturas FROM grado JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING total_asignaturas > 40;
SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos) AS total_asignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;
SELECT curso_escolar.anyo_inicio, COUNT(DISTINCT alumno_se_matricula_asignatura.id_alumno) AS total_alumnos_matriculados FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS total_asignaturas FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2 ORDER BY total_asignaturas DESC;
SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2 FROM persona JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE profesor.id_departamento IS NOT NULL AND asignatura.id IS NULL;