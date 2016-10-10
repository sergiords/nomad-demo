package com.github.sergiords.nomaddemo;

import org.glassfish.jersey.client.ClientProperties;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import java.io.IOException;

public class BatchApp {

    private static final Client CLIENT = ClientBuilder.newClient()
            .property(ClientProperties.CONNECT_TIMEOUT, 1000)
            .property(ClientProperties.READ_TIMEOUT, 1000);

    public static void main(String[] args) throws IOException {

        String nodeName = System.getProperty("node.name");

        System.out.println("Sending request from " + nodeName);

        String response = CLIENT.target("http://192.168.99.1:8080/")
                .path("hello")
                .queryParam("from", nodeName)
                .request().get(String.class);

        System.out.println("Receiving response from " + response);
    }
}
