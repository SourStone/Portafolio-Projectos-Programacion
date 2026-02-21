package com.desarrolloweb.academia.repository;

import java.util.List;

import com.desarrolloweb.academia.model.Calificacion;

public interface CalificacionRepositoryIface {

    public List<Calificacion> obtenerTodos();
    public void guardar(Calificacion calificacion);
    public Calificacion obtenerPorId(Long id);
    public void EliminarPorId(Long id);


    
}
