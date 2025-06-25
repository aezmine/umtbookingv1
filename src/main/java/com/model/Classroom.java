package com.model;

public class Classroom {
    private int classroomId;
    private String name;
    private String location;
    private int capacity;
    private String status;

    public int getClassroom_id() {
        return classroomId;
    }
    public void setClassroom_id(int classroomId) {
        this.classroomId = classroomId;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }

    public int getCapacity() {
        return capacity;
    }
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
