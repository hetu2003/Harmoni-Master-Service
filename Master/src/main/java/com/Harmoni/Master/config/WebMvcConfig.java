package com.Harmoni.Master.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Value("${upload.dir}")
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String fileLocation = "file:" + uploadDir.replace("\\", "/") + "/";

        // Serve uploaded event images at /assets/uploads/**
        registry.addResourceHandler("/assets/uploads/**")
                .addResourceLocations(fileLocation);

        // Serve profile images stored in classpath static (default banner, etc.)
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("classpath:/static/uploads/");
    }
}
