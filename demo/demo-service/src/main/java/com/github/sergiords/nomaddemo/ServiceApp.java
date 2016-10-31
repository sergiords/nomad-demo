package com.github.sergiords.nomaddemo;

import net.codestory.http.WebServer;

import java.io.IOException;
import java.util.Optional;

public class ServiceApp {

    public static void main(String[] args) throws IOException {

        String nodeName = System.getProperty("node.name", "N/A");
        String nodeIndex = Optional.ofNullable(System.getenv("NOMAD_ALLOC_INDEX"))
                .orElse("N/A");
        Integer httpPort = Optional.ofNullable(System.getenv("NOMAD_PORT_http"))
                .map(Integer::valueOf)
                .orElse(8080);
        String version = Optional.ofNullable(ServiceApp.class.getPackage().getImplementationVersion())
                .orElse("N/A");

        new WebServer().configure(routes -> routes.get("/hello", (context) -> {

            System.out.println("Receiving request from " + context.query().get("from"));
            System.out.println("Sending response from " + nodeName + "#" + nodeIndex);

            return "Node: " + nodeName + " - Instance: #" + nodeIndex + " - Version: " + version;

        })).start(httpPort);
    }
}
