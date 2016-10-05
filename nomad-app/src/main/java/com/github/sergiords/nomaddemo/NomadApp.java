package com.github.sergiords.nomaddemo;

import org.glassfish.jersey.server.ResourceConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class NomadApp {

    public static void main(String[] args) {
        SpringApplication.run(NomadApp.class, args);
    }

    @Bean
    public ResourceConfig getResourceConfig() {
        ResourceConfig resourceConfig = new ResourceConfig();
        resourceConfig.register(NomadResource.class);
        return resourceConfig;
    }
}
