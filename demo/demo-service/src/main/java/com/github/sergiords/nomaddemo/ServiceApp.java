package com.github.sergiords.nomaddemo;

import net.codestory.http.WebServer;

import java.io.IOException;

public class ServiceApp {

    public static void main(String[] args) throws IOException {

        String nodeName = System.getProperty("node.name");
        String nodeIndex = System.getenv("NOMAD_ALLOC_INDEX");
        Integer httpPort = Integer.valueOf(System.getenv("NOMAD_PORT_http"));

        new WebServer().configure(routes -> routes.get("/hello", (context) -> {

            System.out.println("Receiving request from " + context.query().get("from"));
            System.out.println("Sending response from " + nodeName + "#" + nodeIndex);
            return nodeName + "#" + nodeIndex;

        })).start(httpPort);
    }
}
