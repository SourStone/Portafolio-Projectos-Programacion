package com.desarrolloweb.academia.repository;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.desarrolloweb.academia.model.Calificacion;

public class CalificacionRepository implements CalificacionRepositoryIface{

    private List<Calificacion> calificaciones;
    private SecureRandom rdn = new SecureRandom();

    public CalificacionRepository() {
        calificaciones = new ArrayList<>();
        calificaciones.add(new Calificacion(4450L, "Estructuras de Datos", 4.8, 1, true, new Date(), "Algoritmos", "UA-565"));
        calificaciones.add(new Calificacion(8529L, "Humanidades 2", 3.5, 1, true, new Date(), "Humanidades", "AB-405"));
        calificaciones.add(new Calificacion(892L, "Fundamentos de Programación", 2.9, 0, true, new Date(), "Programación", "ZR-135"));
        calificaciones.add(new Calificacion(4306L, "Cálculo Diferencial", 4.1, 1, true, new Date(), "Matemáticas", "ES-678"));
        calificaciones.add(new Calificacion(6303L, "Matemáticas Discretas", 3.9, 2, true, new Date(), "Matemáticas", "WN-686"));
        calificaciones.add(new Calificacion(4954L, "Álgebra Lineal", 4.0, 3, true, new Date(), "Matemáticas", "MQ-289"));
        calificaciones.add(new Calificacion(6161L, "Sistemas de Información", 1.9, 5, true, new Date(), "Informática", "IS-778"));
        calificaciones.add(new Calificacion(764L, "Compiladores", 3.7, 0, true, new Date(), "Programación", "PS-238"));
        calificaciones.add(new Calificacion(7798L, "Gestión de Proyectos Informáticos", 4.8, 1, true, new Date(), "Administración", "CI-476"));
        calificaciones.add(new Calificacion(2461L, "Historia de Grecia", 3.9, 3, true, new Date(), "Cultura", "CQ-920"));         
    }

    @Override
    public List<Calificacion> obtenerTodos() {
        return calificaciones;
    }

    @Override
    public void guardar(Calificacion calificacion) {
        if (calificacion.getId()== null){
            calificacion.setId(rdn.nextInt(9000)+1000L);
            calificaciones.add(calificacion);
        }else{
            for (int i = 0; i < calificaciones.size(); i++){
                Calificacion cal=calificaciones.get(i);
                if (cal.getId().equals(calificacion.getId())) {
                    calificaciones.set(i,calificacion);
                    return;
                }
              }
        }
        
    }

    @Override
    public Calificacion obtenerPorId(Long id) {
        Calificacion calificacion=null;
        for (Calificacion cal : calificaciones) {
            if (id.equals(cal.getId())) {
                calificacion = cal;
                break;
            }
        }
        return calificacion;
    }

    @Override
    public void EliminarPorId(Long id) {
       for (int i =0; i <calificaciones.size(); i++){
        Calificacion cal=calificaciones.get(i);
        if (cal.getId().equals(id)) {
            calificaciones.remove(i);
            return;
        }
       }
    }

    

    
}