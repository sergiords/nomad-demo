package com.github.sergiords.nomaddemo;

import javax.inject.Singleton;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/")
@Singleton
public class NomadResource {

    @GET
    public String getHelloWorld() {
        return "hello world";
    }

}
