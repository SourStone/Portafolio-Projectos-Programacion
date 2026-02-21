package com.desarrolloweb.academia.controller;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.desarrolloweb.academia.model.Calificacion;
import com.desarrolloweb.academia.repository.CalificacionRepository;
import com.desarrolloweb.academia.repository.CalificacionRepositoryIface;

@Controller
@SessionAttributes("calificacion")
public class CalificacionController {

    private CalificacionRepositoryIface calificacionRepository = new CalificacionRepository();

    @GetMapping("/formulario")
    public String formulario(Model model) {
        Calificacion calificacion = new Calificacion();
        model.addAttribute("calificacion", calificacion);
        model.addAttribute("titulo", "Registro de nueva calificación");
        return "vistas/formulario";
    }
    
    @GetMapping("/modificar/{id}")
    public String formulario(@PathVariable Long id, Model model){
        Calificacion calificacion=calificacionRepository.obtenerPorId(id);
        model.addAttribute("calificacion", calificacion);
        model.addAttribute("titulo", "Registro de nueva calificación");
        return "vistas/formulario";
    }

    @PostMapping("/procesarform")
    public String procesarForm(@ModelAttribute Calificacion calificacion, Model model, SessionStatus status) {
        System.out.println("****"+calificacion);
        calificacionRepository.guardar(calificacion);
        status.setComplete();
        return "redirect:/listado";
    }

    @GetMapping("/listado")
    public String listadoCalificaciones(Model model) {
        List<Calificacion> calificaciones = calificacionRepository.obtenerTodos();
        model.addAttribute("titulo", "Listado de calificaciones");
        model.addAttribute("calificaciones", calificaciones);
        return "vistas/listado";
    }
    @GetMapping("/consulta/{id}")
    public String consulta (@PathVariable Long id, Model model){
        Calificacion calificacion = calificacionRepository.obtenerPorId(id);
        model.addAttribute("calificacion", calificacion);
        model.addAttribute("titulo", "Consulta de una calificacion");
        return "vistas/consulta";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminar( @PathVariable Long id, Model model){
        calificacionRepository.EliminarPorId(id);
        return "redirect:/listado";

    }


    @ModelAttribute("departamentos")
    public List<String> departamentos() {
        return Arrays.asList("Informática", "Idiomas", "Algoritmos", "Programación", 
            "Matemáticas", "Estadística", "Administración", "Humanidades", "Cultura", "Deporte");
    }
}