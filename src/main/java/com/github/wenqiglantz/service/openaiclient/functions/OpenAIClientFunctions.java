package com.github.wenqiglantz.service.openaiclient.functions;

import com.github.wenqiglantz.service.openaiclient.model.response.ChatGPTResponse;
import com.github.wenqiglantz.service.openaiclient.model.request.ChatRequest;
import com.github.wenqiglantz.service.openaiclient.service.OpenAIClientService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import software.amazon.lambda.powertools.tracing.CaptureMode;
import software.amazon.lambda.powertools.tracing.Tracing;

import java.util.function.Function;

@Configuration
@ConfigurationProperties
@Slf4j
@RequiredArgsConstructor
public class OpenAIClientFunctions {

    private final OpenAIClientService openAIClientService;

    @Bean
    @Tracing(captureMode = CaptureMode.RESPONSE_AND_ERROR)
    public Function<ChatRequest, ChatGPTResponse> chat() {
        return (request) -> {
            return openAIClientService.chat(request);
        };
    }
}
