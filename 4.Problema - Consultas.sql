4. (Obligatorio) Considerando una tabla de alumnos con los datos del primer punto y la tabla materia (título, profesor, horario, periodo, activo).
a.       Proponer las modificaciones necesarias para generar una base de datos para registrar los alumnos inscritos a cada materia.
--- La primer modificacion seria crear el diagrama relacional necesario para este proceso. Para una mejor eficiencia en el esquema, 
--- propongo crear una tercera tabla que contenga la relacion (llaves primarias) entre Alumnos y Materias. 
	-- Una materia tiene muchos alumnos .... y un alumno puede ser registrado en diversas materias.

--- La segunda modificacion sera agregar una llave primaria a la tabla de Materia para una mejor adminsitracion de los registros.

--- La tercera modificacion seria mejorar el campo  de "horario" de modo que sea un horaro de inicio y horario de fin para esa mataria con ese alumno
--- y trasladar este campo a la tercer tabla creada.

-- Tabla de Alumnos: RFC (PK), Nombre, apPat, apMat, FechaNac, Activo, Genero
-- Tabla Materias: ID (PK), titulo, profesor,  periodo, activo
-- Tabla Mat_Alumno: RFC (FK), ID (FK), horaIni, horaFin

b.       Realizar la sentencia en SQL para obtener:
	I.Todos los alumnos de apellido paterno "Guzmán" inscritos en "Cálculo Diferencial" a las 8:00 am.

	SELECT * FROM Alumnos A
	INNER JOIN MatAlumno MA on MA.RFC = A.RFC
	INNER JOIN Materias M on M.ID = MA.ID
	WHERE A.apPat LIKE '&Guzman&' AND M.titulo = 'Cálculo Diferencial' AND horaIni = '08:00'

	II.Las materias con más de 15 alumnos inscritos en el turno matutino (hasta medio día).

	SELECT M.titulo, count(ma.rfc) as TotalAlumnos FROM Materias M
	INNER JOIN MatAlumno MA on MA.ID = M.ID
	WHERE horaIni between '07:00' AND '12:00'
	GROUP BY M.Titulo
	HAVING count(ma.rfc) > 15

	III.Los alumnos inscritos en grupos con menos de 10 alumnos (incluir nombre de la materia).

	SELECT A.nombre as Alumno, M.Titulo as Materia from Alumnos A
	INNER JOIN MatAlumno MA on MA.rfc = A.rfc
	INNER JOIN Materias1 M on M.ID = MA.ID
	GROUP BY M.Titulo, A.nombre
	having count(ma.rfc) < 10
	ORDER BY M.titulo