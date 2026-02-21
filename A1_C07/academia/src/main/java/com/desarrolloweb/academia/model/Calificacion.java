package com.desarrolloweb.academia.model;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Calificacion {
    private Long id;
    private String asignatura;
    private double nota;
    private int faltas;
    private boolean validado;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fecha;
    private String departamento;
    private String token;

    public Calificacion() {
    }

    public Calificacion(Long id, String asignatura, double nota, int faltas, boolean validado, Date fecha,
            String departamento, String token) {
        this.id = id;
        this.asignatura = asignatura;
        this.nota = nota;
        this.faltas = faltas;
        this.validado = validado;
        this.fecha = fecha;
        this.departamento = departamento;
        this.token = token;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAsignatura() {
        return asignatura;
    }

    public void setAsignatura(String asignatura) {
        this.asignatura = asignatura;
    }

    public double getNota() {
        return nota;
    }

    public void setNota(double nota) {
        this.nota = nota;
    }

    public int getFaltas() {
        return faltas;
    }

    public void setFaltas(int faltas) {
        this.faltas = faltas;
    }

    public boolean isValidado() {
        return validado;
    }

    public void setValidado(boolean validado) {
        this.validado = validado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Override
    public String toString() {
        return String.format("{id: %04d, asignatura: %-30s, nota: %1.1f, faltas: %02d, departamento: %-15s, token: %6s}", 
            id, asignatura, nota, faltas, departamento, token);
    }

}