package com.dar.cicd.pipelinedemo.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {

    @GetMapping("/pipeline")
    public String getName(){
        return "CI/CD Pipeling Got Success";
    }
}
