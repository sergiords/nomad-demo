package com.github.sergiords.nomaddemo;

import org.glassfish.jersey.server.ResourceConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class NomadConfiguration {

    @Bean
    public ResourceConfig getResourceConfig() {
        ResourceConfig resourceConfig = new ResourceConfig();
        resourceConfig.register(NomadResource.class);
        return resourceConfig;
    }
}
