# Prueba-N3-Awakelab
Base de datos

En el diseño del modelo físico de la base de datos se establece crear aparte de las tablas exigidas en la rúbrica la entidad CURSO, ESTUDIANTE, y RESPUESTAS. Se establece la relacion de muchos a muchos entre CURSO y ESTUDIANTE y en la tabla RESPUESTAs se almacenarán   por medio de relaciones las ID de ESTUDIANTE, ALTERNATIVA y EVALUACIÓN. 

Aclarar que en el modelo relacional se editaron los nombres de los atributos de las tablas para evitar las redundancias y evitar errores en el DDL.

Una vez creadas las tablas con el DDL en SQL Developer, se crean o insertan los datos de 3 cursos, 2 de los cuales tendrán estudiantes asociados detallados en los "insert" de ESTUDIANTE y 1 no tendrá estudiantes para poder evaluar la pregunta número 4.

Se crean 5 evaluaciones, de las cuales solo las ID 1 y 2 se asocian a 10 preguntas con 4 alternativas cada 1. A la evaluacion ID 3 sólo se le crea una pregunta con 2 alternativas, a la evaluacion ID 4 se le crean 4 alterntivas (todas correctas) y a la evaluacion ID 5 no se le crean preguntas, todo lo anterior para evaluar las preguntas 1,2 y 3.

En el SQL se crea una tupla para la tabla PREGUNTA y las cuatro para la tabla ALTERNATIVA de manera seguida, todas con menos de 3 alternativas correctas, identificadas por un caracter 'v' o 'f' en el campo CALIDAD. 

Se deciden crear 4 grupos de alternativas solo con opciones correctas (se seleccionaron muy pocas alternativas correctas) para cada pregunta y no se consideró la omisión de preguntas. En la tabla RESPUESTAS se asocia la ID ESTUDIANTE (1,3,8,11,13) con el grupo 1 con todas las ID ALTERNATIVA correctas necesarias en cada pregunta, tanto para EVALUACION ID 1 y 2. Para  ID ESTUDIANTE (2,4,6,12,14) se asocia el grupo 2 con 29 ID's de ALTERNATIVA's correctas (pero no todas las necesarias para considerar el 100% del puntaje de una pregunta) y 2 ID's de ALTERNATIVA's incorrectas. Para  ID ESTUDIANTE (7,8,9,16,17,19,20) se asocia el grupo 3 con 11 ID's de ALTERNATIVA's correctas (pero no todas las necesarias para considerar el 100% del puntaje de una pregunta) y 9 ID's de ALTERNATIVA's incorrectas. Por ultimo para  ID ESTUDIANTE (5,10,15,18) se asocia el grupo 4 con 21 ID's de ALTERNATIVA's correctas (pero no todas las necesarias para considerar el 100% del puntaje de una pregunta) y 10 ID's de ALTERNATIVA's incorrectas. 

Las pregruntas se resolveiron usando las consultas select y para ciertos requerimientos primero se crearon vistas para luego ser utilizadas en otras consultas.

En específico la pregunta 3.C esta mostrando las evaluaciones con preguntas que tengan las 4 alternativas correctas, pero cambiando la condicion where alternativa.calidad = 'v' a where alternativa.calidad = 'f'.

En el caso de la pregunta 5, solo se muestra que preguntas fueron respondidas correctamente en su totalidad mediante el uso de un "case" el cual evalua si el dato de la columna Puntaje Obtenido es igual o mayor al Puntaje Por Pregunta (puntaje total de alternativas correctas por pregunta) y genera una columna nueva llamada Calidad No Normal (puntaje no normalizado) en la cual asigna un varchar de 'buena' o 'mala'. 

Para la pregunta 6, primero es necesario crear una vista Puntaje Por Evaluacion que resume la sumatoria de puntajes de todas las preguntas de una evaluacion.Luego dicha vista permite crear otra vista NOTAS para conocer la nota de cada estudiante para cada evaluacion con una exigencia de 60%. Para ello dentro de esta vista se crea la columna NOTA con un "case" que evalúa si el puntaje obtenido se encuntra por sobre o bajo el 60% del puntaje ideal de una evaluacion.

Con la vista NOTAS luego se resuelven las preguntas 7 y 8 para conocer promedio curso determinado y estudiantes que aprueban por sobre 4.0

