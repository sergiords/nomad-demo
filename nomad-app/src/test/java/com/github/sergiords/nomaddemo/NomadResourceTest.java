package com.github.sergiords.nomaddemo;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment= SpringBootTest.WebEnvironment.DEFINED_PORT)
@RunWith(SpringRunner.class)
public class NomadResourceTest {

    private final WebTarget webTarget = ClientBuilder.newClient().target("http://localhost:8080/");

    @Test
    public void should_get_hello_world() throws Exception {
        String result = webTarget.request().get().readEntity(String.class);

        assertThat(result).isEqualTo("hello world");
    }

}