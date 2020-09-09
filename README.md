# Prueba-N3-Awakelab
<h3>Manejo base de datos Oracle 11g </h3>

<b> Descripción del ejercicio </b>

Dado su gran desempeño en evaluaciones y su irremplazable participación durante las jornadas de bootcamp, Awakelab le ha encomendado el desarrollo de un nuevo proyecto que contempla la implementación de un nuevo modelo formativo. Para ello, se hace realmente necesario un sistema de evaluación del cumplimiento de las aprendizajes y desarrollo de competencias como uno de sus procesos internos.

Para ello, le hace llegar una pequeña descripción del como debe funcionar y más importante aún, que información se requiere obtener de dicho sistema. Cada evaluación consiste de 1 ó más preguntas con alternativas, sin embargo, para que este proceso sea más flexible, y para aumentar la dificultad de los problemas, uno de los requerimientos es que las preguntas, de las que consisten las evaluaciones, tengan una o más soluciones.

Ejemplo: “¿Cuál de las siguientes propiedades presenta el paradigma POO? 1 – Herencia 2 – Polimorfismo 3 – Ampliación de cupo automático.”

Para ello, un alto cargo de la institución le describe que considera necesario gestionar un TEST, el que debe contar con un identificador único, nombre, descripción, programa (por ejemplo, Programación FullStack Java Trainnie o Programación Android), la unidad a la que pertenece, además del autor y la fecha de creación. Cada TEST puede tener multiples PREGUNTAS, las que se identifican con un identificador único, un enunciado y un puntaje asociado, y a su vez, cada una de estas tiene múltiples ALTERNATIVAS posibles, las que tienen un identificador único, una descripción, y un valor lógico que señala si es o no una respuesta correcta, más un valor que indica el porcentaje que aporta esta alternativa (de ser una respuesta correcta) al puntaje total de la pregunta.

Por ejemplo, recogiendo el antes citado (sobre el POO), si la pregunta “¿Cuál de las siguientes propiedades presenta el paradigma POO?” tiene un puntaje asociado de 10 puntos, las 2 respuestas correctas podrían aportar el 50% de dicho puntaje cada una. Entonces, al seleccionar solo 2 de estas alternativas, el estudiante sumaría el 100% del puntaje de la pregunta.

Finalmente, las respuestas seleccionadas por los estudiantes que se enfrentan a cada evaluación, deben quedar guardadas de tal forma que quede registro de las respuestas seleccionadas por cada estudiante considerando el puntaje de cada respuesta.

Además considere todas las entidades, atributos y relaciones de modo de poder responder a las siguientes preguntas por medio de la creación de comandos SQL:

  1. Pregunta 1: Conocer el número de evaluaciones por curso. 
  2. Pregunta 2: Conocer los cursos sin evaluaciones. 
  3. Pregunta 3: Determinar las evaluaciones con deficiencia. Una evaluación es deficiente: a. Si no tiene preguntas. b. Si hay preguntas con 2 ó menos alternativas c. Si todas las alternativas son correctas o si todas las alternativas son incorrectas.
  4. Pregunta 4: Determinar cuántos alumnos hay en cada curso. 
  5. Pregunta 5: Obtener el puntaje no normalizado de cada evaluación. El puntaje no normalizado ha sido definido (requerimiento) como: P = buenas – malas/4. Si un alumno no contesta en una pregunta exactamente lo mismo que se ha definido como correcto, la pregunta cuenta como mala a menos que el alumno haya omitido.
  6. Pregunta 6: Obtener el puntaje normalizado, o sea, de 1,0 a 7,0. 
  7. Pregunta 7: Nombre de estudiantes de un curso determinado que aprueban una evaluación determinada (donde la nota de aprobación mínima es un 4,0).
  8. Pregunta 8: Nota promedio de los estudiantes de un curso determinado, para una evaluación de terminada.

Se espera lo siguiente:

- Modelo lógico en OracleDataModeler. - Modelo relacional en OracleDataModeler. - DDL generado por OracleDataModeler. Script SQL que registre al menos 2 evaluaciones, con 10 preguntas y 4 alternativas.
Script SQL que registre al menos 2 cursos de 10 estudiantes que respondan estas evaluaciones.
Script SQL que responda las preguntas enumeradas anteriormente.

<hr>

<h3> Método de solución </h3>

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

