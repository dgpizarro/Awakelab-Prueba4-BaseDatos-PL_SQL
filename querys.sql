-- SOLUCION PREGUNTAS --

--Pregunta N1, Evaluaciones por curso:
select id_curso, sala_clases , count (id_evaluacion) as "Cantidad Evaluaciones" 
from curso 
left join eval_por_curso using (id_curso)
group by id_curso, sala_clases
order by id_curso;

--Pregunta N2, Cursos sin evaluaciones:
select id_curso, sala_clases , count (id_evaluacion) as "Cantidad Evaluaciones" 
from curso 
left join eval_por_curso using (id_curso)
group by id_curso, sala_clases
having count (id_evaluacion) = 0
order by id_curso;

--Pregunta N3.A, Deficiente con cero preguntas:
select evaluacion.id_evaluacion, nombre_evaluacion, count(pregunta.id_evaluacion) as "Cantidad Preguntas"
from evaluacion 
left join pregunta on (evaluacion.id_evaluacion = pregunta.id_evaluacion)
group by evaluacion.id_evaluacion, nombre_evaluacion
having count(pregunta.id_evaluacion) = 0
order by evaluacion.id_evaluacion;

--Pregunta N3.B, Deficiente con preguntas con 2 o menos alternativas:
select evaluacion.id_evaluacion, nombre_evaluacion, enunciado as "Pregunta", count(alternativa.id_pregunta) as "Cantidad Alternativas"
from evaluacion 
inner join pregunta on (evaluacion.id_evaluacion = pregunta.id_evaluacion)
left join alternativa on (pregunta.id_pregunta = alternativa.id_pregunta)
group by evaluacion.id_evaluacion, nombre_evaluacion, enunciado
having count(alternativa.id_pregunta)<=2
order by evaluacion.id_evaluacion;

--Pregunta N3.C, Deficiente con preguntas con 4 alternativas correctas o 4 alternativas incorrectas (solo varia condicion having)
select evaluacion.id_evaluacion, nombre_evaluacion, pregunta.id_pregunta as "NumPregunta", enunciado as "Pregunta", 
count(alternativa.calidad ) as "Alternativas Correctas"
from evaluacion 
left join pregunta on (evaluacion.id_evaluacion = pregunta.id_evaluacion)
left join alternativa on (pregunta.id_pregunta = alternativa.id_pregunta)
where alternativa.calidad = 'v'
group by evaluacion.id_evaluacion, nombre_evaluacion, enunciado,  pregunta.id_pregunta
having count(alternativa.id_pregunta)=4
order by evaluacion.id_evaluacion, pregunta.id_pregunta;

--Pregunta N4, Estudiantes por curso:
select id_curso, sala_clases , count (id_estudiante) as "CantidadEstudiantes" 
from curso 
left join estudiante using (id_curso)
group by id_curso, sala_clases
order by id_curso;

--Pregunta N5, Solo parte de detección de pregunta buena o mala segun criterio de no normalizado
select respuestas.id_estudiante, respuestas.id_evaluacion, pregunta.id_pregunta, puntaje as Puntaje_Por_Pregunta, 
sum (round (pregunta.puntaje * alternativa.ponderacion)) as Puntaje_Obtenido,
case 
when (sum(round (pregunta.puntaje * alternativa.ponderacion)) >= puntaje)
then 'buena'
else 'mala'
end
as Calidad_No_Normal
from respuestas
inner join alternativa on (respuestas.id_alternativa = alternativa.id_alternativa)
inner join pregunta on (alternativa.id_pregunta = pregunta.id_pregunta)
group by respuestas.id_estudiante, respuestas.id_evaluacion, pregunta.id_pregunta, puntaje
order by id_estudiante, id_evaluacion, id_pregunta;

--Pregunta N6, Puntaje normalizado con exigencia de 60%:

-- Vista de Puntaje por evaluacion, utilizada en vista Notas
create view PUNTAJES_POR_EVAL
as
select id_evaluacion, sum (puntaje) as PUNTAJE_TOTAL_EVAL
from pregunta 
inner join evaluacion using (id_evaluacion)
group by id_evaluacion
order by id_evaluacion;

--Vista Notas, nota para cada estudiante, por cada evaluacion
create view NOTAS
as
select respuestas.id_estudiante, respuestas.id_evaluacion, puntajes_por_eval.puntaje_total_eval,
sum (round (pregunta.puntaje * alternativa.ponderacion)) as PUNTAJE_OBTENIDO,
case 
when ((sum(round(pregunta.puntaje * alternativa.ponderacion))) >= (0.6* puntajes_por_eval.puntaje_total_eval))
then (round((3* ((sum(pregunta.puntaje * alternativa.ponderacion)- (puntajes_por_eval.puntaje_total_eval*0.6))/
(puntajes_por_eval.puntaje_total_eval*0.4))),1)+4)
else (round((3* ((sum(pregunta.puntaje * alternativa.ponderacion))/(puntajes_por_eval.puntaje_total_eval*0.6))),1)+1)
end
as NOTA
from respuestas
inner join alternativa on (respuestas.id_alternativa = alternativa.id_alternativa)
inner join pregunta on (alternativa.id_pregunta = pregunta.id_pregunta)
inner join  puntajes_por_eval on (pregunta.id_evaluacion =  puntajes_por_eval.id_evaluacion)
group by respuestas.id_estudiante, respuestas.id_evaluacion, puntajes_por_eval.puntaje_total_eval
order by id_estudiante, id_evaluacion;

--Pregunta N7, Estudiantes que aprueban con nota >=4.0, para curso y evaluacion determinada
select DISTINCT curso.id_curso, estudiante.id_estudiante, estudiante.nombre_estudiante, respuestas.id_evaluacion,
notas.nota
from curso
inner join estudiante on (curso.id_curso = estudiante.id_curso)
inner join respuestas on (estudiante.id_estudiante = respuestas.id_estudiante)
inner join notas on (respuestas.id_estudiante = notas.id_estudiante)
where notas.nota >= 4.0 and respuestas.id_evaluacion = 1 and  curso.id_curso = 1
order by id_estudiante, id_evaluacion;

--Pregunta N8, Nota promedio para curso y evaluacion determinada
select DISTINCT eval_por_curso.id_curso, eval_por_curso.id_evaluacion ,  avg(notas.nota)
from curso
inner join eval_por_curso on (curso.id_curso = eval_por_curso.id_curso)
left join notas on (eval_por_curso.id_evaluacion  = notas.id_evaluacion)
where  curso.id_curso = 1 and notas.id_estudiante between 1 and 10
group by  eval_por_curso.id_evaluacion, eval_por_curso.id_curso
order by  id_evaluacion;



