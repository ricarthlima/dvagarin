package br.com.vagarin.api.comment;

import lombok.Data;

@Data
public class CommentRequestDTO {
    // (Estamos assumindo que o DTO de criação e update é o mesmo)
    private String content;
}